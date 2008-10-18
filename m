From: Robin Rosenberg <robin.rosenberg@gmail.com>
Subject: Re: Weird filename encoding issue
Date: Sat, 18 Oct 2008 04:58:53 +0200
Message-ID: <200810180458.53853.robin.rosenberg@gmail.com>
References: <c6c947f60810170059s3859d906r9935b5e80d8a41c6@mail.gmail.com> <c6c947f60810170108q3038b66bj2ad89bdcb7105903@mail.gmail.com> <48F852FC.2070506@viscovery.net>
Reply-To: robin.rosenberg@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sat Oct 18 05:10:41 2008
connect(): Connection refused
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wf-out-1516.google.com ([209.85.200.160])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kr2DA-0003Iu-Km
	for gcvm-msysgit@m.gmane.org; Sat, 18 Oct 2008 05:10:41 +0200
Received: by wf-out-1516.google.com with SMTP id u12so188268wfc.33
        for <gcvm-msysgit@m.gmane.org>; Fri, 17 Oct 2008 20:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:received:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=Vl/E6zMNvGpeXuVOERmHZt1T1ChtdYMScLxud5HRvvE=;
        b=ur1MEUBdDZGzXH/GAMAcF/jfrHYMWI336cTDNUKS0r4ZqtufnkMl8ebpwPWWGJqOGg
         RkeSg+nFtUxLDyIN0Hl+fZJsWMnYT4Qt8h1CjMWN5xE8TmguiuoIxpIfO3CYoNLozAhH
         Dj2eTLk8WEK/lc3OOVI+wvfGVKaKLgo1oW6iE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        b=mZrnYKaiGt2d45fmr1kzMVt+V8AcfcxMiJgRzjPNtP1ROgeDXoytwApEXswmjQaHK3
         wMW5UwiVXk+QVZOY+UqK+8cxehYiUDIl0nzmNkfCpSydAHj3qYXVwhhkHJU2iS6admb8
         Yxe2b7vptfW7VvCIntiMbDH4cpseCMiWMWgC8=
Received: by 10.141.180.5 with SMTP id h5mr109315rvp.28.1224298736593;
        Fri, 17 Oct 2008 19:58:56 -0700 (PDT)
Received: by 10.106.212.23 with SMTP id k23gr3097prg.0;
	Fri, 17 Oct 2008 19:58:56 -0700 (PDT)
X-Sender: robin.rosenberg@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.151.155.5 with SMTP id h5mr2723002ybo.15.1224298736210; Fri, 17 Oct 2008 19:58:56 -0700 (PDT)
Received: from av11-2-sn2.hy.skanova.net (av11-2-sn2.hy.skanova.net [81.228.8.184]) by mx.google.com with ESMTP id 39si3663043yxd.2.2008.10.17.19.58.55; Fri, 17 Oct 2008 19:58:56 -0700 (PDT)
Received-SPF: neutral (google.com: 81.228.8.184 is neither permitted nor denied by domain of robin.rosenberg@gmail.com) client-ip=81.228.8.184;
Authentication-Results: mx.google.com; spf=neutral (google.com: 81.228.8.184 is neither permitted nor denied by domain of robin.rosenberg@gmail.com) smtp.mail=robin.rosenberg@gmail.com
Received: by av11-2-sn2.hy.skanova.net (Postfix, from userid 502) id 084AC38EAC; Sat, 18 Oct 2008 04:58:55 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92]) by av11-2-sn2.hy.skanova.net (Postfix) with ESMTP id DDC2938EAA; Sat, 18 Oct 2008 04:58:54 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250]) by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id BA50437E44; Sat, 18 Oct 2008 04:58:54 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <48F852FC.2070506@viscovery.net>
Content-Disposition: inline
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98518>


fredagen den 17 oktober 2008 10.55.24 skrev Johannes Sixt:
> 
> Alexander Gladysh schrieb:
> > 3. Clone repo to OS X machine and see the weird behaviour. Git status
> > can't decide how file should be named, "%CA%EE%EF%E8%FF.txt" or
> > "\312\356\357\350\377.txt".
> 
> It's not 'git status' that cannot decide how to name the file. It's OS X.
> 
> > $ git status
> > # On branch master
> > # Untracked files:
> > #   (use "git add <file>..." to include in what will be committed)
> > #
> > #	%CA%EE%EF%E8%FF.txt
> > nothing added to commit but untracked files present (use "git add" to track)
> > $ ls
> > %CA%EE%EF%E8%FF.txt
> 
> git asked OS X:
> 
>    Does the file "\312\356\357\350\377.txt" exist?
> 
> and OS X said: "Yes". Because otherwise, you would have seen the file
> listed as "deleted:" in the 'git status' call above.
> 
> But then git also requested a file listing from OS X in order to list the
> untracked files. And now OS X returned the name "%CA%EE%EF%E8%FF.txt". How
> could you expect git to tell that this is the same file when OS X cannot
> decide how to name it?
> 
> The solution: Do not use file names with some local (let alone Windows
> specific) encoding if you have to use the files on OS X, too.

That seems to be OS-X's way of saying the is a string of garbage, lets handle it as such.

Git (or msys) under windows is somewhat stupid here as it involves the eight-bit locale
despite running in a unicode OS. To get UTF-8 on XP you can set the codepage to UTF-8 
(called 65001 in windows). That might still cause problems with OS-X for some chararacters
as it wants to "decompose" the UTF-8 encoding for accented characters, which perhaps is
not a problem for you.

I have no idea how well codepage 65001 plays with msys, but it would be nice it would work.
I'm not sure how to switch codepage in msys, but if you set it from cmd and then start msys
bash from there, I'm pretty sure it will pick it up.

-- robin
