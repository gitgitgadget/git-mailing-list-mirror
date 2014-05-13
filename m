From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 1/2] wincred: add install target
Date: Tue, 13 May 2014 08:01:01 +0200
Organization: <)><
Message-ID: <20140513060101.GB28182@camelia.ucw.cz>
References: <20140430064610.GA22094@camelia.ucw.cz> <CABPQNSZsviaGqFeKZE4ofF6HoUQrPvNPuowar4YDjk_Mbu5iCQ@mail.gmail.com> <20140430112724.GA22929@camelia.ucw.cz> <CABPQNSafKXDLyBj5OYW-PPWdxfxQtC23vKQsQ-_Pa1empU=n8g@mail.gmail.com> <20140513055953.GA28182@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>,
        Pat Thoyts <patthoyts@users.sourceforge.net>, msysgit@googlegroups.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBCU63DXMWULRBHXKY2NQKGQEG2CBBFI@googlegroups.com Tue May 13 08:01:06 2014
Return-path: <msysgit+bncBCU63DXMWULRBHXKY2NQKGQEG2CBBFI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f63.google.com ([74.125.83.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBHXKY2NQKGQEG2CBBFI@googlegroups.com>)
	id 1Wk5lx-0000hj-2k
	for gcvm-msysgit@m.gmane.org; Tue, 13 May 2014 08:01:05 +0200
Received: by mail-ee0-f63.google.com with SMTP id b57sf718733eek.8
        for <gcvm-msysgit@m.gmane.org>; Mon, 12 May 2014 23:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=5UhiGTgmDwF8bPi+GyEhXzxKtga1+ZzOWH2Jn0Rl6xU=;
        b=j1KsHBaDbIhy1X4UP7d6GOeAhiK7JCu8X89pUxNljT8FIEMRXhmEUTLZqDSj/9D2bf
         yEyI1J7lgrEwYfxdSp5oWBjd2o8yUuFibnDmwwVgXv7aL/2d4+5eqxqGrUZLK6BxeykH
         l3N6zT840WxxCbbrFJr1hCZKXhIMREDSpBZEW5xbO5NoyXxmahmNLbM0QhJnOnLpPsgY
         2Tl8UIaAJuK2KTN18mjVRuTVw0mbAtM5ATPos+muMbwijrtc2zh0/ethdj8/cwR01IRB
         ma6/ba9xRTT1Tki5AZdJ6xCEep/YnlCC1Fp5GQmC/zHjYJmlAF8NjdE1KvwKJKO3Novx
         ukbQ==
X-Received: by 10.180.97.199 with SMTP id ec7mr93188wib.17.1399960864663;
        Mon, 12 May 2014 23:01:04 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.205.234 with SMTP id lj10ls603538wic.22.gmail; Mon, 12 May
 2014 23:01:02 -0700 (PDT)
X-Received: by 10.180.82.134 with SMTP id i6mr2038060wiy.1.1399960862472;
        Mon, 12 May 2014 23:01:02 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id u49si1669872eeo.1.2014.05.12.23.01.02
        for <msysgit@googlegroups.com>;
        Mon, 12 May 2014 23:01:02 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 3C0A91C00E9;
	Tue, 13 May 2014 08:01:02 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s4D611oV028263;
	Tue, 13 May 2014 08:01:01 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s4D611Zi028258;
	Tue, 13 May 2014 08:01:01 +0200
In-Reply-To: <20140513055953.GA28182@camelia.ucw.cz>
User-Agent: Mutt/1.5.19 (2009-01-05)
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248748>

From: Pat Thoyts <patthoyts@users.sourceforge.net>
Date: Wed, 24 Oct 2012 00:15:29 +0100

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 contrib/credential/wincred/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/contrib/credential/wincred/Makefile b/contrib/credential/wincred/Makefile
index bad45ca..39fa5e0 100644
--- a/contrib/credential/wincred/Makefile
+++ b/contrib/credential/wincred/Makefile
@@ -7,8 +7,16 @@ CFLAGS = -O2 -Wall
 -include ../../../config.mak.autogen
 -include ../../../config.mak
 
+prefix ?= /usr/local
+libexecdir ?= $(prefix)/libexec/git-core
+
+INSTALL ?= install
+
 git-credential-wincred.exe : git-credential-wincred.c
 	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@
 
+install: git-credential-wincred.exe
+	$(INSTALL) -m 755 $^ $(libexecdir)
+
 clean:
 	$(RM) git-credential-wincred.exe
-- 
1.9.2.msysgit.0.161.g83227c1

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
