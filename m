From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to fetch entire heirarchy of refs from a remote?
Date: Thu, 07 Jan 2016 15:15:59 -0800
Message-ID: <xmqqpoxd2d74.fsf@gitster.mtv.corp.google.com>
References: <CA+P7+xqexsOma5c9NfS5ma333UJV=5i1a4GhnwZuU75eaxRd=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git mailing list <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 00:16:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHJmq-0001dP-6J
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 00:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783AbcAGXQD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 18:16:03 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63420 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752189AbcAGXQC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 18:16:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 684303A49D;
	Thu,  7 Jan 2016 18:16:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p+bGqrCDAp66mWVfRZLlalslnWY=; b=m04x/w
	o9YwdantrFSUCbNQROubZXSmCEE82Vz5+DSkGek0sIyBScavrguvNoszjRNQ8S6A
	uzsDXY+O49NNPUa0ePf1kIvdLdf4zaaQPnCykgKTsg8Q4tl3iG2nwnbye9+Oi4K3
	M1ogoEmuGPvGo/BTj+4aKo+70vn783Gdall/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N9jdnHYuiKp7f7zjzaUGCCdN0EYBfiLE
	4Eavkoih2qrGWISLmkKBmcwX21tfJloDMLS3gHVhmM8EfFRrohbeJEouEoDDFWKY
	ZORWZgRV+ViZCGSBUCebrLPl+s0bBKxHF1/n3xPMW1mVTUv8jnFN1w0nFWz3SEHd
	duBJCBsL9ms=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 456F13A49C;
	Thu,  7 Jan 2016 18:16:01 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6D7C03A49B;
	Thu,  7 Jan 2016 18:16:00 -0500 (EST)
In-Reply-To: <CA+P7+xqexsOma5c9NfS5ma333UJV=5i1a4GhnwZuU75eaxRd=Q@mail.gmail.com>
	(Jacob Keller's message of "Thu, 7 Jan 2016 15:06:00 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9D5E078A-B594-11E5-B883-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283515>

Jacob Keller <jacob.keller@gmail.com> writes:

> refs/changes/98/47298/3
> refs/changes/98/57298/1
> refs/changes/98/57298/2
> refs/changes/98/73598/1
> refs/changes/99/44099/1
> refs/changes/99/69299/1
>
>
> Is it possible to specify a refspec such that all of these will be
> fetched? I tried doing
>
> +refs/changes/*:refs/changes/*
>
> but this doesn't work since the * can only be one portion of a refspec

I am not sure if I follow.  With refs/heads/*:refs/remotes/origin/*
(e.g. following git://github.com/gitster/git for example), I am
reasonably sure you would get my refs/heads/jk/notes-dwim-doc and
other topics you authored without the slash between jk and
notes-dwim-doc getting in the way.
