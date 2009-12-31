From: Kirill <kirillathome@gmail.com>
Subject: [PATCH] Provide a window icon on Windows platforms
Date: Thu, 31 Dec 2009 14:57:50 -0500
Message-ID: <1262289470-4208-1-git-send-email-kirillathome@gmail.com>
Mime-Version: 1.0
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: 3RwI9SwwJB9E75E588xG4B9139x58.zB99FLF35G3BB3813EBHCF.zB9@listserv.bounces.google.com Thu Dec 31 20:58:17 2009
Return-path: <3RwI9SwwJB9E75E588xG4B9139x58.zB99FLF35G3BB3813EBHCF.zB9@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f141.google.com ([209.85.221.141])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQRA1-0001IY-Ap
	for gcvm-msysgit@m.gmane.org; Thu, 31 Dec 2009 20:58:17 +0100
Received: by mail-qy0-f141.google.com with SMTP id 5sf28145390qyk.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 31 Dec 2009 11:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe;
        bh=YZdEgudQWA9gSYhst4jCARs7w98RqLwo4FlceeS6f4g=;
        b=elfTDjfxXt/JlBMg/XULz2Lgi4cAShsRjyYVakTtuYrGfr5229H4BRjfWc/bLsYER5
         UcsndeeM9sBdTep2+o5uJ6GMGEDzkKHMbTMKRSHD3AeK1EHH4yxzw+j+LnJg9L978eMr
         O4yD1GflG9r9xoZ30Yk5ZK9RN9+JTvupDNlUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:x-original-authentication-results
         :x-original-sender:precedence:mailing-list:list-id:list-post
         :list-help:list-archive:x-thread-url:x-message-url:sender
         :list-unsubscribe:list-subscribe;
        b=b4IYWRHGAaXFolXanDrCTV2qLq9AXPoI7hO23sNjrjJnkqCoEkLoow6UI9r9FwH8ed
         6MaiqRTXqcEX4h4na/KOL9XB/qL6f+/c1ZtJ7YHFOFvOMAX9iYC0SaiDdDtHbxcanZew
         t1O2EFeAuIaRiwF7MJ+u6FBHZuXYGJpyvHlM0=
Received: by 10.229.69.74 with SMTP id y10mr3597287qci.28.1262289479922;
        Thu, 31 Dec 2009 11:57:59 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.229.100.199 with SMTP id z7ls612013qcn.0.p; Thu, 31 Dec 2009 
	11:57:58 -0800 (PST)
Received: by 10.229.30.139 with SMTP id u11mr3859510qcc.6.1262289477823;
        Thu, 31 Dec 2009 11:57:57 -0800 (PST)
Received: by 10.229.30.139 with SMTP id u11mr3859509qcc.6.1262289477800;
        Thu, 31 Dec 2009 11:57:57 -0800 (PST)
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.145])
        by gmr-mx.google.com with ESMTP id 18si4167301qyk.13.2009.12.31.11.57.56;
        Thu, 31 Dec 2009 11:57:56 -0800 (PST)
Received-SPF: pass (google.com: domain of kirillathome@gmail.com designates 74.125.92.145 as permitted sender) client-ip=74.125.92.145;
Received: by qw-out-1920.google.com with SMTP id 5so2248750qwc.32
        for <msysgit@googlegroups.com>; Thu, 31 Dec 2009 11:57:56 -0800 (PST)
Received: by 10.224.116.146 with SMTP id m18mr9429574qaq.374.1262289476673;
        Thu, 31 Dec 2009 11:57:56 -0800 (PST)
Received: from localhost (ip69-17-233-41.vif.net [69.17.233.41])
        by mx.google.com with ESMTPS id 23sm13315934qyk.15.2009.12.31.11.57.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 31 Dec 2009 11:57:55 -0800 (PST)
X-Mailer: git-send-email 1.6.4.msysgit.0.597.gcd48
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of kirillathome@gmail.com designates 74.125.92.145 as permitted 
	sender) smtp.mail=kirillathome@gmail.com; dkim=pass (test mode) 
	header.i=@gmail.com
X-Original-Sender: kirillathome@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=>
X-Thread-Url: http://groups.google.com/group/msysgit/t/80f1c5d3df016c97
X-Message-Url: http://groups.google.com/group/msysgit/msg/51b3c27bcd74db15
Sender: msysgit@googlegroups.com
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135969>

Looks like 37871b73 by Giuseppe Bilotta does not work very well on Windows.
Instead of a former tcl/tk icon, the window has a black square as an icon.

This patch is a copy-paste from Git Gui, which uses a separate .ico file
when it runs on Windows platforms.
---
The patch is in line with what Giuseppe Bilotta proposed in
[PATCH] gitk: try to set program icon on 2008-11-15 23:45:45 GMT 
Unfortunately, I could not find any particular reason why that
patch was not applied, but without it, Gitk on Windows does
not look as nice as it could.

The changes in the Makefile were only sanity-checked, not tested in the
full-fledged build or install.

CC to msysGit list is because the changes are actually made and
tested on top of git version 1.6.4.msysgit.0.597.gcd48

 gitk-git/Makefile     |    3 ++
 gitk-git/gitk         |   50 ++++++++++++++++++++++++++++++------------------
 gitk-git/gitk-gui.ico |  Bin 0 -> 3638 bytes
 3 files changed, 34 insertions(+), 19 deletions(-)
 create mode 100644 gitk-git/gitk-gui.ico

diff --git a/gitk-git/Makefile b/gitk-git/Makefile
index e1b6045..dd158bf 100644
--- a/gitk-git/Makefile
+++ b/gitk-git/Makefile
@@ -5,6 +5,7 @@ prefix ?= $(HOME)
 bindir ?= $(prefix)/bin
 sharedir ?= $(prefix)/share
 gitk_libdir   ?= $(sharedir)/gitk/lib
+gitk_libdir_SQ  = $(subst ','\'',$(gitk_libdir))
 msgsdir    ?= $(gitk_libdir)/msgs
 msgsdir_SQ  = $(subst ','\'',$(msgsdir))
 
@@ -43,10 +44,12 @@ install:: all
 	$(INSTALL) -m 755 gitk-wish '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(msgsdir_SQ)'
 	$(foreach p,$(ALL_MSGFILES), $(INSTALL) -m 644 $p '$(DESTDIR_SQ)$(msgsdir_SQ)' &&) true
+	$(INSTALL) -m 644 gitk-gui.ico '$(DESTDIR_SQ)$(gitk_libdir_SQ)'/gitk-gui.ico
 
 uninstall::
 	$(foreach p,$(ALL_MSGFILES), $(RM) '$(DESTDIR_SQ)$(msgsdir_SQ)'/$(notdir $p) &&) true
 	$(RM) '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
+	$(RM) '$(DESTDIR_SQ)$(gitk_libdir_SQ)'/gitk-gui.ico
 
 clean::
 	$(RM) gitk-wish po/*.msg
diff --git a/gitk-git/gitk b/gitk-git/gitk
index b6a0daa..661904f 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -11248,30 +11248,42 @@ set patchnum 0
 set lserial 0
 set isworktree [expr {[exec git rev-parse --is-inside-work-tree] == "true"}]
 setcoords
-makewindow
-catch {
-    image create photo gitlogo      -width 16 -height 16
 
-    image create photo gitlogominus -width  4 -height  2
-    gitlogominus put #C00000 -to 0 0 4 2
-    gitlogo copy gitlogominus -to  1 5
-    gitlogo copy gitlogominus -to  6 5
-    gitlogo copy gitlogominus -to 11 5
-    image delete gitlogominus
+if {$::tcl_platform(platform) eq {windows}} {
+	wm iconbitmap . -default $gitk_libdir/gitk-gui.ico
+	set ::tk::AlwaysShowSelection 1
+
+	# Spoof an X11 display for SSH
+	if {![info exists env(DISPLAY)]} {
+		set env(DISPLAY) :9999
+	}
+} else {
+	catch {
+	    image create photo gitlogo      -width 16 -height 16
+
+	    image create photo gitlogominus -width  4 -height  2
+	    gitlogominus put #C00000 -to 0 0 4 2
+	    gitlogo copy gitlogominus -to  1 5
+	    gitlogo copy gitlogominus -to  6 5
+	    gitlogo copy gitlogominus -to 11 5
+	    image delete gitlogominus
 
-    image create photo gitlogoplus  -width  4 -height  4
-    gitlogoplus  put #008000 -to 1 0 3 4
-    gitlogoplus  put #008000 -to 0 1 4 3
-    gitlogo copy gitlogoplus  -to  1 9
-    gitlogo copy gitlogoplus  -to  6 9
-    gitlogo copy gitlogoplus  -to 11 9
-    image delete gitlogoplus
+	    image create photo gitlogoplus  -width  4 -height  4
+	    gitlogoplus  put #008000 -to 1 0 3 4
+	    gitlogoplus  put #008000 -to 0 1 4 3
+	    gitlogo copy gitlogoplus  -to  1 9
+	    gitlogo copy gitlogoplus  -to  6 9
+	    gitlogo copy gitlogoplus  -to 11 9
+	    image delete gitlogoplus
 
-    image create photo gitlogo32    -width 32 -height 32
-    gitlogo32 copy gitlogo -zoom 2 2
+	    image create photo gitlogo32    -width 32 -height 32
+	    gitlogo32 copy gitlogo -zoom 2 2
 
-    wm iconphoto . -default gitlogo gitlogo32
+	    wm iconphoto . -default gitlogo gitlogo32
+	}
 }
+
+makewindow
 # wait for the window to become visible
 tkwait visibility .
 wm title . "[file tail $argv0]: [file tail [pwd]]"
diff --git a/gitk-git/gitk-gui.ico b/gitk-git/gitk-gui.ico
new file mode 100644
index 0000000000000000000000000000000000000000..0f7a43d7b544e19581b0be7b6611b8ff9da94434
GIT binary patch
literal 3638
zcmeH~y-S=y5QoR)0>^O>ZLBQRBE&8*l~sa8I>E-;Zb_fQCdC!OIuH=Hvq(Zxr13Af
zDn%SDwTYEQKmyTDNMQ2Jyq=yPs1Vac_ipy%w;%Jovv;?9A|rB7CMSi|mXB?bN7P0~
zoA!$bBAaNBX-;C#uo1>(YBfdXBjjP3dLq1~*J}!Ls?zWGrT?uj`(HmutJRWryDi;r
zSH{N1WPE&FCMG6idU{%BW@cn@aZ%>y=VfkgPG)CkrT5BZVZr6CY>EFc`Lgv>w!VLt
zH=jP^NU?%d%$la6DVm~bXx<Dd=mou?7xaQ2(<*vJuQV!pMW+x$H*`Zc1VeY)PTMU#
zE4kudSxA|r;*##k6b6MsVNe(n2?m8hVNe(phQx$HVNe(p28AKfVNe(p28BUkP)CD9
z;n3i4&j_GU#;an6p~oY`QgB{yR9LjYl3}2;P${q!STZbd6gUbT1&#toh6;`XLxG{d
z5TPq@6c`E&hA$`25aOqK(a!KjbfCg_WmJY5-xa2c(~5%%Q^j|sv$9CVcg1&ZNBTy`
zf5m^re{503e<d~*h6+O^4zX=SC7&LJl03GN7#RKxHiN_Pms=Yg#K7RN;NZb>yP0IL
z7%T>a;V?e}uox4KL55(k@Wxn&Juz4;;*l)zX^34wgTY~N7#s$N!C}ac6AT7}!{9I&
z3@n2&9tMZOVQ?5&8bgP{VQ?560LQ<vm^0BCR9K_XE^v6R9b<}2$$ME^T9W1EWm#ES
zk=4~z+1S{S_4Rex-rkm-ogLZT-Icw)Jvlfyki)}6+5hG8Zf%Y4agXT6cOVMZ%T}x#
zO_xq2wA-6H9e%qOGY;o!5tXa@V|Juw-051(&(43?e-+=={mrvqlsC_RQBR}YME~=n
z)ajhB#ro&flaV*kA8Xv+#Bac*Y5(`rhhhCE-TT8f(9cdD9uxJm{b$>8Pl>C`BzAmH
zIlh;qcy~`ZIvwL=;yA*%OK>LL-BY+X5R1Ee3TOF$eox_-;4c$@P~tE?$*9NK++;)5
v6i*MmhU++{@~mpIp=$PAV}(nHH21Z<!sXp<^QFk^sm7u{=pSf<_MrR&teD_?

literal 0
HcmV?d00001

-- 
1.6.4.msysgit.0.597.gcd48
