From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Thu, 5 Aug 2010 17:10:27 -0500
Message-ID: <AANLkTimdZrdLFEit7ecXkEcGdfevbvp2TU1ekHddUHwf@mail.gmail.com>
References: <i372v0$3np$1@dough.gmane.org> <AANLkTik2B8pGo8uR4yxV3nz-Nx6dcU+fiO8GWgv9-VtW@mail.gmail.com> 
	<4C599781.2020603@gmail.com> <4C5B2F2E.4050709@gmail.com> 
	<AANLkTikWc0rKV9rQsLfmZvhdqAuvATmbur2ZqQ4Xu7uo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Joel C. Salomon" <joelcsalomon@gmail.com>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 00:10:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh8eM-0002EY-Bo
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 00:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932918Ab0HEWKt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 18:10:49 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42304 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758881Ab0HEWKr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Aug 2010 18:10:47 -0400
Received: by ywh1 with SMTP id 1so2645910ywh.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 15:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=YQXCDZqGsX9U5TvLGwekhX9w0iiIqU/XgTLP8fSaxC4=;
        b=c8ueNC5+2ZsXi05PGl1ifjs+L4kRmyWeIg1cfRuGjdVJm2zd2TnoyqSy6oBY7PYH56
         Ss2vkyS1JoQTrqNCWburCMkw5jAHaMJyJrLoODAxyQQvDBbstl0OQRslmHTssvqmYx7r
         pBQiGabvMgPfz1rH1gkj5m2KbKAnse0wxmkIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=pR0buWjLhK8RZ6u+JRom6PjtflnODj2j33PSkAbduPc1ZV420txAKm6Y7PqC6oRJ9R
         +ik0P2qpOOseOigHCnCqEtkM96d9jqLKkekdMdC62G81/cC/THyM6j7ut0dnSUTYDcwz
         7kOElf2uPq/iQv/tvOfTjZQQRp2yH2i48MAUA=
Received: by 10.150.47.33 with SMTP id u33mr12931851ybu.184.1281046247219; 
	Thu, 05 Aug 2010 15:10:47 -0700 (PDT)
Received: by 10.150.93.6 with HTTP; Thu, 5 Aug 2010 15:10:27 -0700 (PDT)
In-Reply-To: <AANLkTikWc0rKV9rQsLfmZvhdqAuvATmbur2ZqQ4Xu7uo@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152727>

Heya,

On Thu, Aug 5, 2010 at 16:58, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> On 32bit:
>
> commit 826a4f7721fe1c3963a733ecbc5422f05925af5d
> Author: The Philadelphia Convention <>
> Date: =C2=A0 Wed Dec 31 19:59:59 1969 -0400
>
> On 64bit:
>
> commit 826a4f7721fe1c3963a733ecbc5422f05925af5d
> Author: The Philadelphia Convention <>
> Date: =C2=A0 Mon Sep 17 13:00:00 1787 -0400
>
> It would be useful to turn that into a TODO test for Git.

That's bad, if we can't store a particular date we should do something
about it, not just silently underflow.

--=20
Cheers,

Sverre Rabbelier
