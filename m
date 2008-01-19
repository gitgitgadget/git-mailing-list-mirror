From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: Why very small repository has 2.7M size
Date: Sat, 19 Jan 2008 17:48:01 +0800
Message-ID: <46dff0320801190148y5a00c83m4825f4066547ddc2@mail.gmail.com>
References: <46dff0320801190143h471e6d70ve5bf114335e1534@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 19 10:48:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGAJW-0007CC-LX
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 10:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871AbYASJsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 04:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752846AbYASJsE
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 04:48:04 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:4366 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825AbYASJsC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 04:48:02 -0500
Received: by py-out-1112.google.com with SMTP id u52so1936498pyb.10
        for <git@vger.kernel.org>; Sat, 19 Jan 2008 01:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=9d92S144cONdkJuG+qNUkJ1pCf92bU5yDnKnGYi6g4Q=;
        b=vSYjFdnuimx6uFOI9eDU+oEg3iwhibRI6c8HSCOadrRCvqtesXmAsAuswuco0NtucGBYKUg7uYdMb84BTXcXY+g8rxIinfaK9e4YrDgyvQqzYzxZ9lhTRtUmKOEPzXGsUaGqs2mgElAq5JkQ2NeOLscuo63zchD0lQOgh0xZvUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NK3WQwAOfRHOP+KAHeDZauABJxs7NQTOFYiMgR9Ky+WMP4f7uvmm0MZjyvF+n7bZPhcjHAgnzbZAjva/AKl78MAQnyjUQvJELHpTe69WSyiV1VzTqpbjMyZWI7CZT3PQBQZCxNCAcaCjuoszOEeCC5hVP9rLYnsVRo7AUbaf8gg=
Received: by 10.35.39.11 with SMTP id r11mr4957529pyj.48.1200736081049;
        Sat, 19 Jan 2008 01:48:01 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sat, 19 Jan 2008 01:48:01 -0800 (PST)
In-Reply-To: <46dff0320801190143h471e6d70ve5bf114335e1534@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71093>

Of course with short history

~/test/bar$ ll -ah && git gc
total 20K
drwxr-xr-x 3 yinping yinping 4.0K 2008-01-19 17:44 .
drwxr-xr-x 8 yinping yinping 4.0K 2008-01-19 17:36 ..
drwxr-xr-x 8 yinping yinping 4.0K 2008-01-19 17:44 .git
-rw-r--r-- 1 yinping yinping   26 2008-01-19 17:33 .gitignore
-rwxr-xr-x 1 yinping yinping  131 2008-01-19 17:44 Makefile.common
Counting objects: 87, done.
Compressing objects: 100% (78/78), done.
Writing objects: 100% (87/87), done.
Total 87 (delta 8), reused 87 (delta 8)

~/test/bar$ git log --pretty=oneline
4046b84344038d63b655b56f6e619888dd424e4e Add Makefile.common using commonmake
8bbd7d4649ac1df1b29414b2ec469f532a77f222 Init empty repository, ignore
*.o, *.d, *~, *.swp, CVS, .svn

~/test/bar$ du -h . | tail -10
8.0K    ./.git/objects/info
2.5M    ./.git/objects/pack
2.5M    ./.git/objects
8.0K    ./.git/logs/refs/heads
20K     ./.git/logs/refs/remotes/origin
24K     ./.git/logs/refs/remotes
36K     ./.git/logs/refs
44K     ./.git/logs
2.7M    ./.git
2.7M    .

On Jan 19, 2008 5:43 PM, Ping Yin <pkufranky@gmail.com> wrote:
> $ ~/test/bar$ ll -h && git gc
> total 8.0K
> -rwxr-xr-x 1 yinping yinping 131 2008-01-19 17:35 Makefile.crawler
> -rwxr-xr-x 1 yinping yinping 131 2008-01-19 17:37 Makefile.search
> Counting objects: 87, done.
> Compressing objects: 100% (78/78), done.
> Writing objects: 100% (87/87), done.
> Total 87 (delta 8), reused 87 (delta 8)
>
> $ ~/test/bar$ du -h . | tail -10
> 8.0K    ./.git/objects/info
> 2.5M    ./.git/objects/pack
> 2.5M    ./.git/objects
> 8.0K    ./.git/logs/refs/heads
> 20K     ./.git/logs/refs/remotes/origin
> 24K     ./.git/logs/refs/remotes
> 36K     ./.git/logs/refs
> 44K     ./.git/logs
> 2.7M    ./.git
> 2.7M    .
>
> --
> Ping Yin
>



-- 
Ping Yin
