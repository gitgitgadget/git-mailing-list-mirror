From: Michael Geddes <michael@frog.wheelycreek.net>
Subject: Re: Re: git clone doesn't work in symlink dir roots on Windows
Date: Tue, 20 Aug 2013 15:30:55 +0800
Message-ID: <1928115.O1fVFY9Fid@majorie>
References: <CABJxLaM9t1HeEVkAiXpOmaOH_V6681w9Q9ZQt37+MpmhX7yN2g@mail.gmail.com> <CABJxLaOaUYxyAsy5mpciiAObmoazFpwB0T4C20cu3eHuSpEpAg@mail.gmail.com> <20130810163459.GE25779@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, Sedat Kapanoglu <sedat@eksiteknoloji.com>, git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: msysgit+bncBCLZXZ4RRAEBBM5WZSIAKGQEBRDA3OI@googlegroups.com Tue Aug 20 09:31:02 2013
Return-path: <msysgit+bncBCLZXZ4RRAEBBM5WZSIAKGQEBRDA3OI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qa0-f55.google.com ([209.85.216.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCLZXZ4RRAEBBM5WZSIAKGQEBRDA3OI@googlegroups.com>)
	id 1VBgP7-00066l-St
	for gcvm-msysgit@m.gmane.org; Tue, 20 Aug 2013 09:31:02 +0200
Received: by mail-qa0-f55.google.com with SMTP id f11sf126614qae.0
        for <gcvm-msysgit@m.gmane.org>; Tue, 20 Aug 2013 00:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=S2aXa8yLKSx8OqhU511M8qec7qh7s54OsouRn8aiUH0=;
        b=B8e3zqSF54WRi5xEy/2TheyH6KB8ooOcxxZhzkmiKHKHA82izgIg4gLo01ikntAsDU
         AtxsD6+NULKrId0hm5lrSLkzoPneTrw2QVmk/iB53IPzQ2G5V1+pnsOxNuPxf1U1tEq3
         15fyT9XlzQ2okUQnR/0fC1K6GisFXbYICB/pPCOub6i1FsiheUmU5HN4F2N/W07P4qkR
         lsSU89Bv3NAdVATDZw+0uSt+eplvu6/ioFsESwHzaI8LA515XTG4wb5qGViKK6B++4l9
         TFGyTJPg+AjUBWZM/wNsVm914Y+uKbbXVhvuLLzpSbKMPX5/Tj9w/9i74Lh5RyvBqiAZ
         lJ0w==
X-Received: by 10.50.2.74 with SMTP id 10mr9081igs.15.1376983860573;
        Tue, 20 Aug 2013 00:31:00 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.88.98 with SMTP id bf2ls247164igb.15.gmail; Tue, 20 Aug
 2013 00:30:59 -0700 (PDT)
X-Received: by 10.66.121.169 with SMTP id ll9mr814328pab.38.1376983859614;
        Tue, 20 Aug 2013 00:30:59 -0700 (PDT)
Received: from smtpauth.rollernet.us (smtpauth.rollernet.us. [2607:fe70:0:3::d])
        by gmr-mx.google.com with ESMTPS id al8si45616pbd.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 20 Aug 2013 00:30:59 -0700 (PDT)
Received-SPF: pass (google.com: domain of michael@frog.wheelycreek.net designates 2607:fe70:0:3::d as permitted sender) client-ip=2607:fe70:0:3::d;
Received: from smtpauth.rollernet.us (localhost [127.0.0.1])
	by smtpauth.rollernet.us (Postfix) with ESMTP id 16D7E594021
	for <msysgit@googlegroups.com>; Tue, 20 Aug 2013 00:30:56 -0700 (PDT)
Received: from wheelycreek.net (unknown [203.59.141.93])
	by smtpauth.rollernet.us (Postfix) with ESMTPA
	for <msysgit@googlegroups.com>; Tue, 20 Aug 2013 00:30:55 -0700 (PDT)
Received: from majorie.localnet ([192.168.22.205]:40631)
	by wheelycreek.net with [XMail 1.26 ESMTP Server]
	id <S3048> for <msysgit@googlegroups.com> from <michael@frog.wheelycreek.net>;
	Tue, 20 Aug 2013 07:30:54 -0000
User-Agent: KMail/4.10.5 (Linux/3.8.0-27-generic; KDE/4.10.5; x86_64; ; )
In-Reply-To: <20130810163459.GE25779@paksenarrion.iveqy.com>
X-Rollernet-Abuse: Processed by Roller Network Mail Services. Contact abuse@rollernet.us to report violations. Abuse policy: http://www.rollernet.us/policy
X-Rollernet-Submit: Submit ID 3d25.52131b2f.a17f2.0
X-Original-Sender: michael@frog.wheelycreek.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of michael@frog.wheelycreek.net designates
 2607:fe70:0:3::d as permitted sender) smtp.mail=michael@frog.wheelycreek.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232586>

This type of functionality is directly supported by the work I've already done 
on symlinks here:   https://github.com/frogonwheels/git   
(branches mrg/symlink-v*  )

Even if we agree that symlinks only work to a limited degree, or that there 
are definite limitations, and that the default should be that symlinks NOT be 
supported within repositories, I'm not sure why people are against 
incorporating what I've already implemented.. ok well I guess I do - it's 
about time.

Firstly, at the least it means that symlinks like this example where they are  
outside the repository are supported.  Secondly it means that people who are 
prepared to accept the limitations will be able to use (or at least clone) 
repositories containing symlinks.

One of the big, painful limitations is that windoze symlinks need to be marked 
as directories at the time of creation.  The code I have implemented does it's 
level best to create the correct type of NTFS symlink based on repository 
information and falling back on filesystem information.

The argument about permissions is only partially valid, since that can be 
granted as an individual permission to the user without permanent 
administrator rights.

//.ichael G.

On Sat, 10 Aug 2013 06:34:59 PM Fredrik Gustafsson wrote:
> On Sat, Aug 10, 2013 at 07:22:03PM +0300, Sedat Kapanoglu wrote:
> > > git is a disk intense program, so this setup is not sane at all. With
> > > that said I know that git on windows historically had problems with
> > > working on smb-mounted shares (sometimes you're forced to have stupid
> > > setups). I doubt that git really is the right tool for your work, since
> > 
> > I reproduced the same problem in a regular symlink directory. Repro steps:
> > 
> > mkdir actualdir
> > mklink /d symdir actualdir
> > cd symdir
> > git init .
> > 
> > fatal: Invalid symlink 'D:/gitto': Function not implemented
> > 
> > Thanks,
> > 
> > Sedat
> 
> Good, then we can determinate that this is a symlink error, it seams
> that readlink() isn't implemented in the msysgit version of msysgit.
> 
> However msysgit should have a implementation of readlink() according to:
> http://mingw.5.n7.nabble.com/Replacement-for-readlink-td30679.html
> 
> I've CC:ed the msysgit-maillist so that they can decide if this is
> something they want to address in newer releases.
> 
> (In the git source code the readlink call in this abspath.c)

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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
