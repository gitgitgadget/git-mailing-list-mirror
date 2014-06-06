From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 0/5] Windows dirent patches
Date: Fri,  6 Jun 2014 22:15:39 +0200
Message-ID: <1402085744-15829-1-git-send-email-kasal@ucw.cz>
References: <5391ED57.1000601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRB6OCZCOAKGQEVG45WZQ@googlegroups.com Fri Jun 06 22:15:59 2014
Return-path: <msysgit+bncBCU63DXMWULRB6OCZCOAKGQEVG45WZQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f58.google.com ([209.85.215.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB6OCZCOAKGQEVG45WZQ@googlegroups.com>)
	id 1Wt0YL-0005KD-T3
	for gcvm-msysgit@m.gmane.org; Fri, 06 Jun 2014 22:15:53 +0200
Received: by mail-la0-f58.google.com with SMTP id s18sf416222lam.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 13:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=L2lW7NHKq2imTr2IblXATyI3ilKNliKESlSp8knBsPs=;
        b=cc0lbCwdwOEblS+Ay5LtPA+jkIGk7cyJ9gkKTnHrP864yqRS7WZjTPEmeMwOnN2SAs
         u9fnNcJvZElk+tUH0++vTCnFmoLmRBBwSpAzDD+8KrtGogcLeCZol7lb9u0Ov2YuDyFW
         chwAJN6A3W1dgCf2AYSpM18p3ofbx/j0QCCPW/worZmGcMZPrDllJDkN5Ib6tXnm6PK1
         tCFUf9MsmkeB5+gz2PvAzZWxM1pddFU2SMgnLJQuh9TXIjkVx1/gMSrUfDrDNrwVFE9z
         ivu1HYLIKl+Kz4IVZeqlLJTC4QsCmfGpA5/aRGUeQaUi7fySILQQtbg1UyN/vY7/f7OB
         hdIA==
X-Received: by 10.180.75.13 with SMTP id y13mr37038wiv.3.1402085753712;
        Fri, 06 Jun 2014 13:15:53 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.99.39 with SMTP id en7ls155801wib.8.gmail; Fri, 06 Jun
 2014 13:15:52 -0700 (PDT)
X-Received: by 10.180.212.12 with SMTP id ng12mr1549997wic.7.1402085752903;
        Fri, 06 Jun 2014 13:15:52 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id xk11si1421717wib.0.2014.06.06.13.15.52
        for <msysgit@googlegroups.com>;
        Fri, 06 Jun 2014 13:15:52 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id AC2EC1C00A5; Fri,  6 Jun 2014 22:15:52 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <5391ED57.1000601@gmail.com>
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250962>

On Fri, Jun 06, 2014 at 06:33:27PM +0200, Karsten Blees wrote:
> The dates are actually missing from the patches, [...]

oops, this was first time I tried to use git-send-email.
I hope this time it'll work better.
Stepan

Hello,

This is a series of dirent modifications, 4 tiny ones and one bigger.
As the date indicates, these are battle tested in mysgit for several years.

Regards,
	Stepan

Karsten Blees (5):
  Win32 dirent: remove unused dirent.d_ino member
  Win32 dirent: remove unused dirent.d_reclen member
  Win32 dirent: change FILENAME_MAX to MAX_PATH
  Win32 dirent: clarify #include directives
  Win32 dirent: improve dirent implementation

 compat/win32/dirent.c | 116 ++++++++++++++++++++++++--------------------------
 compat/win32/dirent.h |   8 +---
 config.mak.uname      |   2 +
 3 files changed, 59 insertions(+), 67 deletions(-)

-- 
2.0.0.9635.g0be03cb

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
