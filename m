From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Git for Windows 1.9.4.msysgit.1
Date: Fri, 15 Aug 2014 19:14:22 +0200
Message-ID: <53EE3FEE.5090905@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>
To: msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCL7JHHTPAIPN75YT4CRUBFV4UG2M@googlegroups.com Fri Aug 15 19:14:31 2014
Return-path: <msysgit+bncBCL7JHHTPAIPN75YT4CRUBFV4UG2M@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f184.google.com ([209.85.212.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCL7JHHTPAIPN75YT4CRUBFV4UG2M@googlegroups.com>)
	id 1XIL5D-0005ss-5n
	for gcvm-msysgit@m.gmane.org; Fri, 15 Aug 2014 19:14:31 +0200
Received: by mail-wi0-f184.google.com with SMTP id n3sf121159wiv.1
        for <gcvm-msysgit@m.gmane.org>; Fri, 15 Aug 2014 10:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=Yt+Pm1anGlea35/VfsVkPoKnWkbbyrzqt5wXPYncBNQ=;
        b=yUefsOddBP87IMThl4ebbUI/IhUEg8smXrP6RFIwb86PEZehJgKGx9O8XjL2rjDIDg
         Z3kHjHVii1BnDXPc/vB5SKsPb9fvloNpbcXqa86i7/8GLrxY4t6GLdi+fDbC8hMcOn6a
         WRlX/yUuyK6IsKTrmZNMtG5Pgm1TWRKJxeGDxKq8or2gruUcbCzAlZQYGhE+sEU2ihB+
         4qoP1Lwugoqrz6Iot3ZNkehBjBxVje0zJiqMs95ccb0T5HqE8mm2MiqysmSqN9kW9Kqg
         KUKwmA8ABwDYSAXsuNugAj78C7OziAHLqMy8+T+yYTCI+sQz9Tw9/KI+Xc+3mXPu8/9I
         vuCQ==
X-Received: by 10.180.100.106 with SMTP id ex10mr224158wib.7.1408122870782;
        Fri, 15 Aug 2014 10:14:30 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.98.225 with SMTP id el1ls126455wib.29.canary; Fri, 15 Aug
 2014 10:14:29 -0700 (PDT)
X-Received: by 10.194.100.3 with SMTP id eu3mr296875wjb.6.1408122869931;
        Fri, 15 Aug 2014 10:14:29 -0700 (PDT)
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de. [2a01:488:42::50ed:84a3])
        by gmr-mx.google.com with ESMTPS id nw2si671064lbb.0.2014.08.15.10.14.29
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 15 Aug 2014 10:14:29 -0700 (PDT)
Received-SPF: none (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted sender hosts) client-ip=2a01:488:42::50ed:84a3;
Received: from p5ddc2d5e.dip0.t-ipconnect.de ([93.220.45.94] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1XIL5A-00070t-Fn; Fri, 15 Aug 2014 19:14:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1408122869;4a313582;
X-Original-Sender: thomas.braun@virtuell-zuhause.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted
 sender hosts) smtp.mail=thomas.braun@virtuell-zuhause.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255296>

Hi,

the Git for Windows team just released the second maintenance release of
the Windows-specific installers for git 1.9.4.

It can be downloaded from the usual place [1] and I also attached some
(although non-gpg signed) SHA sums [2].


New Features

    Comes with Git 1.9.4 plus Windows-specific patches
    Add vimtutor (msysgit PR #220)
    Update OpenSSH to 6.6.1p1 and its OpenSSL to 1.0.1i (msysgit PR
#221, #223, #224, #226, #229, #234, #236)
    Update mingw OpenSSL to 0.9.8zb (msysgit PR #241, #242)

Bugfixes

    Checkout problem with directories exceeding MAX_PATH (PR
msysgit/git#212, msysgit #227)
    Backport a webdav fix from junio/maint (d9037e http-push.c: make
CURLOPT_IOCTLDATA a usable pointer, PR msysgit/git#230)

Regressions

    git svn is/might be broken. Fixes welcome.


Have phun,
Thomas


[1]:
https://github.com/msysgit/msysgit/releases/download/Git-1.9.4-preview20140815/Git-1.9.4-preview20140815.exe
[2]:
SHA1(Git-1.9.4-preview20140815.exe)=
88dd56d612431055a5c5d65c3b2f23736ad725b0
SHA1(msysGit-netinstall-1.9.4-preview20140815.exe)=
c2cb700839fdcea79b5401f046878de711628ccc
SHA1(PortableGit-1.9.4-preview20140815.7z)=
4deafc5fede624437c68d101a660a78bdb56f899

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
For more options, visit https://groups.google.com/d/optout.
