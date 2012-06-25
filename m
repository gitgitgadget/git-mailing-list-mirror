From: Thomas Badie <thomas.badie@gmail.com>
Subject: Re: [PATCH] git-add--interactive.perl: Remove two unused variables
Date: Mon, 25 Jun 2012 12:16:15 +0200
Message-ID: <CAFjFENqrGreepYXM3DrDiYEsau9-vM-qmf8KvqrNNjdCS-adjg@mail.gmail.com>
References: <4FE7889E.2020009@gmail.com>
	<7vfw9khrrt.fsf@alter.siamese.dyndns.org>
	<87txxzu55d.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jun 25 12:16:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj6LE-0008Mo-I2
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 12:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842Ab2FYKQQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jun 2012 06:16:16 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:54749 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189Ab2FYKQQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2012 06:16:16 -0400
Received: by qadb17 with SMTP id b17so1267336qad.19
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 03:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=vyzkewVCjolBEFHQ8bQ5yOgK0qxU6DSId36Lib3nYZc=;
        b=P1DeA26EHCuW2AvUVrgZBIjrXYwd8jXExfbuhUZHGS5nOPCpXjD9rw0yfz44PClcRw
         NDF/y6zo5vKRh6tnrCVykQ/Wky9APoqYj5YsERdB2VeLONFAvj1/ovLoLBlTxv3wpPng
         n8Uw3z4/j0Maa9GUypwbAthUd/THOMJ1uGtQhVtvBHP0ufYWj/rs8bqITUn1EQbwoYee
         LNYCSC7wHojtjBMEMwXkBTZtM4ZSjzL/M0e36DJty666IYR9hQJ8dSVyqug25H4RFjl8
         KHzzjI5ViKqO1U8Y8aWrKo9U5PjlDJn80PUKrW//qFnWL4A9NOqMaNiJBWG6sf5dleH+
         DOyg==
Received: by 10.224.184.82 with SMTP id cj18mr19840681qab.81.1340619375473;
 Mon, 25 Jun 2012 03:16:15 -0700 (PDT)
Received: by 10.224.4.39 with HTTP; Mon, 25 Jun 2012 03:16:15 -0700 (PDT)
In-Reply-To: <87txxzu55d.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200563>

2012/6/25 Thomas Rast <trast@inf.ethz.ch>:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> "Thomas \"Enki\" Badie" <thomas.badie@gmail.com> writes:
>>
>>> The patch 8f0bef6 refactors this script and leaves the `$fh' variab=
le
>>> unused in `diff_applies' and `patch_update_file'.
> [...]
>> =A0(2) the author of the problematic commit should have been Cc'ed
>> =A0 =A0 =A0(especially when he is still an active participant on the=
 list)
>> =A0 =A0 =A0to give him a chance to Ack it (I'm adding Thomas for thi=
s).
>
> Indeed, my bad. =A0It's easy to verify from 'git show 8f0bef6' that t=
his
> was an oversight in my patch.
>
> Acked-by: Thomas Rast <trast@student.ethz.ch>

It happens to everyone^^ Thanks for your answer.

Should I repost a patch V2 or it is okay like this?
Thanks

--=20
Thomas "Enki" Badie
