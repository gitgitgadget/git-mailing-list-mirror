From: Shawn Pearce <spearce@spearce.org>
Subject: Re: How to resume broke clone ?
Date: Thu, 28 Nov 2013 11:35:56 -0800
Message-ID: <CAJo=hJvk0WJJM1jn_XiqpJM791pu=Wmh7CObpnAS60TFQFOfeQ@mail.gmail.com>
References: <AAA12788-A242-41B8-B47D-1A0A52F33FC1@ancientrocklab.com>
 <5296F343.6050506@gmail.com> <560807D9-CE82-4CF6-A1CC-54E7CCA624F9@ancientrocklab.com>
 <CACsJy8DbJZmBCnfzNqfmEnRpqVcc42Q_-jz3r=sYVRPhsCkS5A@mail.gmail.com>
 <CALUzUxrEvuKuN+v-hJLQd5KoV-fzxVYvg5pj7XoLBVap7mgA=Q@mail.gmail.com> <F569EBDF-D8B5-47D5-8C2F-DA3A0F6C207E@ancientrocklab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tay Ray Chuan <rctay89@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: zhifeng hu <zf@ancientrocklab.com>
X-From: git-owner@vger.kernel.org Thu Nov 28 20:36:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vm7Nu-0002M2-Lm
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 20:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857Ab3K1TgS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Nov 2013 14:36:18 -0500
Received: from mail-we0-f182.google.com ([74.125.82.182]:37935 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754794Ab3K1TgS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Nov 2013 14:36:18 -0500
Received: by mail-we0-f182.google.com with SMTP id q59so8640718wes.13
        for <git@vger.kernel.org>; Thu, 28 Nov 2013 11:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=yLnHTgTtpwnad0Fe/ym1IEb54qI55lGnJQk7J9XcWCA=;
        b=aaVu5o7xpjOug64Vwq068DDvcutnuB1iC1jGMDJp0pD3JWVyAPx4X25xivDLbxt+Q2
         rbDq0HT4rwLDGwjS1+hl68MariS1moeYW46gJAF6IhhrASpfASQR5IqYE/ZImgYGFv6e
         u/ybqc1XmHYFORECCcLExwEL3C+lpiPGoNf9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=yLnHTgTtpwnad0Fe/ym1IEb54qI55lGnJQk7J9XcWCA=;
        b=ZFclDLHrOKYxKihrgnbOoBDZNQJHIES9cqmKTfxD2KTLl3Y8tg6R2SUe1HKKN/8+J5
         2JEB24nDCCQWSi0s0txUYECI7OPCI9NX+4TzS0KoYg2lZ7Nme72/WTMwH0sTm+FGK9We
         1rWenl0pVEmvUBFAI6IGiXrkXjKXJmbJ61Zjn8F7uyFfYtfdKEdtHFE703wrGgzLAg9n
         dSa+V8URR9xlzGEJra3N45ACFtujS+C/7zSRMhyHgiixQBhVEENFB6ZSZf3QFrJCHH2K
         NGowlniJT+IbHTNHaCTMGhFd3UeA8+XXvuv2uKwnIV5UysBcB7u7H6lpm2D95fNRKEEg
         F5bA==
X-Gm-Message-State: ALoCoQl74LGw2MrzmXcwO9wGO9usX9s4oj80bOLuVGylfSU4fDlWwSFYZTi23ZZqnYv+WN32VCKG
X-Received: by 10.180.37.201 with SMTP id a9mr3836268wik.18.1385667376615;
 Thu, 28 Nov 2013 11:36:16 -0800 (PST)
Received: by 10.227.192.198 with HTTP; Thu, 28 Nov 2013 11:35:56 -0800 (PST)
In-Reply-To: <F569EBDF-D8B5-47D5-8C2F-DA3A0F6C207E@ancientrocklab.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238503>

On Thu, Nov 28, 2013 at 1:29 AM, zhifeng hu <zf@ancientrocklab.com> wro=
te:
> Once using git clone =97depth or git fetch =97depth,
> While you want to move backward.
> you may face problem
>
>  git fetch --depth=3D105
> error: Could not read 483bbf41ca5beb7e38b3b01f21149c56a1154b7a
> error: Could not read aacb82de3ff8ae7b0a9e4cfec16c1807b6c315ef
> error: Could not read 5a1758710d06ce9ddef754a8ee79408277032d8b
> error: Could not read a7d5629fe0580bd3e154206388371f5b8fc832db
> error: Could not read 073291c476b4edb4d10bbada1e64b471ba153b6b

We now have a resumable bundle available through our kernel.org
mirror. The bundle is 658M.

  mkdir linux
  cd linux
  git init

  wget https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvald=
s/linux/clone.bundle

  sha1sum clone.bundle
  96831de0b81713333e5ebba94edb31e37e70e1df  clone.bundle

  git fetch -u ./clone.bundle refs/*:refs/*
  git reset --hard

You can also use our mirror as an upstream, as we have servers in Asia
that lag no more than 5 or 6 minutes behind kernel.org:

  git remote add origin
https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux=
/
