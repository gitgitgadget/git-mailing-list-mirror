From: Adrian Stern <adrian.stern@unchained.ch>
Subject: Re: cannot checkout svn repository
Date: Thu, 9 Oct 2014 15:49:49 +0200
Message-ID: <CAOHZ5L4VOZEnudHOKr3=1N0H1CvSSBud-0cjc6378cGRkm-Vow@mail.gmail.com>
References: <CAOHZ5L7qcfiQAu2puD-Nv=k4etGNtKCPukSgm1UpSDGBcnPmTw@mail.gmail.com>
	<CAOHZ5L5YAww1NMVv83Hifev6NG6Yoy7h8D8+RpF+N-m__FQktg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 15:49:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcE6N-0002Tv-GE
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 15:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755094AbaJINtv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Oct 2014 09:49:51 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:59207 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153AbaJINtu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Oct 2014 09:49:50 -0400
Received: by mail-ig0-f177.google.com with SMTP id a13so4157645igq.16
        for <git@vger.kernel.org>; Thu, 09 Oct 2014 06:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=lFj3sqDD3VMbXQrZO/YtnBu53i2Z4X0Q+l3mSxthfVs=;
        b=Z3CM7p6E2lYJs9TX+P3GuM1bPRYYsqalSTy4eyEqauoCOjY+rPJ8BSRwqyUT/iFZHk
         aaLtM0jZZVGWMWxzj/2HbMdEdJ6IGgQVc1ngh8WZ4SjgKa5mJeanWapEhMvooiKpuC1i
         twY4NxwBqjHMV8YdImdzwVavppI6IUOUB1oXoza5TqGnyAmXHe9DZu3QtoKTPIAp5Y7k
         wtT0XBAZTGwOkxil3kkS2S198oYwmyqVlQc+g/XIqLNtXtk8+IIyTj58YpLeo8GRNJTW
         S3S2PJDnvDS6mI35EYZznma+0gIwJMrPr4m8qh0BisLamNlNIz2H7JyQyPpfKYMea6T4
         uRKA==
X-Gm-Message-State: ALoCoQligSe0b4csfqAnK2hklG7/XnwFnuDfcwN42xj5uBALDku38IhRXHgdF+s9tzTfi8LVO5tI
X-Received: by 10.43.6.200 with SMTP id ol8mr8146382icb.39.1412862589639; Thu,
 09 Oct 2014 06:49:49 -0700 (PDT)
Received: by 10.42.198.6 with HTTP; Thu, 9 Oct 2014 06:49:49 -0700 (PDT)
In-Reply-To: <CAOHZ5L5YAww1NMVv83Hifev6NG6Yoy7h8D8+RpF+N-m__FQktg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Well. after about 15 to 30 minutes it began to download the repository
finishing with "error: bad file descriptor" on git-svn. It checked r1
to r500000+ with took some time.
The unit-tests where successful so i think the broken pipe was not an
issue in the end.
Sorry for disturbing you.


=46reundliche Gr=C3=BCsse

Adrian Stern
unchained - web solutions

adrian.stern@unchained.ch
+41 79 292 83 47


On Thu, Oct 9, 2014 at 3:21 PM, Adrian Stern <adrian.stern@unchained.ch=
> wrote:
> Hi
>
> I'm unable to checkout this subversion repository with git. Can
> somebody help me?
>
> svn co http://svn.apache.org/repos/asf/ofbiz/branches/release13.07 of=
biz.13.07
>
> Yes i can clone it with SVN and add it to git. But this disturbes the
> workflow and causes problems when someone commits to this branch whic=
h
> should be a read-only mirror only.
>
> Works fine with svn, git svn clone however does not work.
>
> Regards,
>
> Adrian Stern
> unchained - web solutions
>
> adrian.stern@unchained.ch
> +41 79 292 83 47
