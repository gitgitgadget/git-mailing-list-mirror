From: Miles Bader <miles@gnu.org>
Subject: Re: Consistent terminology: cached/staged/index
Date: Tue, 15 Feb 2011 07:07:03 +0900
Message-ID: <AANLkTinnCLVDEZpNPVYZ2fq1BY=257BTxkzNj44-Yz3O@mail.gmail.com>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
 <20110213193738.GA26868@elie> <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
 <87k4h34bhj.fsf@catnip.gol.com> <7vr5bbupj4.fsf@alter.siamese.dyndns.org>
 <AANLkTi=PDhVgpTeFjTxFuVJGbAKTHzHhsNVcquqSD3Qq@mail.gmail.com>
 <4D58D2DF.1050205@viscovery.net> <AANLkTikTfyHBOvQmjhT8yTziL4R67+AAk0O-Nk1tBSaL@mail.gmail.com>
 <4D5906FD.7030502@drmicha.warpmail.net> <buod3muswq7.fsf@dhlpc061.dev.necel.com>
 <7vtyg6tu9e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 23:07:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp6aF-0002jW-Ek
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 23:07:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934Ab1BNWHr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Feb 2011 17:07:47 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57845 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223Ab1BNWHq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 17:07:46 -0500
Received: by bwz15 with SMTP id 15so5966026bwz.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 14:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=6jy/QxFtaWxCOnzJZie8s3OWVxlm81RCQfMQqxZQafc=;
        b=mf1DBA4dihjjwTdzNkojYedT4lIlN699s2kXWMM1ecTmISq/CiebMbPHHC9UZHDdfF
         6eJf8nuQePiPGIKOCuhhEIlgbWhbjjBF7PbVChJT6omZMSAFuSccDR2pyawvdJxpUhSZ
         SgZSaPjztW2SmKIeUE5/GBzWi6YakwBbbw2mw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=vMwo1IWOXL3dBYk3rOjroQBlNX71KeB7Zeu3JHCryZ8OVQdKWqUBmL+csGZxAEGY25
         SsELpjDigRkDO8a8ulwzy8XhOfuS3RKY+xsM1Gzl0JDFTjtKK8ZZuyu6AhSBox4ZSD0I
         s/sYWHREj0e6/R09Oxz4WJfdPtZfIuS3ctn74=
Received: by 10.204.79.135 with SMTP id p7mr7190318bkk.109.1297721264763; Mon,
 14 Feb 2011 14:07:44 -0800 (PST)
Received: by 10.204.119.130 with HTTP; Mon, 14 Feb 2011 14:07:03 -0800 (PST)
In-Reply-To: <7vtyg6tu9e.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: j-mtOENmzsRdgvydPIgdI0Ij3cQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166782>

On Tue, Feb 15, 2011 at 2:12 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Miles Bader <miles@gnu.org> writes:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>> Short options should really not be "wasted" easily. "-s" named afte=
r "to
>>> stage" is really problematic, as outlined in this thread.
>>
>> Er, but the point is that this is _such_ a common operation, that a
>> short option for it would not be "wasted" at all.
>
> True, but I am afraid "-c" is not it, as it would certainly be confus=
ing
> to users who know what "diff" does before they learn "git diff".

Er...?

Here we were talking about using "-s" (inspired by "--staged"), which
I suggested because you earlier objected to "-c"...

-miles

--=20
Cat is power. =A0Cat is peace.
