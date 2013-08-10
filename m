From: Sedat Kapanoglu <sedat@eksiteknoloji.com>
Subject: Re: git clone doesn't work in symlink dir roots on Windows
Date: Sat, 10 Aug 2013 19:22:03 +0300
Message-ID: <CABJxLaOaUYxyAsy5mpciiAObmoazFpwB0T4C20cu3eHuSpEpAg@mail.gmail.com>
References: <CABJxLaM9t1HeEVkAiXpOmaOH_V6681w9Q9ZQt37+MpmhX7yN2g@mail.gmail.com>
	<20130810125140.GD25779@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 18:22:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8Bvg-0005zz-Nb
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 18:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927Ab3HJQWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 12:22:07 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:39304 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964886Ab3HJQWG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 12:22:06 -0400
Received: by mail-ob0-f170.google.com with SMTP id eh20so7622833obb.29
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 09:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:dkim-signature:mime-version:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=3wj1WJCDB7ZQagfrSF6ez3yImiZcnXdFtIMrDW1tvhI=;
        b=k/1flXJgG3z0OmqGeXJ12T9Yn35TsoJEh9SBym+CrhCisZdTNsFpbd7Z4vxu5ZAPP+
         8HjRsH5lKArAxcJfK7Ji58Y7iyAOiKF1OUVk/4wJFaaJF4/hEV2FIcH4VfXHoct9o3wt
         slBUad9uD3MM71fKo+flhnok9xEi7QhUs/2Smz+JDtNnfZ+dZ/0pw0Sy07YylY74Skte
         wymi15VbiDFGyZSxseUq0uv2U4okU74GPDhGB8gZvw6T1zTpjEZIYCqqpWkbX2B2MTPm
         P+XXYbqbshGij7yWmormiX888ivm7AJn7e2uIOuMW+hncDFSMCcV/IL89rp5eDlUkYWk
         87aA==
X-Gm-Message-State: ALoCoQm51W3VyfzopD9oY9/N9PyQNey9NI0/6ewZTzv+nM6OaZXH+bFnEKg07hbbq1FjHx+0IV81
X-Received: by 10.182.87.170 with SMTP id az10mr7576647obb.10.1376151725801;
        Sat, 10 Aug 2013 09:22:05 -0700 (PDT)
Received: from mail-oa0-x22e.google.com (mail-oa0-x22e.google.com [2607:f8b0:4003:c02::22e])
        by mx.google.com with ESMTPSA id z5sm24501035obg.13.2013.08.10.09.22.04
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 10 Aug 2013 09:22:04 -0700 (PDT)
Received: by mail-oa0-f46.google.com with SMTP id l10so3421557oag.19
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 09:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eksiteknoloji.com; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3wj1WJCDB7ZQagfrSF6ez3yImiZcnXdFtIMrDW1tvhI=;
        b=AcwLuRKcifdYMjJMG797DLwX6OcZudwDTJRoBj/evE2IHcX9tB21A00ryQ2q7dNoXT
         QxoLYnv5LMjmNr2+kR1NjEQT1UxX0rXcyi5+/KozI3zR3llkGRwnnxSQbWgqzY3W6lsy
         O0pvIHOSYvswd61Q77/e2ePYZ1zD2/X49hBks=
X-Received: by 10.60.51.41 with SMTP id h9mr4692950oeo.49.1376151723897; Sat,
 10 Aug 2013 09:22:03 -0700 (PDT)
Received: by 10.182.81.3 with HTTP; Sat, 10 Aug 2013 09:22:03 -0700 (PDT)
In-Reply-To: <20130810125140.GD25779@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232103>

> git is a disk intense program, so this setup is not sane at all. With
> that said I know that git on windows historically had problems with
> working on smb-mounted shares (sometimes you're forced to have stupid
> setups). I doubt that git really is the right tool for your work, since

I reproduced the same problem in a regular symlink directory. Repro steps:

mkdir actualdir
mklink /d symdir actualdir
cd symdir
git init .

fatal: Invalid symlink 'D:/gitto': Function not implemented

Thanks,

Sedat
