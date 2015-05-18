From: John McIntyre <joh98.mac@gmail.com>
Subject: Re: Git Server Repository Security?
Date: Mon, 18 May 2015 16:07:49 +0100
Message-ID: <CABQ4iYgauiENEv5ESbJTgUWVhRjt3NxmJfxTZTaa8U072atDEQ@mail.gmail.com>
References: <CABQ4iYiWu17H1XhPYebmP27x=R11SKW0P91AW2y9S=r-2c0B1A@mail.gmail.com>
	<20150518102633.GA15186@book.hvoigt.net>
	<CABQ4iYgjtdw46Psow_e7uGLqx0ZiFt+TQOgXvCmP1-W10LGEmg@mail.gmail.com>
	<20150518115749.GA16841@book.hvoigt.net>
	<CABQ4iYjwa-KmZAQV=p5efQYBZu3ymQRNwTC4TGXdpo4groArCA@mail.gmail.com>
	<20150518123948.GA17075@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon May 18 17:08:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuMe8-0004Uz-Lx
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 17:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753771AbbERPHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 11:07:55 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:35012 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745AbbERPHv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 11:07:51 -0400
Received: by labbd9 with SMTP id bd9so225019969lab.2
        for <git@vger.kernel.org>; Mon, 18 May 2015 08:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yHaUyybq3m81VcVmeRqrDMrVilTg7yJ3qcHDEn5xb1E=;
        b=ZFuzIVI/Zc9EtIihmFGPgA3yzF2dCxM1C9QlXz5elZiE78Cofz9BDEWRUA/71vNycw
         c2ztL4t984QPKIYHe7KR9kzB9gyNYkISj9YPEbeRcxG9OtApX+VvIlRIceVctpDBTPT+
         A8g4xIZeU3qeddFSzysoWF0y4WMMhxSCk++AtvoIYNi+iRDEqelIoa7A9c+dBbHlU54L
         IGdIri4GdWBQ2bCVP0H5obTpLr+uIVOUb8/KW/quWw8xSKV9WcCpJBppgahDFsGsKRT6
         3wTBaP5rKWarEtYZSrl5VQmQBZ7f7IYrrMInTD/cotOU8meoszdSJVEygt7IFMb7NjTh
         MUDw==
X-Received: by 10.152.179.39 with SMTP id dd7mr15394662lac.118.1431961669812;
 Mon, 18 May 2015 08:07:49 -0700 (PDT)
Received: by 10.152.129.228 with HTTP; Mon, 18 May 2015 08:07:49 -0700 (PDT)
In-Reply-To: <20150518123948.GA17075@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269262>

2015-05-18 13:39 GMT+01:00 Heiko Voigt <hvoigt@hvoigt.net>:
> On Mon, May 18, 2015 at 01:32:07PM +0100, John McIntyre wrote:
>> All right, so I'm a bit confused.  I followed the instructions to get
>> gitolite, and put a public key, placing it on the server.  I then
>> run..
>>
>> ***
>> gitolite setup -pk server-git01_rsa.pub
>> Initialized empty Git repository in /home/git/repositories/gitolite-admin.git/
>> Initialized empty Git repository in /home/git/repositories/testing.git/
>> ***
>>
>> Our repositories are under /opt/git/n where n is the name of the repo.
>>
>> Is there a config file where this is defined?
>
> I do not know, because I always used /home/git. In case not: How about
> just using a symlink? And there is a lot of information on google ;-)


I'm confused.   If I run the gitolite command again, in the /opt/git
directory, will that set it up correctly?

And I thought that access was via key?  In the example config files
I've seen, there is no mention of different keys in the config file.

Our users can currently ssh into the box.  I want to stop that, but
since they all ssh in as the use 'git', if I change the shell of that
user to /sbin/nologin or something similar, I'm effectively locking
out the git user.
