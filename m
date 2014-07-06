From: Javier Domingo Cansino <javierdo1@gmail.com>
Subject: Re: Idea, Transparent commits, easier "code style" commits
Date: Sun, 6 Jul 2014 15:37:00 +0200
Message-ID: <CALZVapnofGirkPBFcgNp4-GZnrNAi3ZXDZA1LM-y3_LYQHksXA@mail.gmail.com>
References: <CAAwotL2a=2syXMCjPsNB9Tzaw1Rrr4UqDyLX9+JYDE-izpJnLg@mail.gmail.com>
 <53B6C7AC.7000701@gmail.com> <CAAwotL3vtkjVO5Zqz+w_gNSS0OAovUfukK8=-Df9K4ZybzNh0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <stefanbeller@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Andrius Bentkus <andrius.bentkus@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 15:37:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3mdC-0004VZ-DT
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jul 2014 15:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbaGFNhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2014 09:37:22 -0400
Received: from mail-vc0-f177.google.com ([209.85.220.177]:39773 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbaGFNhV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2014 09:37:21 -0400
Received: by mail-vc0-f177.google.com with SMTP id ij19so2913624vcb.8
        for <git@vger.kernel.org>; Sun, 06 Jul 2014 06:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QE4FPV9sH/ZVHhjyiVLTZQ/YIfN+OhP3iQ4UJhBSTyI=;
        b=EDSVoIhPfdqHRlgROaIUvxg9SGUMq3VRZbG4ktP0A8IzsYKXM1LPWIM0SUZwLs6Q2/
         91FqWXIGEkWp6U648c3CVH/iVgPVwzTMy9VAiJ4rS3ihCj/km/wijsFIYW7dHQm2ewKG
         po8rNr2eWXV0WyMLRAKhW+82jlWojCvQ1QNMN9ajc7YeWRB7V8KwufJzDA/E5i+K3Mdz
         vDChPqm3CFREmSxYzzT9K9fmurvRokZvpSkFD3kHKTWFHzlknp2JMXqI3au6KpHtGKgs
         sKDxEAKxVHgC/sS8EvX4kFFL+byRlyVyRHsDafgEJZTb7gWarfKKjulwtddz4l6EdUD/
         AvJQ==
X-Received: by 10.58.65.104 with SMTP id w8mr798068ves.19.1404653840697; Sun,
 06 Jul 2014 06:37:20 -0700 (PDT)
Received: by 10.221.20.194 with HTTP; Sun, 6 Jul 2014 06:37:00 -0700 (PDT)
In-Reply-To: <CAAwotL3vtkjVO5Zqz+w_gNSS0OAovUfukK8=-Df9K4ZybzNh0A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252935>

> They just have to look into the commit message and look for
> "#codestylefix" or whatever other string.

In many projects I have seen, they have a format for commits, such as
"docs: Add support for XXX", "formatting: Space before parethesis and
after comas", "tests: ...." and so on.

Maybe, being able to specify a RegExp would be the way to go, so that
git blame did actually ignore those commits.
