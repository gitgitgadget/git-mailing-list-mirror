From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 0/8] Some patches from msysGit
Date: Fri, 14 Oct 2011 23:53:27 +0100
Message-ID: <1318632815-29945-1-git-send-email-patthoyts@users.sourceforge.net>
Mime-Version: 1.0
Cc: Junio C Hamano <gitster@pobox.com>,
	msysGit <msysgit@googlegroups.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Git <git@vger.kernel.org>
X-From: msysgit+bncCM7pyrzTCBDa--L0BBoEuDg-SA@googlegroups.com Sat Oct 15 00:55:56 2011
Return-path: <msysgit+bncCM7pyrzTCBDa--L0BBoEuDg-SA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ww0-f58.google.com ([74.125.82.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCM7pyrzTCBDa--L0BBoEuDg-SA@googlegroups.com>)
	id 1REqfQ-0001EC-ET
	for gcvm-msysgit@m.gmane.org; Sat, 15 Oct 2011 00:55:52 +0200
Received: by mail-ww0-f58.google.com with SMTP id 25sf318097wwf.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 14 Oct 2011 15:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:x-cloudmark-analysis:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=C2t3BDpiayv1qm5vSIN4h6Sn31bcaDEYZi8eY6nllBE=;
        b=JLny6uwgL2VUDiZBZBQ4p6vVvWbbmxg9oU2jCQ+qHqCC1ZXPrStYpeOOVT88AbLDsS
         ngqk4WpJEGxSdrpKaJESFyrh+gcH8FU05rCzjOGS84adbOwDsrWe3K4n43uVeIe/KT1i
         rYwyMktcfzr4HkerzPI3MpZI+AbjtWC2bwZ6U=
Received: by 10.216.137.25 with SMTP id x25mr1432080wei.20.1318632922958;
        Fri, 14 Oct 2011 15:55:22 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.227.94.67 with SMTP id y3ls4648852wbm.1.gmail; Fri, 14 Oct
 2011 15:55:22 -0700 (PDT)
Received: by 10.216.229.207 with SMTP id h57mr268925weq.3.1318632922099;
        Fri, 14 Oct 2011 15:55:22 -0700 (PDT)
Received: by 10.216.150.224 with SMTP id z74mswej;
        Fri, 14 Oct 2011 15:53:59 -0700 (PDT)
Received: by 10.216.156.135 with SMTP id m7mr47524wek.11.1318632838946;
        Fri, 14 Oct 2011 15:53:58 -0700 (PDT)
Received: by 10.216.156.135 with SMTP id m7mr47523wek.11.1318632838911;
        Fri, 14 Oct 2011 15:53:58 -0700 (PDT)
Received: from mtaout03-winn.ispmail.ntl.com (mtaout03-winn.ispmail.ntl.com. [81.103.221.49])
        by gmr-mx.google.com with ESMTP id es13si5618698wbb.3.2011.10.14.15.53.58;
        Fri, 14 Oct 2011 15:53:58 -0700 (PDT)
Received-SPF: pass (google.com: domain of pat@patthoyts.tk designates 81.103.221.49 as permitted sender) client-ip=81.103.221.49;
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.3])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111014225358.CLVU8898.mtaout03-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Fri, 14 Oct 2011 23:53:58 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <pat@patthoyts.tk>)
	id 1REqda-00086L-4Y; Fri, 14 Oct 2011 23:53:58 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 4B34B20A65; Fri, 14 Oct 2011 23:53:57 +0100 (BST)
X-Mailer: git-send-email 1.7.5
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=FErwVMkzRTcA:10 a=BtgNS5OuHzJ8JZFTX5QA:9 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
X-Original-Sender: patthoyts@users.sourceforge.net
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of pat@patthoyts.tk designates 81.103.221.49 as permitted sender) smtp.mail=pat@patthoyts.tk
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183627>

This series collects some recent patches required for msysGit
applied onto 'next' for upstream application.

Johannes Schindelin (4):
  t1020: disable the pwd test on MinGW
  t1402: Ignore a few cases that must fail due to DOS path expansion
  t9001: do not fail only due to CR/LF issues
  t9300: do not run --cat-blob-fd related tests on MinGW

Pat Thoyts (3):
  t9901: fix line-ending dependency on windows
  mergetools: use the correct tool for Beyond Compare 3 on Windows
  mingw: ensure sockets are initialized before calling gethostname

Sebastian Schuberth (1):
  git-svn: On MSYS, escape and quote SVN_SSH also if set by the user

 compat/mingw.c              |    7 +++++++
 compat/mingw.h              |    3 +++
 git-svn.perl                |   15 +++++++--------
 mergetools/bc3              |    9 ++++++++-
 t/t1020-subdirectory.sh     |    2 +-
 t/t1402-check-ref-format.sh |   15 +++++++++------
 t/t9001-send-email.sh       |    1 +
 t/t9300-fast-import.sh      |    8 ++++----
 t/t9901-git-web--browse.sh  |   10 +++++-----
 9 files changed, 45 insertions(+), 25 deletions(-)

-- 
1.7.7.1.gbba15
