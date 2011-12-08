From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 15/15] t3040 (subprojects-basic): modernize style
Date: Thu, 8 Dec 2011 18:34:39 +0530
Message-ID: <CALkWK0mScWsQanBu=cq-qiC3Ls=bYnjA4eiY4mUFs+kr9_OHdQ@mail.gmail.com>
References: <20111207100858.GB13374@elie.hsd1.il.comcast.net>
 <1323286611-4806-1-git-send-email-artagnon@gmail.com> <1323286611-4806-16-git-send-email-artagnon@gmail.com>
 <20111207222126.GF2911@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 14:05:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYdet-0001ux-0W
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 14:05:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454Ab1LHNFB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Dec 2011 08:05:01 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:33984 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289Ab1LHNFA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Dec 2011 08:05:00 -0500
Received: by qadb15 with SMTP id b15so1642929qad.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 05:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=vmLo29sM7JJCr7KAXqgzJPLqp20eUEnBQtKzI34Sdy8=;
        b=ZnN6AmU1u8oT33mMlEfKVK//2ZVjMB71nNS+Ygk8qzmgjt2N9sru2x9qsx2Yx8Hvo2
         y1w1ItMSEkuTgVXKZI53Rc0ZQuFOYr7KaM+tnxGO0eUIbmwQgE2bWZ/571uO2GVF7MSZ
         tqfy6EaG79UITlW3y0cjxcQ8fDRuDSDj6mqDE=
Received: by 10.224.198.10 with SMTP id em10mr2683936qab.44.1323349500200;
 Thu, 08 Dec 2011 05:05:00 -0800 (PST)
Received: by 10.229.165.194 with HTTP; Thu, 8 Dec 2011 05:04:39 -0800 (PST)
In-Reply-To: <20111207222126.GF2911@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186551>

Hi,

Jonathan Nieder wrote:
> It would be easier to read if each preimage test assertion were next =
to
> the corresponding postimage test assertion. =C2=A0Does "git diff --pa=
tience"
> do better?

No, unfortunately.

> If cleaning up the style anyway, I would write this as
> [...]
> But leaving it alone like you did is probably better. ;-)

Exercising restraint.  Otherwise, I'm tempted to fix every little nit
in every test I'm touching in the series :P

>> -test_expect_success 'check if fsck ignores the subprojects' \
>> - =C2=A0 =C2=A0'git fsck --full'
>> +test_expect_success 'check if fsck ignores the subprojects' '
>> + =C2=A0 =C2=A0 git fsck --full
>> +'
>
> Does this test imply that one of the subprojects is broken somehow?

Hm, you're right- the test doesn't seem to make any sense.  I'll deal
with it in another patch (unrelated to this series).

Thanks.

-- Ram
