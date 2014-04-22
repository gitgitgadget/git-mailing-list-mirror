From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [NOT_A_PATCH] A naive attempt to cross-build
 Linux->mingw64 Git
Date: Tue, 22 Apr 2014 15:36:05 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1404221530020.14982@s15462909.onlinehome-server.info>
References: <535569e92cbcc_32c48493101f@nysa.notmuch> <1398118479-7731-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Felipe Contreras <felipe.contreras@gmail.com>, 
    Sebastian Schuberth <sschuberth@gmail.com>, 
    Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org, 
    msysGit Mailinglist <msysgit@googlegroups.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: msysgit+bncBCZPH74Q5YNRBUHA3GNAKGQEQ6TKYCQ@googlegroups.com Tue Apr 22 15:36:17 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBUHA3GNAKGQEQ6TKYCQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f187.google.com ([74.125.82.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBUHA3GNAKGQEQ6TKYCQ@googlegroups.com>)
	id 1Wcarw-0004m8-Sm
	for gcvm-msysgit@m.gmane.org; Tue, 22 Apr 2014 15:36:16 +0200
Received: by mail-we0-f187.google.com with SMTP id x48sf431001wes.4
        for <gcvm-msysgit@m.gmane.org>; Tue, 22 Apr 2014 06:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=VbDjTPqn8Uk44K+N/43EGlPhbWz6cEg8kmjp8wW3fQU=;
        b=je3HY1lvzQPYuOCZHpIcqET/ruAWScuS8/18okTsrZ3F0klnrxsGhOikTVwxGX+bDB
         rRYQvnYwPXpNxyOi+xYdySjz1nlyG3JvsnefQYwPUvwk+VmAkW52pZ0aGLiNiv27LW4J
         vruh0Sa9I/zomF6C/Ex1jpPGaZqagyeZPt/idy7G3iEDCsFON8SZTLbBwfT+Zmz/4o1x
         uw0+rXqwoy2D8JDjjKkquj/gtaefJbT2sGlQ6+I0oMyV95kHfYrG4KS+YBXRDkTE6HXZ
         QRWZs/DEahsOmWgk5veZTmwYTqczBhNTapByJIz1Z4REYNr7i4adpyqS5RR4jqOSlGSB
         Sfyw==
X-Received: by 10.180.36.143 with SMTP id q15mr62556wij.2.1398173776445;
        Tue, 22 Apr 2014 06:36:16 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.207.83 with SMTP id lu19ls67797wic.13.gmail; Tue, 22 Apr
 2014 06:36:15 -0700 (PDT)
X-Received: by 10.14.219.194 with SMTP id m42mr30980eep.7.1398173775725;
        Tue, 22 Apr 2014 06:36:15 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.18])
        by gmr-mx.google.com with ESMTPS id m49si350436eeu.0.2014.04.22.06.36.15
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Apr 2014 06:36:15 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.18 as permitted sender) client-ip=212.227.15.18;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0MH4Os-1WgOV23khe-00Dl5p;
 Tue, 22 Apr 2014 15:36:06 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <1398118479-7731-1-git-send-email-marat@slonopotamus.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:L7ZzFcNzOkSfbXta035KGBTb+S2zR7a2FTfPAPVK88Zj0iciU8i
 ipfk4SKoLYTXwV1qKPffWfy4wwv9v/if+PJlhtsztR+zTiy+YfIud3k/sUaQumAXrcplE9W
 1ESEKvMhj1wpOHP0PdGRzemYvI5KdNu7HJrYY+GAziHXKtQJXg212Xr/pn+It3p2l7UL2UY
 FJ0FocQ4zXdmdC3Oqt/GQ==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.18 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246736>

Hi Marat,

On Tue, 22 Apr 2014, Marat Radchenko wrote:

> Johannes says building mingw64 Git is dirt-easy.

Marat, please let's stop misquoting me, okay?

What I said was more along the lines that there had been some start of a
work on getting things to compile for 64-bit Windows, but that the test
suite did not pass.

Even cutting out the part about the test suite from quoting me leaves out
the main point of what I said.

And for the record: I just had a look; the beginnings of W64 support are
in https://github.com/msysgit/git/compare/7f37564...work/w64.

And again for the record: at least from my side, there is more than just
willingness to cooperate. We'd just need to start a conversation in the
second person (as opposed to the third person).

Ciao,
Johannes

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
