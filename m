From: Sedat Kapanoglu <sedat@eksiteknoloji.com>
Subject: Re: git clone doesn't work in symlink dir roots on Windows
Date: Sat, 10 Aug 2013 19:22:27 +0300
Message-ID: <CABJxLaOvMQcBqGMbdKm9oAd_sxJb_Q2f59vr6S=GfXeYUFxGhg@mail.gmail.com>
References: <CABJxLaM9t1HeEVkAiXpOmaOH_V6681w9Q9ZQt37+MpmhX7yN2g@mail.gmail.com>
	<20130810125140.GD25779@paksenarrion.iveqy.com>
	<CABJxLaOaUYxyAsy5mpciiAObmoazFpwB0T4C20cu3eHuSpEpAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 18:22:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8Bw2-0006Eq-4n
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 18:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993Ab3HJQWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 12:22:30 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:58757 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964886Ab3HJQW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 12:22:29 -0400
Received: by mail-oa0-f45.google.com with SMTP id m1so8048006oag.4
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 09:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:dkim-signature:mime-version:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=No6sGRl3ulVTOW6Z5bnOeIQ8qI2UdKe+X+nO2ZunqPw=;
        b=iDyzJA9tz45kOrWPxjOh9C4uj7GCbNB2liQDMO5rxjCpZBQmmpHTr1QeysZkFhimi1
         +DlFfVH8xXyTO+3uKBYi7PS03lOD5hg1YyVtVaFc2YrkD84Ca0M7Tjx2xH7ZCoSl90Di
         Q7ZQhxL1G4FpEtsQqEg+YFEJ8adVMe90U4mmO5yYaPqCZFGLUPQeVFJPrznQ5MnZ2xDA
         4QCiPS0m6fkiwQVB6Y/oItYeaa29C7ucHEY69IujCa7ByTKqgm+MkSrw2dBzh5sedLrI
         GL2ss/DTFf53uUvQTjIZkX+WHG9TuIGCm2KyzUfwFufKBgtS2dhZotOz7qDcaMh8o5u6
         mWjw==
X-Gm-Message-State: ALoCoQmOXAJGZUjdqt/eUo1MBopCS2GcTYs1tcLa4iPmo2nQpiPBzvWltHdtXhDQRSU2T9mp/I6P
X-Received: by 10.60.83.19 with SMTP id m19mr4697570oey.9.1376151749408;
        Sat, 10 Aug 2013 09:22:29 -0700 (PDT)
Received: from mail-ob0-x236.google.com (mail-ob0-x236.google.com [2607:f8b0:4003:c01::236])
        by mx.google.com with ESMTPSA id xq2sm24495855obc.12.2013.08.10.09.22.28
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 10 Aug 2013 09:22:28 -0700 (PDT)
Received: by mail-ob0-f182.google.com with SMTP id wo10so7602394obc.27
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 09:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eksiteknoloji.com; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=No6sGRl3ulVTOW6Z5bnOeIQ8qI2UdKe+X+nO2ZunqPw=;
        b=XWez35Na98R4oA39Y+pMFSjThZQ+SNRML0Zrv62CpIBYpdBCbDe8l7T+dkyVBVLs71
         b+KILuqenhjfUziAloiLvxeG4niGA8FUvphSM/4V7xjBf9dcWqxgtIHuBWKtzOqfs0v0
         ppm7D7mYkP5BIyv6Mmgw0/f5m0bEaiT7aqnrg=
X-Received: by 10.182.242.11 with SMTP id wm11mr4722815obc.26.1376151747684;
 Sat, 10 Aug 2013 09:22:27 -0700 (PDT)
Received: by 10.182.81.3 with HTTP; Sat, 10 Aug 2013 09:22:27 -0700 (PDT)
In-Reply-To: <CABJxLaOaUYxyAsy5mpciiAObmoazFpwB0T4C20cu3eHuSpEpAg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232104>

(my symdir was called 'gitto', fyi)

On Sat, Aug 10, 2013 at 7:22 PM, Sedat Kapanoglu
<sedat@eksiteknoloji.com> wrote:
>> git is a disk intense program, so this setup is not sane at all. With
>> that said I know that git on windows historically had problems with
>> working on smb-mounted shares (sometimes you're forced to have stupid
>> setups). I doubt that git really is the right tool for your work, since
>
> I reproduced the same problem in a regular symlink directory. Repro steps:
>
> mkdir actualdir
> mklink /d symdir actualdir
> cd symdir
> git init .
>
> fatal: Invalid symlink 'D:/gitto': Function not implemented
>
> Thanks,
>
> Sedat
