From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Cooking of the ab/i18n series
Date: Sat, 7 Aug 2010 01:13:47 +0000
Message-ID: <AANLkTimvNgZ4UU595==Tx5i0LYF56ecNzvYWki0FM3u6@mail.gmail.com>
References: <AANLkTi=bnDgUsnBCv5493sH9eY5hg0S2YPywKba9jD20@mail.gmail.com>
	<7vzkx0bt4w.fsf@alter.siamese.dyndns.org>
	<AANLkTim1G=wjAgts_BvjwU8_B1wqrUEQHWbP_MY=cJa9@mail.gmail.com>
	<7vmxszamwd.fsf@alter.siamese.dyndns.org>
	<AANLkTimooDYBW3N0qV4G2JKSvcdWiCVRj3WjuoO+CJ54@mail.gmail.com>
	<7viq3nagje.fsf@alter.siamese.dyndns.org>
	<AANLkTimJCgZ8kU0Nrm6Zi-PXSgT96bFfTi0oaaX2t-6v@mail.gmail.com>
	<AANLkTik1KVpb25nuwSFA2z4ezRJKWdTwRrS_KXzwM+2D@mail.gmail.com>
	<7viq3n73c6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 07 03:14:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhXzB-0008OY-L5
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 03:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365Ab0HGBNu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 21:13:50 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53699 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298Ab0HGBNs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Aug 2010 21:13:48 -0400
Received: by fxm14 with SMTP id 14so4192197fxm.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 18:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aE33zsHwsbGMowKQJuJ8PzA+FQNLk4mBo3bvD/dNk7g=;
        b=rIuIfhgymH3AwD75lnoVWd6756y9mxiLzQvmTdbZYI+aoBbQRKTEcXaBKnuGdlmQpu
         N1Tv2Ulpa/uIRMBRz0ICEyS2I+ZHPrMbcjGgTRahatyRkvVqRn2gURf7lqp0HrOmSLgN
         YohFEDlB3afMvkH9dtKwYuued9sunOGHCf1Sk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=G0PVJLFKUcHo974HaLK9ot9prvj7aKa3yBEwks1DmDFe9e0wlNF0V9eSRtG9+2etkJ
         zWZ0WaHimPuKkAKf7ofPXuI5/avx/u7zBjlY3BiNNNU8CHVKqe32TYI6OPRglxlEeIrM
         1iA+Q3KR0ZVufFQWoe0rzIyBbAvxkZryk1//Q=
Received: by 10.223.122.208 with SMTP id m16mr13618929far.88.1281143627274; 
	Fri, 06 Aug 2010 18:13:47 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Fri, 6 Aug 2010 18:13:47 -0700 (PDT)
In-Reply-To: <7viq3n73c6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152833>

On Fri, Aug 6, 2010 at 23:01, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> My mental plan for this series has basically been as follows:
>>
>> =C2=A0 1. Get it to a state where it can cook in pu [You Are Here]
>>
>> =C2=A0 2. After it's been there for a while get it to master
>>
>> =C2=A0 3. Once it's there for a while and we're sure the new depende=
ncy /
>> =C2=A0 =C2=A0 =C2=A0code doesn't harm some more obscure systems..
>>
>> =C2=A0 4. Start submitting patches to the main porcelain $(grep
>> =C2=A0 =C2=A0 =C2=A0'mainporcelain common' command-list.txt) to make=
 the most common
>> =C2=A0 =C2=A0 =C2=A0user-visible messages translatable.
>>
>> =C2=A0 5. Recruit translators to translate the strings in #4. Send
>> =C2=A0 =C2=A0 =C2=A0translations in as patches adding/altering the *=
=2Epo files.
>
> Matches my expectations modulo s/master/next/.

Yes, I meant to say "on track to master" (via next).

> The stuff parked in 'pu' was primarily because most of the work to
> get to this point was done during the pre-release freeze for 1.7.2
> and I didn't want to get distracted, while I obviously did not lose
> patches.

I didn't mean to rush you, the delay is fine. It just sounded like the
series might be stuck in pu in perpetuity from the initial "When
people see the benefit of doing so" comment.

But if not, nevermind.

>> Now, your main concern is that this doesn't break plumbing output...=
=2E
>
> That's not 'main'.
>
> 'Breaking plumbing' is merely an example of a larger 'main concern' w=
hich
> is 'unintended consequences'.

Sure, all code's going to have problems, and the ab/i18n series is
around 1300 lines, so I'd be quite surprised if it didn't have some
bug.

> And please don't ask me to enumerate them exhaustively. =C2=A0By defi=
nition
> 'unintended consequences' cannot be enumerated. =C2=A0They are discov=
ered over
> time either by code inspection, by people guinea-pigging a version ou=
tside
> 'master', and by careful thinking.

I was just wondering if there was anything particular that you were
worried about that could be addressed.

But as you've clarified there's nothing about it that I should be
explicitly addressing before it can move forward (if I've understood
you correctly).

Thanks for clarifying that and for your time.
