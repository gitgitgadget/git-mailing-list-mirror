From: Jack Adrian Zappa <adrianh.bsc@gmail.com>
Subject: Re: diff not finding difference
Date: Thu, 24 Sep 2015 17:12:18 -0400
Message-ID: <CAKepmaihyVS3hiAS4bZUfvt-r0ZWycPRkWnokaS7Gx2hEnjT3w@mail.gmail.com>
References: <CAKepmajSPgGK-DqR3Bxf2Xqxj2Gz0MazRNxM6wsVcSiBQsoE4Q@mail.gmail.com>
	<CAKepmajegSMO91YZOe+P_BH2kzzR=RMqCE94XRQSfZzOVYKt6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git-mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 24 23:12:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDoX-0006pe-AI
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394AbbIXVMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:12:21 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:34735 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918AbbIXVMU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:12:20 -0400
Received: by lacdq2 with SMTP id dq2so22879436lac.1
        for <git@vger.kernel.org>; Thu, 24 Sep 2015 14:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=MGj7z4FBg/z1iZyEZVqtWZqSm2WtMWy9v4fLkGuwZ/k=;
        b=Q1xNpxBoMKOEKctryCQ6JjWgsS96vwA/FUD7nHhu6L5M31eyuGq4AI4drLyn3lUIrn
         7699zqlsZpWudBdr1DcNrMTAUMtLvqcQl9NAGX5hbvYWs0SA3StU+jSOSwvCOKG0foJ9
         dFr7aLbLCP8J/tGHB3NlHYsyUtlh9UID8GQRIZNtXLYyGgwwhjBC+mia5b5BDH1xs+Og
         QUuQ1SSi3mSvlLq3ZvzUaiLLmOgwoGqetB9oCsN0QopXISy2Czj6DgzqdQsofKwKFnA+
         1XFtA2itS5ZVPMQ6HVWq5zOayIzWpePnYqS4Jgq4yI0DclceZtRagyNSvAA2O/ADRNLm
         twAg==
X-Received: by 10.112.17.34 with SMTP id l2mr513537lbd.117.1443129138802; Thu,
 24 Sep 2015 14:12:18 -0700 (PDT)
Received: by 10.25.139.130 with HTTP; Thu, 24 Sep 2015 14:12:18 -0700 (PDT)
In-Reply-To: <CAKepmajegSMO91YZOe+P_BH2kzzR=RMqCE94XRQSfZzOVYKt6A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278629>

On Thu, Sep 24, 2015 at 5:09 PM, Jack Adrian Zappa
<adrianh.bsc@gmail.com> wrote:
> This is a weird one:
>
> [file-1 begin]
>
> abcd efg hijklmnop
>
> [file-1 end]
>
> [file-2 begin]
>
> blah blah blah
> /////////////////////////////////////////////////////////////////////////////////
> abdc boo ya!
>
> [file-2 end]
>
> Do a diff between these and it won't find any difference.
>
> Same with the following two lines, each in a different file:
> sabc fed ghi jkl
> abc def ghi jkl
>
> I first noticed this on the command line git and then in VS2013.  The
> original problem was like my first example.  The files were much
> longer, but all that git would see is the addition of the line of
> ////..., but not the removal of the original line.
>
> I've tried some other simple file changes with similar results.
> Something seems to be definitely broken in git diff. :(
>
> Command line version of git is 1.9.5 msysgit.0.
>
>
> A

BTW, I've upgraded to git version 2.5.3.windows.1 and the problem
still persists.


A
