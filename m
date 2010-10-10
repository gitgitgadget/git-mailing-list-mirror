From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v3 00/14] daemon-win32
Date: Sun, 10 Oct 2010 15:20:40 +0200
Message-ID: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: msysgit@googlegroups.com,
	j6t@kdbg.org
To: git@vger.kernel.org
X-From: msysgit+bncCOPdven-DxDR-8blBBoEEnqLlQ@googlegroups.com Sun Oct 10 15:21:45 2010
Return-path: <msysgit+bncCOPdven-DxDR-8blBBoEEnqLlQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ww0-f58.google.com ([74.125.82.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxDR-8blBBoEEnqLlQ@googlegroups.com>)
	id 1P4vqT-0004cH-EL
	for gcvm-msysgit@m.gmane.org; Sun, 10 Oct 2010 15:21:45 +0200
Received: by wwi17 with SMTP id 17sf372505wwi.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 10 Oct 2010 06:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=yhgNrXSsgqcKKi1y2/gTJPNbPhyw/9B2UcSYEvxbdxs=;
        b=Tzs9vS/LH6xx2lxvoO6hBiTtEGMe2yKHvzA3zgaYhYyK5BAfvnE4PBkL9fQDaiqMKc
         G8rZP0VvKjvXfxwGkgR0Z7YQEcr6P5oSAtATc0kDddjRaVPdAmzX4gEyQKEEy9HpukPE
         hidPmO0Fcx2nJkbddIjMSP2XqOI8V833I1Fg0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:to:cc:subject:date:message-id
         :x-mailer:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        b=R6eMjjmVkhdFWZ2c2ze9cUawbD+TIRsyDsKdlVUdBtyONP2awuYe3DGLOaIgJ+2jYA
         jckeTot8/aSJbS3V0KhSe8M3au+gBSqbfNceEPgmRGj7alI+SY6hKtGeLbWxbrQNT/YP
         PQeshwjOVcMvgCMjG+WT1170gerobl/77JjL0=
Received: by 10.216.237.206 with SMTP id y56mr304901weq.12.1286716881708;
        Sun, 10 Oct 2010 06:21:21 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.36.29 with SMTP id v29ls172227eea.3.p; Sun, 10 Oct 2010
 06:21:20 -0700 (PDT)
Received: by 10.14.29.75 with SMTP id h51mr575043eea.21.1286716880613;
        Sun, 10 Oct 2010 06:21:20 -0700 (PDT)
Received: by 10.14.29.75 with SMTP id h51mr575042eea.21.1286716880591;
        Sun, 10 Oct 2010 06:21:20 -0700 (PDT)
Received: from mail-ew0-f43.google.com (mail-ew0-f43.google.com [209.85.215.43])
        by gmr-mx.google.com with ESMTP id w43si6044358eeh.7.2010.10.10.06.21.19;
        Sun, 10 Oct 2010 06:21:19 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.43 as permitted sender) client-ip=209.85.215.43;
Received: by ewy25 with SMTP id 25so1866578ewy.30
        for <msysgit@googlegroups.com>; Sun, 10 Oct 2010 06:21:19 -0700 (PDT)
Received: by 10.213.113.13 with SMTP id y13mr399367ebp.44.1286716879391;
        Sun, 10 Oct 2010 06:21:19 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id v8sm9032427eeh.8.2010.10.10.06.21.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 06:21:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.43 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158658>

Almost 9 months have passed since I sent v2, and here's finally v3.

Not so much have happened since v2, the most significant change being
that I've replaced our win32-poll implementation with the one from
gnulib. This gives our the poll-features needed for git-daemon, and
prevents a nasty timing-bug that occured (on Windows) in the previous
series.

Some of the patches have been ejected;
* "daemon: use select() instead of poll()" because our poll now is
  sufficient.
* "daemon: use explicit file descriptor" because it wasn't needed
  anymore, not even in the previous version.

One patch might be a little bit controversial; "daemon: only use posix
features on posix systems". It replaces "mingw: compile git-daemon", and
changes the logic from opt-out is WIN32 is defined to opt-in if
_POSIX_VERSION defined.

The current version is based on top of junio/next, because the
ab/daemon-multi-select series touches some of the same code.

v2 msgid is <1263591033-4992-1-git-send-email-kusmabite@gmail.com> if
you're interrested in comparing.

Erik Faye-Lund (10):
  inet_ntop: fix a couple of old-style decls
  mingw: use real pid
  mingw: support waitpid with pid > 0 and WNOHANG
  mingw: add kill emulation
  daemon: use run-command api for async serving
  daemon: use full buffered mode for stderr
  daemon: report connection from root-process
  mingw: import poll-emulation from gnulib
  mingw: use poll-emulation from gnulib
  daemon: only use posix features on posix systems

Martin Storsjö (1):
  Improve the mingw getaddrinfo stub to handle more use cases

Mike Pape (3):
  mingw: add network-wrappers for daemon
  mingw: implement syslog
  compat: add inet_pton and inet_ntop prototypes

 Makefile            |   12 +-
 compat/inet_ntop.c  |   22 +--
 compat/inet_pton.c  |    8 +-
 compat/mingw.c      |  291 +++++++++++++++++++-------
 compat/mingw.h      |   56 ++++--
 compat/win32/poll.c |  596 +++++++++++++++++++++++++++++++++++++++++++++++++++
 compat/win32/poll.h |   53 +++++
 daemon.c            |  199 ++++++++++--------
 git-compat-util.h   |   10 +
 9 files changed, 1045 insertions(+), 202 deletions(-)
 create mode 100644 compat/win32/poll.c
 create mode 100644 compat/win32/poll.h

-- 
1.7.3.1.51.ge462f.dirty
