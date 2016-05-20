From: Jon Forrest <nobozo@gmail.com>
Subject: Re: Odd Difference Between Windows Git and Standard Git
Date: Fri, 20 May 2016 06:48:32 -0700
Message-ID: <c20b9819-1b2d-6704-d870-1c0102dd9e35@gmail.com>
References: <nhlqd4$ekr$1@ger.gmane.org>
 <c07df4ac-08c9-8eaa-0233-06616945c857@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 15:50:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3knB-0008TO-7j
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 15:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755794AbcETNsh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 May 2016 09:48:37 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:32998 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbcETNsg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 09:48:36 -0400
Received: by mail-pa0-f43.google.com with SMTP id xk12so39933425pac.0
        for <git@vger.kernel.org>; Fri, 20 May 2016 06:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=Idw3QCcuR6mXUzOAqc9Ls1pQxqyluZYVdw6Hqp7PDJs=;
        b=BgZHpxkbAvDDAroAsxLWqRSYoo6QTazVSCNxgOSFAiHvLnU5Ugb3N2ssQOH8qTw9MU
         fhrt3WukNz99/x1PQF14N0sDeWBoXN2inApq2LjoSUc43E8jKSDhnjS72hXyYsJ+r/F1
         uCyImXnGGcz6DVS7iRH1Hd6/tAtt/9heELk4ldDvQYQiXhJyI3au5khOtSjVuQHZwPuL
         pyM/znYAdxgMxFkK9FhUlT6B6aD+gWdQfGtFdbUq5uQ3d0JA89jP/bV35mcSmm5SZ0zZ
         zbPqiU+Vl30wpNG5oY8vuDFiVwM3HYo8ORA3pFpmxluvCdKfEd/G+kkdSWDzfXrU67l+
         4Egg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Idw3QCcuR6mXUzOAqc9Ls1pQxqyluZYVdw6Hqp7PDJs=;
        b=KrGBs8ZPhgZpxtnJdh13UOxTaH6rntirY4KDK7MHZyfH1EEA3GUv7rbjfoK25Up/iB
         hFs2zD6ocIB/q/imMmuyQkyUCf1uF5eSesY6JorL8MmsfYyG1cbMHcNrMn7VzGZk83/o
         fuTx9kLTbfpzWG1Putts9f9zeYXlQ7BSfrEmpz+hUxTjFGtvbyjYtZtK0LXgkj74kMib
         H2OLotedwGfwc8H1LlgT3CtwKc7BN45oaUQ+PaTT36yX/ynWGm+0ArI4/ngxoDg1D5yi
         by3TS7pQOYLLbsmQ3l5VhD51Cs+pgqN+zSX7FCjiKSEAK5cBsGeyD8GMQCOpRDXfapYy
         YPlA==
X-Gm-Message-State: AOPr4FVxSwN/sHZFXRVVaRMYUqhpZXvexcyjgYtHTmINsxGm9XBm89JbFio3yWdy1Pt7gQ==
X-Received: by 10.66.152.164 with SMTP id uz4mr4987213pab.9.1463752115607;
        Fri, 20 May 2016 06:48:35 -0700 (PDT)
Received: from [192.168.0.104] (c-71-202-183-39.hsd1.ca.comcast.net. [71.202.183.39])
        by smtp.googlemail.com with ESMTPSA id lz5sm27618596pab.34.2016.05.20.06.48.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 20 May 2016 06:48:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <c07df4ac-08c9-8eaa-0233-06616945c857@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295165>



On 5/20/2016 6:19 AM, Torsten B=C3=B6gershausen wrote:
> On 20.05.16 03:48, Jon Forrest wrote:
>> I'm running Git version 2.8.2 built from source on Ubuntu 16.04.
>> I'm using a repository that's stored on Dropbox. I'm the only person
>> accessing this repo. Everything works great.
>>
>> For reasons unrelated to Git, I decided to try Git for Windows,
>> so I installed "git version 2.8.2.windows.1" on Windows 10.
>> When I run 'git status' on Ubuntu the list I see is exactly what
>> I expect. However, when I run 'git status' on the
>> same Dropbox repo on Windows, I see what I expect plus I'm told
>> that every .pdf file and some .png files are modified.
> To bring at least a little light into the story:
>
> What does
> git diff
> say ?

Great question. For all the unexpected files it says the
same thing:

old mode 100755
new mode 100644

> What does
> git config -l | grep core
> say ?

core.symlinks=3Dfalse
core.autocrlf=3Dtrue
core.fscache=3Dtrue
core.editor=3Dvim
core.repositoryformatversion=3D0
core.filemode=3Dtrue
core.bare=3Dfalse
core.logallrefupdates=3Dtrue
>
> And what does
> git ls-files --eol
> say?

The same thing for all the unexpected files,
which is:

i/-text w/-text attr/

I'm running the above commands on Windows.

The result of the 2nd question on Ubuntu is:

core.repositoryformatversion=3D0
core.filemode=3Dtrue
core.bare=3Dfalse
core.logallrefupdates=3Dtrue

and the 3rd (for the expected files) is:

i/lf    w/lf    attr/

Jon
