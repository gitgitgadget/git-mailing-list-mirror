From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Windows Bluescreen
Date: Wed, 11 Feb 2015 21:56:07 +1300
Message-ID: <CAFOYHZADerTE88KudrH7LTi3yX4Sg1vJe3Xj0vJH+DNeO6NOEw@mail.gmail.com>
References: <20150209201218.Horde.w9pQrdbL-Mf8IdgtaJtVuQ9@server.aercontechnologies.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>, msysgit@googlegroups.com
To: erik@aercon.net
X-From: msysgit+bncBCL33DMYQAARBKFS5STAKGQELT4TQ7A@googlegroups.com Wed Feb 11 09:56:09 2015
Return-path: <msysgit+bncBCL33DMYQAARBKFS5STAKGQELT4TQ7A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pa0-f57.google.com ([209.85.220.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCL33DMYQAARBKFS5STAKGQELT4TQ7A@googlegroups.com>)
	id 1YLT5d-00076l-F0
	for gcvm-msysgit@m.gmane.org; Wed, 11 Feb 2015 09:56:09 +0100
Received: by mail-pa0-f57.google.com with SMTP id bj1sf515359pad.2
        for <gcvm-msysgit@m.gmane.org>; Wed, 11 Feb 2015 00:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe;
        bh=93SZ5eO1TrdyaoplTXxW9cbzW2Vk+4cr40fMeu0iyJ4=;
        b=Cfp93/8Df0DVPhVljf20iMzOUj+Yh4O1alSct2g14HfPKXWWEda9Yn3tLtK/VycO6G
         eQLXHkWI9+Y72FGgIOPj5tQBzTC3AfSGXyV0RsBBzI62ogUBjlsCaRNz5DvdB+3XZqJE
         tOiapiUQXtyiv7nEjLz/AROUx/QypBz6ycGkZEqDFOkQJHKRXjv/n3H8lJ1mF3hjadBY
         +sARkD9TknzLzQNQH/7Y73Uu5oVzJ9gt/Exvkv4Bwjp1YeaUC+GmBZo77RJosXFsD+BX
         ul2QS6q801/zTmuy/yq9aR0bL/pDy3+jrE+GRHsC5wk/XxwIBKGD4O/Qf6g2bYIEAC7u
         ziGQ==
X-Received: by 10.50.85.17 with SMTP id d17mr30306igz.7.1423644968664;
        Wed, 11 Feb 2015 00:56:08 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.107.135.211 with SMTP id r80ls125860ioi.82.gmail; Wed, 11 Feb
 2015 00:56:08 -0800 (PST)
X-Received: by 10.66.66.1 with SMTP id b1mr23223961pat.8.1423644968094;
        Wed, 11 Feb 2015 00:56:08 -0800 (PST)
Received: from mail-pd0-f179.google.com (mail-pd0-f179.google.com. [209.85.192.179])
        by gmr-mx.google.com with ESMTPS id ki8si24378pdb.1.2015.02.11.00.56.08
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Feb 2015 00:56:08 -0800 (PST)
Received-SPF: pass (google.com: domain of judge.packham@gmail.com designates 209.85.192.179 as permitted sender) client-ip=209.85.192.179;
Received: by pdno5 with SMTP id o5so3066064pdn.8
        for <msysgit@googlegroups.com>; Wed, 11 Feb 2015 00:56:08 -0800 (PST)
X-Received: by 10.70.103.162 with SMTP id fx2mr7587796pdb.24.1423644967930;
 Wed, 11 Feb 2015 00:56:07 -0800 (PST)
Received: by 10.70.87.100 with HTTP; Wed, 11 Feb 2015 00:56:07 -0800 (PST)
In-Reply-To: <20150209201218.Horde.w9pQrdbL-Mf8IdgtaJtVuQ9@server.aercontechnologies.net>
X-Original-Sender: judge.packham@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of judge.packham@gmail.com designates 209.85.192.179 as
 permitted sender) smtp.mail=judge.packham@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263669>

Hi Erik,

On Tue, Feb 10, 2015 at 9:12 AM,  <erik@aercon.net> wrote:
>
> I find that preview 1.8 is bluescreening on about 1 of 3 ssh pushes.  1.9
> preview 12-17-2014 doesn't even bluescreen, the windows gui locks until
> reset.

Does this mean that pushing over git:// file:// and http:// are
unaffected? Can you successfully do other (non-git) things over ssh?

>
> Sample command:
> git push omv master\r
>
> config. =
>
> [core]
>         repositoryformatversion = 0
>         filemode = false
>         bare = false
>         logallrefupdates = true
>         symlinks = false
>         ignorecase = true
>         hideDotFiles = dotGitOnly
> [remote "omv"]
>         url = gitpush@192.168.0.100:/git-repos/HexEncrypter
>         fetch = +refs/heads/*:refs/remotes/omv/*
>

You might get a more helpful response out of the msysgit folks (I've
added them to the Cc list).

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
