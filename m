From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2015, #01; Tue, 1)
Date: Wed, 02 Dec 2015 16:13:04 -0800
Message-ID: <xmqqk2ow4cfj.fsf@gitster.mtv.corp.google.com>
References: <20151202002450.GA27994@sigill.intra.peff.net>
	<xmqq4mg05wmj.fsf@gitster.mtv.corp.google.com>
	<20151202223114.GA20542@sigill.intra.peff.net>
	<xmqqoae84eci.fsf@gitster.mtv.corp.google.com>
	<20151203000705.GA22067@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 03 01:13:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4HWQ-0000Cf-JZ
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 01:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757443AbbLCANO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 19:13:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50015 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756518AbbLCANN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 19:13:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7378730CAB;
	Wed,  2 Dec 2015 19:13:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lDW4UjqbAdWvi7q/JyHUd4SwyHw=; b=QSHGLL
	aZNnoQgpjZnO5WvETNGn61CqxngtOTTZZdxkEd4Hp3/GaJQIEFUkmu4o0Ikt5BLG
	wkIhCC/fSYFMrrnflZjjECnAuONDBcZKKeMWJoqZXtmeLmbq9KHMU9PSIy90f1A5
	f+YQSt6NOy4VGSztl8yqd6MmKXKsP+L1G4T+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XpqKe3vvm0CRcq9FJ+0M606p5Me8zX2Q
	H5A8wq0KRp3lOObgTp9C8DWz7Bc42+Qg7+3R259rOSA5ftNxue0E8UAtAhNkOXho
	pPeFEiNTFFJYOod/+gksHiC0lk4e+mEFY3R0T8RrDHq89LR2LdcK84X4MqixcLAu
	hK754eBXSUg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 63CC430CAA;
	Wed,  2 Dec 2015 19:13:12 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D27D430CA8;
	Wed,  2 Dec 2015 19:13:05 -0500 (EST)
In-Reply-To: <20151203000705.GA22067@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 2 Dec 2015 19:07:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A0331738-9952-11E5-BEA3-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281923>

Jeff King <peff@peff.net> writes:

> On Wed, Dec 02, 2015 at 03:31:41PM -0800, Junio C Hamano wrote:
>
>> I just finished my first pass of going through "cook -w" output and
>> had trouble judging jk/send-email-ssl-errors topic, which is marked
>> as "waiting for re-roll", but I cannot seem to find any discussion
>> on it, just the original patch $gmane/281655.  Are there concerns?
>
> Looks like it needs a slight tweak:
>
>   http://article.gmane.org/gmane.comp.version-control.git/281693
>
> -Peff

Thanks.  I added a note to myself after the "waiting for re-roll"
comment to remind me.
