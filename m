From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Command-line interface thoughts
Date: Thu, 09 Jun 2011 12:40:19 -0700
Message-ID: <7v4o3yyesc.fsf@alter.siamese.dyndns.org>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
 <m339jps1wt.fsf@localhost.localdomain>
 <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
 <201106051311.00951.jnareb@gmail.com>
 <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
 <7vwrgza3i2.fsf@alter.siamese.dyndns.org> <4DF08D30.7070603@alum.mit.edu>
 <20110609161832.GB25885@sigill.intra.peff.net>
 <BANLkTinyYjXeg_khoU1dJVenP0mO2++hsw@mail.gmail.com>
 <7vd3imykj1.fsf@alter.siamese.dyndns.org>
 <BANLkTikLWuENTpCF9BXPJWawLUpKW0077A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 21:40:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUl69-0005Gr-F8
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 21:40:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343Ab1FITkl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2011 15:40:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33412 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755295Ab1FITkj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2011 15:40:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 98A495FFC;
	Thu,  9 Jun 2011 15:42:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=d9ldnCvYd9Jr
	GP0DYPUakOdoyDA=; b=DoM7gVaQwVnIe/ujxZX1VtHanqp0agYgFORyVyDATQoB
	arGF2p5z5vXZ5/12Zyy0B0XTpzXSksKM+RFNFerRIaO31M4m/omiz69UYWSIEcmC
	8LGtoXDorOrjpJZcjVeVc2aA7SYboO9QjbYzA9JHdAU8d2pOwcodwzCYZCrosNU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WTCulN
	L9Pu8y2K6jLipXA2Sn4Hdhh93TpoN9fVf486HuhS2S3wYkeYk1yO/NTa3RXYDEdi
	t1OfHLarN8x0TK+3lt8LzBGxkWV/M1V3MgJKtSS0Ji1IixjRiQh/vzhQYbvas1Pv
	n7on9ui7XBuGKlMCM9VjpX8afwc4jpqSW7tQk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 25AA65FF6;
	Thu,  9 Jun 2011 15:42:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0ED775FDE; Thu,  9 Jun 2011
 15:42:30 -0400 (EDT)
In-Reply-To: <BANLkTikLWuENTpCF9BXPJWawLUpKW0077A@mail.gmail.com> (Jay
 Soffian's message of "Thu, 9 Jun 2011 14:20:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A2A47F8A-92D0-11E0-871F-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175568>

Jay Soffian <jaysoffian@gmail.com> writes:

>> =C2=A0# what does the result look if I said "commit -a" now?
>> =C2=A0$ git diff HEAD
>
> I never use commit -a.

Well I said 'commit -a' only so that any newbie can understand what I
meant, and certainly didn't mean to suggest you to use 'commit -a'.  Yo=
u
can rephrase it as: "Now I _think_ I have good state in my working tree=
;
what is the change since HEAD, i.e. the result of the merge?".


>> =C2=A0# I want to also see comparison with the original
>> =C2=A0$ git checkout --conflict=3Ddiff3 <conflicted paths>...
>> =C2=A0$ git diff
>
> I have merge.conflictstyle diff3 in my .gitconfig.

Good for you.

> ...
> Now that's one I haven't used before.

Surely there is room for everybody to learn something every day ;-).
