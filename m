From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] git-gui: fix usage of themed widgets variable
Date: Sat, 20 Feb 2010 19:01:15 +0100
Message-ID: <20100220180114.GB15561@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@googlemail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, msysGit Mailinglist <msysgit@googlegroups.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: 3biOASwYKB10CQJDBOCQJDBO.I9OHNTNBDOBJJBG9BMJPKN.7JH@groups.bounces.google.com Sat Feb 20 19:31:03 2010
Return-path: <3biOASwYKB10CQJDBOCQJDBO.I9OHNTNBDOBJJBG9BMJPKN.7JH@groups.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f154.google.com ([209.85.210.154])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <3biOASwYKB10CQJDBOCQJDBO.I9OHNTNBDOBJJBG9BMJPKN.7JH@groups.bounces.google.com>)
	id 1Nite6-0006TX-JW
	for gcvm-msysgit@m.gmane.org; Sat, 20 Feb 2010 19:01:38 +0100
Received: by yxe26 with SMTP id 26sf3513675yxe.25
        for <gcvm-msysgit@m.gmane.org>; Sat, 20 Feb 2010 10:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:date:from:to:cc:subject
         :message-id:mime-version:user-agent
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=iZ7xFc0r5MEhP9x+IyT5YS4jxfsFYtdcvQb5CWMGF3E=;
        b=YBLS/pcMnPx5QVruBd7EiCRR2O+GHoJB+zb7hHxImPYFkFLWzQAF6imGv9MxZdoOvW
         UIpXRRFnRfZvIB1i8Z+K8FfKwjQo7V0Z7uetl4Mr//AyN+jqhSuT94EMAK4xG0r+WbI0
         gsO4NQP5Nw6822hbbdLvJPFpmv1tIPyDRog10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :mime-version:user-agent:x-original-authentication-results
         :x-original-sender:precedence:mailing-list:list-id:list-post
         :list-help:list-archive:x-thread-url:x-message-url:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        b=iq8RPWfDUImTWS9YMtkL/zITssOcJ00uvDeep4eAleJgPruPseld7BGhwYuTurtsM2
         EY3wTPFZ6M7OYaFy7gXSvBMqhtOtKEOYP9WqjyEs55jTFwwKq/WQ+pCyXIw46efI7VbB
         GJvhXs5xn6MysS57FddYx+7srRY5idBHB8fZU=
Received: by 10.91.215.10 with SMTP id s10mr12021agq.24.1266688878779;
        Sat, 20 Feb 2010 10:01:18 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.2.201 with SMTP id 9ls993533bkk.1.p; Sat, 20 Feb 2010 
	10:01:16 -0800 (PST)
Received: by 10.204.13.70 with SMTP id b6mr671511bka.37.1266688876680;
        Sat, 20 Feb 2010 10:01:16 -0800 (PST)
Received: by 10.204.13.70 with SMTP id b6mr671510bka.37.1266688876655;
        Sat, 20 Feb 2010 10:01:16 -0800 (PST)
Received: from darksea.de (darksea.de [83.133.111.250])
        by gmr-mx.google.com with SMTP id 11si184460bwz.6.2010.02.20.10.01.16;
        Sat, 20 Feb 2010 10:01:16 -0800 (PST)
Received-SPF: neutral (google.com: 83.133.111.250 is neither permitted nor denied by best guess record for domain of hvoigt@hvoigt.net) client-ip=83.133.111.250;
Received: (qmail 2820 invoked from network); 20 Feb 2010 19:01:15 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 20 Feb 2010 19:01:15 +0100
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 
	83.133.111.250 is neither permitted nor denied by best guess record for 
	domain of hvoigt@hvoigt.net) smtp.mail=hvoigt@hvoigt.net
X-Original-Sender: hvoigt@hvoigt.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
X-Thread-Url: http://groups.google.com/group/msysgit/t/61aaff59563ed5ea
X-Message-Url: http://groups.google.com/group/msysgit/msg/23485726fdfbd858
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140537>

There was one forgotten global so NS was not visible to the method
which resulted in an error.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 git-gui/lib/status_bar.tcl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-gui/lib/status_bar.tcl b/git-gui/lib/status_bar.tcl
index 5fe3aad..95cb449 100644
--- a/git-gui/lib/status_bar.tcl
+++ b/git-gui/lib/status_bar.tcl
@@ -39,6 +39,7 @@ method _oneline_pack {} {
 }
 
 constructor two_line {path} {
+	global NS
 	set w $path
 	set w_l $w.l
 	set w_c $w.c
-- 
1.7.0.m5.rc2.13.g7abfa.dirty
