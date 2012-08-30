From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: relative objects/info/alternates doesn't work on remote
 SMB repo
Date: Thu, 30 Aug 2012 20:22:12 +0700
Message-ID: <CACsJy8B3=33FE-SbOD6Su4v_DbyuYsxfh-DxAzbJbJa5B2pyLg@mail.gmail.com>
References: <CAGHpTBKNurqd0xcz9A9bC8MQU8yHfef0ozJ2Khr9uQvwHoyP2g@mail.gmail.com>
 <CACsJy8BSpX7UxAEhZTqNnazAtSMp7oZtyxiBdnVoCXefWpTDEw@mail.gmail.com> <CAGHpTB+TbrQLw7E+RpP8y0euYrLNOC6-sic-4x3pbxcAborFLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Orgad and Raizel Shaneh <orgads@gmail.com>
X-From: msysgit+bncCLWW9eeFGBCn0v2BBRoEJIY5vw@googlegroups.com Thu Aug 30 15:22:53 2012
Return-path: <msysgit+bncCLWW9eeFGBCn0v2BBRoEJIY5vw@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f186.google.com ([209.85.216.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCLWW9eeFGBCn0v2BBRoEJIY5vw@googlegroups.com>)
	id 1T74hu-00074K-00
	for gcvm-msysgit@m.gmane.org; Thu, 30 Aug 2012 15:22:50 +0200
Received: by qcsc2 with SMTP id c2sf1520215qcs.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 30 Aug 2012 06:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:from
         :date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=0pMGpHAwDvBmPYyTI+iO9/6hs8wEYe9vAXveZMo/S80=;
        b=ufipg7CLH1tEPErKBdBFrcR6JVbZsdowHzQXxhPyG/nSLbXW2AZ1+EMlc7IxH0gzxh
         7SQUPb+0aHEI0LUdMDM5ym78wLdAN3koSY3YVZZCjtZYrBu8BGrnIBHn9zIjLS70t+Fq
         VYDxcaa5JRTXJvutInaaU7NGg6Y/vPFhc7OsNI+nU4MIxUhQwYBm0PbIziOTV+jC50CX
         rC4LJTPq0zGPvtc4OVyANGKUPVQCnJMTn9kdskxzF5ckqa+PIZTtUhipxmhSCPB5oH5G
         SxVhkkZaaJnmUuaCPzHNoUHtxnD6bSIP6wcUWvwWO4QVbof3huiiYabEts12zqtE9fAs
         Rmyw==
Received: by 10.224.209.133 with SMTP id gg5mr1179442qab.5.1346332967294;
        Thu, 30 Aug 2012 06:22:47 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.224.95.200 with SMTP id e8ls5085926qan.5.gmail; Thu, 30 Aug
 2012 06:22:46 -0700 (PDT)
Received: by 10.224.189.75 with SMTP id dd11mr3385004qab.6.1346332966487;
        Thu, 30 Aug 2012 06:22:46 -0700 (PDT)
Received: by 10.224.189.75 with SMTP id dd11mr3385001qab.6.1346332966477;
        Thu, 30 Aug 2012 06:22:46 -0700 (PDT)
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com [209.85.216.51])
        by gmr-mx.google.com with ESMTPS id g28si401205qcq.2.2012.08.30.06.22.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 30 Aug 2012 06:22:46 -0700 (PDT)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 209.85.216.51 as permitted sender) client-ip=209.85.216.51;
Received: by qadz3 with SMTP id z3so160944qad.3
        for <msysgit@googlegroups.com>; Thu, 30 Aug 2012 06:22:46 -0700 (PDT)
Received: by 10.224.17.145 with SMTP id s17mr10911144qaa.99.1346332966355;
 Thu, 30 Aug 2012 06:22:46 -0700 (PDT)
Received: by 10.49.4.6 with HTTP; Thu, 30 Aug 2012 06:22:12 -0700 (PDT)
In-Reply-To: <CAGHpTB+TbrQLw7E+RpP8y0euYrLNOC6-sic-4x3pbxcAborFLQ@mail.gmail.com>
X-Original-Sender: pclouds@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of pclouds@gmail.com designates 209.85.216.51 as permitted sender)
 smtp.mail=pclouds@gmail.com; dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204537>

On Thu, Aug 30, 2012 at 8:12 PM, Orgad and Raizel Shaneh
<orgads@gmail.com> wrote:
>> Could be path normalization. What does "git rev-parse --git-dir" say?
>> Try to run it at top working directory and a subdirectory as well.
>>
>> If you set GIT_OBJECT_DIRECTORY environment variable to
>> //server/share/foo/repo/.git/objects, does it work?
>
> git rev-parse --git-dir in a subdirectory has //server

Hmm where is your git repository? That does not look like a git
repository's path.

> setting GIT_OBJECT_DIRECTORY prints "fatal: bad object HEAD" on git status.

I guessed you put your repo in .../repo/.git, but I was probably
wrong. Try setting again, pointing GIT_OBJECT_DIRECTORY to the
"objects" directory inside your repository. I just want to make see if
it's because git miscalculates this path. If setting the env variable
works, then it probably does.
-- 
Duy

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
