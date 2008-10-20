From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI,MINGW) 0/3] Fix OpenSSH & Git-Gui
 integration in msysgit
Date: Mon, 20 Oct 2008 20:02:17 +0400
Message-ID: <1224518540-23782-1-git-send-email-angavrilov@gmail.com>
Reply-To: ANGavrilov@gmail.com
Cc: msysgit@googlegroups.com, Johannes Sixt <johannes.sixt@telecom.at>, "Shawn O. Pearce" <spearce@spearce.org>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Oct 20 21:13:53 2008
connect(): Connection refused
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f62.google.com ([209.85.217.62])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrxG3-0006WK-4v
	for gcvm-msysgit@m.gmane.org; Mon, 20 Oct 2008 18:05:51 +0200
Received: by gxk22 with SMTP id 22so2628376gxk.21
        for <gcvm-msysgit@m.gmane.org>; Mon, 20 Oct 2008 09:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:received:received:from:to:cc
         :subject:date:message-id:x-mailer:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=esOKBiK3P5yHlXAMKY/1wYXu9vdBj/8VKtuIfKPMZ2M=;
        b=DsYlsDb17p2tmkZO07C36IoGWRQ1TsJ2lrVcpECk7fbRrU6UMEKFhoxAqdJSxrBYYZ
         32Su53/0KHwFrthoVtW6aN9bAzwoZRJMawOOokS6G3QkXXBmQLaiujpOuePvkIp/1k+m
         +XS4DZRLgq7vneOyikS4dYDozbcJB9hHMHeCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:reply-to:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=jjNvqlYV9min4NnD98upuyHLN8EE6haa07gD/9NQUcF1LXjsQeBFmg+2A9DXB8qe/I
         ZgJlyppHUNve57dxFO/WVpOrITjXMO/JAE+Pf3IIDpUpeE9ni84Dua5RJzWynQbvTLg8
         4Jjwwd4ojeYQ6Lv4MelFMUonKJ/n0/7I/xzeQ=
Received: by 10.90.78.14 with SMTP id a14mr392367agb.29.1224518653557;
        Mon, 20 Oct 2008 09:04:13 -0700 (PDT)
Received: by 10.106.144.6 with SMTP id r6gr3114prd.0;
	Mon, 20 Oct 2008 09:04:13 -0700 (PDT)
X-Sender: angavrilov@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.117.17 with SMTP id p17mr4704355agc.9.1224518652683; Mon, 20 Oct 2008 09:04:12 -0700 (PDT)
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156]) by mx.google.com with ESMTP id 7si8980102yxg.0.2008.10.20.09.04.11; Mon, 20 Oct 2008 09:04:11 -0700 (PDT)
Received-SPF: pass (google.com: domain of angavrilov@gmail.com designates 72.14.220.156 as permitted sender) client-ip=72.14.220.156;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of angavrilov@gmail.com designates 72.14.220.156 as permitted sender) smtp.mail=angavrilov@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by fg-out-1718.google.com with SMTP id d23so1481662fga.32 for <msysgit@googlegroups.com>; Mon, 20 Oct 2008 09:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer; bh=9j0IILU1UYSeQz6fGR2XLM0AV2OC79AI80AX3bovTUc=; b=oe8F5vfTmgw1OLYnjqxUZLEwFEWrEooBk5gOXqkhrPki7z4Kxn6/64HdP8xSrO6OPy uQSKzszuyuuR4Yw0mqtLz9s+hKZyLReEzV3/AuUFBnHa+953GLCSyGiuem55Gzs9WTBg Swt5OCqBZmiEnYuhP4kKDrAl9K++VIc5qR6UI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer; b=f5BmldlG/UXxv3mf5z0+Z370UWekWmKmaG5hM5TDyIVglhbpWb/SRx5QmxXMI0LgAn /yxt6NlDnMRcbGgiN87uO414LLB12vOa5gb4l7fqqFTrtodC8dU8xuYTQ6aaRb57heM/ 8anfCX5kKfPXg93haLAyYq4uhhad4zBU8S7ak=
Received: by 10.181.10.10 with SMTP id n10mr737480bki.68.1224518650793; Mon, 20 Oct 2008 09:04:10 -0700 (PDT)
Received: from localhost.localdomain ([92.255.85.78]) by mx.google.com with ESMTPS id p17sm7985073fka.14.2008.10.20.09.04.08 (version=SSLv3 cipher=RC4-MD5); Mon, 20 Oct 2008 09:04:10 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98693>


It is a well known problem on msysgit that when ssh is started
from git-gui during a fetch, any situations where it normally
displays a prompt to the user cause it to hang silently. It is
even worse than the situation on Linux, where the prompts appear
on the terminal that started the GUI.

This combination of 3 patches aims to eliminate this problem. One
of them changes a flag that is used to spawn the ssh executable,
to make it recognize that it does not have a valid controlling
console. The other two add features to git-gui that make ssh
usage more convenient, including a simple implementation of an
SSH_ASKPASS program.

When the patches are applied, all SSH prompts in msysgit
appear in a GUI dialog box in the middle of the screen.
Additionally, it is possible to view or create an OpenSSH
key pair directly from git-gui.


Note: This was already posted to the msysgit list. The only differences
      are that git-gui now sets a more evidently fake value for DISPLAY,
      and the last patch has been acked.


GIT-GUI:

	git-gui: Add a dialog that shows the OpenSSH public key.
	---
	 git-gui.sh     |    4 ++
	 lib/sshkey.tcl |  126 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	 2 files changed, 130 insertions(+), 0 deletions(-)
	 create mode 100644 lib/sshkey.tcl

	git-gui: Add a simple implementation of SSH_ASKPASS.
	---
	 Makefile         |    2 ++
	 git-gui.sh       |   12 ++++++++++++
	 git-gui--askpass |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	 3 files changed, 73 insertions(+), 0 deletions(-)
	 create mode 100755 git-gui--askpass


CORE(MINGW):

	Windows: Make OpenSSH properly detect tty detachment.
	---
	 compat/mingw.c |    8 ++++++--
	 1 files changed, 6 insertions(+), 2 deletions(-)
