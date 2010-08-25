From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] Makefile: Add help target
Date: Wed, 25 Aug 2010 14:36:49 -0700
Message-ID: <AANLkTimSP=4bMwN_DAuDoaG5mGACYJYp2TTyDKSFY5BF@mail.gmail.com>
References: <1282729913-25114-1-git-send-email-bebarino@gmail.com> <AANLkTi=+f4Q6JJHfX75A57-gzBxqsdr+CrCf9Z9fqrEq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 23:37:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoNex-0007fm-Sv
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 23:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754430Ab0HYVhH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 17:37:07 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50618 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663Ab0HYVhF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Aug 2010 17:37:05 -0400
Received: by wyb35 with SMTP id 35so1203567wyb.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 14:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ZEjuqCD//wFMa6uSRVI6ahJusxlr8QCFvUpGzbi+sAU=;
        b=aNR/RM5s9oocUN95MMXl5kWoL7uvSYRSf1l6wmrFyofCgW8/LglTtXWRBOADp95w0/
         RlpN+Lp/WFrEDkMCCluemmpigrk5m0/IylgEr+vbn1HwVacaEXfudR7uSI+CtK0CG3E9
         tTzBitF1GJbM2PQPikofESjrsVVXTHESwC1XY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=nqPjqJQMFRnbPwIJ8RnWxPOPU4qpYT1xcg4xvnnmsr57nKWzW4L+vwf0LRHK8zXdBI
         bPDhLskmocv+PV8l5EkoHg0e1Nm0UNwCtqqlQ/yEurxQmtwlMbZzLQ6O4VJZzPaCTNni
         f5Kof/JjfliLXBSjjNAXPISJ3n2LNmy37dqaM=
Received: by 10.227.133.139 with SMTP id f11mr7849525wbt.132.1282772224317;
 Wed, 25 Aug 2010 14:37:04 -0700 (PDT)
Received: by 10.227.131.208 with HTTP; Wed, 25 Aug 2010 14:36:49 -0700 (PDT)
In-Reply-To: <AANLkTi=+f4Q6JJHfX75A57-gzBxqsdr+CrCf9Z9fqrEq@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154478>

Hey Sverre,

On Wed, Aug 25, 2010 at 9:27 AM, Sverre Rabbelier <srabbelier@gmail.com=
> wrote:
> Heya,
>
> On Wed, Aug 25, 2010 at 04:51, Stephen Boyd <bebarino@gmail.com> wrot=
e:
>> Today I forgot whether the target was quick-install-doc or
>> install-quick-doc and had to open the Makefile again to find out. I'=
d
>> rather not do that and just use:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ make help
>>
>> to get a quick summary of the interesting targets when my brain fail=
s to
>> refresh. Add a help target, but don't add uninteresting things like
>> strip, install-gitweb, or targets which alias (install-man).
>
> Yes please, it would be even better if you're willing to make sure
> that this stays up to date ;).
>

"Yes please" means you like it?

I'll keep an eye on the list for any interesting Makefile targets, but
no promises ;-)
