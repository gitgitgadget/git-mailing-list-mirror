From: Junio C Hamano <gitster@pobox.com>
Subject: Re: .gitignore behavior on Mac
Date: Sun, 19 May 2013 00:47:05 -0700
Message-ID: <7vd2snza12.fsf@alter.siamese.dyndns.org>
References: <CAEe6bfD_1GjMBByaEFQ4RMTMaz8XZvd00mxyfaAHtXVpbUjj6A@mail.gmail.com>
	<20130518184136.GH27005@serenity.lan>
	<CAEe6bfB30aD0LcgR4fzLy=xJGwzASJpgfvvtoTmFmJ1_2HZ4Jg@mail.gmail.com>
	<20130518185507.GI27005@serenity.lan> <5197EC19.8080806@kdbg.org>
	<CAEe6bfC6F3sN_OXZYo1=bdwo01_7qFUEmbSWVFNaFZQrZUGdWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, John Keeping <john@keeping.me.uk>,
	git@vger.kernel.org
To: Peter Lauri <peterlauri@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 09:47:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdyKo-000830-C9
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 09:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193Ab3ESHrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 03:47:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44526 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751882Ab3ESHrI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 03:47:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E88581BB53;
	Sun, 19 May 2013 07:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zyzu3Bq4lENbp96Xuo2inYWHqs0=; b=eveESi
	DUkqkn94pO8Ob+CaH1aNyMsv+Yl7fOYMde54bcpA/zxfjYJcCHlNTFHqmTSM9t+k
	MFbxDMUZV79GuJ39YxAA+QYBNiDFfiKPPCBvmzrfba3DDiEhRN/yg/lvk5QlPzQL
	nZJo/YBuzl6gm51YV3MQVaBzUNExLhsw1UlOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w742s5Q59UAz8HN5Oho8sYj+gRtIloRP
	vfJ2REn9ehryvNLxmGx3Ogk6H8konrVttpzJs9Xvsf/nftEstSAXGKRDdhh3mnGf
	wYIDJU/Mr96IsRppl/k8iktypOJJlPLwjPfCNd3vbbbRSvnySgfFKu+Oen0NwYNl
	v0ynpZvoWJ8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DEE5C1BB52;
	Sun, 19 May 2013 07:47:07 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 665471BB50;
	Sun, 19 May 2013 07:47:07 +0000 (UTC)
In-Reply-To: <CAEe6bfC6F3sN_OXZYo1=bdwo01_7qFUEmbSWVFNaFZQrZUGdWA@mail.gmail.com>
	(Peter Lauri's message of "Sun, 19 May 2013 00:37:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4E16C204-C058-11E2-AB98-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224826>

Peter Lauri <peterlauri@gmail.com> writes:

> Great, I have gotten the concept now :)
>
> My workaround for my problem is to rename the file to ....default and
> then all will work out well :) Copy the file then and locally modify
> it, but it will be in .gitignore so not tracked :)

I think it is not even an workaround but is a solid software
configuration practice that is recommended.
