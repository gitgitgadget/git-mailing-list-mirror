From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Re: [Bug report] 'git status' always says "Your branch is
 up-to-date with 'origin/master'"
Date: Mon, 6 Jan 2014 17:04:47 +0800
Message-ID: <CANYiYbH46EiS5iCEzGOi58Kgr+aCz_67vHsvRu=xSfuYUxosRg@mail.gmail.com>
References: <1963290835.719443.1388996669450.JavaMail.ngmail@webmail15.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Mon Jan 06 10:04:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W067D-0005aj-IX
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 10:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753481AbaAFJEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 04:04:51 -0500
Received: from mail-wg0-f50.google.com ([74.125.82.50]:54600 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395AbaAFJEs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 04:04:48 -0500
Received: by mail-wg0-f50.google.com with SMTP id a1so15584585wgh.5
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 01:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iiRAK1z7zfFb9xhZwZsp9LrRIqaIg8Tzn4J0wNu+69A=;
        b=rXdBI9V0Q1CIUoPaZSt4bWLLs/SvM5YCDWn0q++duBZy3U4JVWPOncwhceVhTAOuTz
         69f+vQTA16bQtNqDakjuhiuRCVcwkDC8GsEqtQ2YptnmvA645g91U6y3hKJfp5Aj+jHu
         1/HmYPUSUQCsV1Mjb8KiV+JrYngHU3n5pI+hwEiFlJVzQEGMgwqlph+qmssDbXmCZblb
         oCny12pK15ct/QjRZLA3l4awno/0+H1mMWkLH+C0sttO8DjbBVcW+WxShK7QLDhaZcQY
         dkt8xztJI0TYcJ9z7XDt8k42IUaWKLWcgAyppxL5Y7R4r9Ztc4YQUZK58r5N2V9TTVb8
         OjAw==
X-Received: by 10.194.60.73 with SMTP id f9mr434587wjr.65.1388999087100; Mon,
 06 Jan 2014 01:04:47 -0800 (PST)
Received: by 10.216.213.207 with HTTP; Mon, 6 Jan 2014 01:04:47 -0800 (PST)
In-Reply-To: <1963290835.719443.1388996669450.JavaMail.ngmail@webmail15.arcor-online.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239990>

2014/1/6 Thomas Ackermann <th.acker@arcor.de>:
>
> Hi Jiang,
>
> this happens with all of my repo clones (I am using V1.8.5.2
> on Windows and on Linux). Steps to reproduce:
>
> mkdir repo_a && cd repo_a && git init .
> echo "1">foo && git add foo && git commit -m "1"
> cd ..
> git clone repo_a repo_b
> cd repo_a
> echo "2">foo && git add foo && git commit -m "2"
> cd ../repo_b
> git status
> git checkout -b "branch"

Oops. Do

    git fetch

then

    git checkout master

You will get what you want.

> git checkout master
>
> 'git status' and 'git checkout master' in repo_b are now
> reporting "Your branch is up-to-date with 'origin/master'"
> which is obviously wrong.
>

--
Jiang Xin
