From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 0/2] Make t9200-git-cvsexportcommit.sh pass on MSYS
Date: Wed, 11 Jan 2012 10:16:23 +0100
Message-ID: <4F0D5367.1000506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: msysgit+bncCPLFkNe0FhD1prX4BBoExLBcmQ@googlegroups.com Wed Jan 11 10:17:09 2012
Return-path: <msysgit+bncCPLFkNe0FhD1prX4BBoExLBcmQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-bk0-f58.google.com ([209.85.214.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCPLFkNe0FhD1prX4BBoExLBcmQ@googlegroups.com>)
	id 1RkuIu-0004Hc-Ek
	for gcvm-msysgit@m.gmane.org; Wed, 11 Jan 2012 10:17:08 +0100
Received: by bkwq16 with SMTP id q16sf377116bkw.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 11 Jan 2012 01:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:x-injected-via-gmane:to:from:subject:date
         :lines:message-id:mime-version:x-complaints-to
         :x-gmane-nntp-posting-host:user-agent:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=nSdNQix6RV8PRqyKUDf7Xv2j1dhlhyowpCtWK0Dh/UA=;
        b=LLIHMXT4ziarsSwqYj63lTVUQTxTIwpaKgIzbu7S5n+CECI5zkCGaQglJtiW78SgeJ
         Wt1QzPiWbejJ9Nft0z5VWkN+7SzTW+wE6k6oEfmkQxjwNbf0q29TZuxjsaOMBvHZ1FzA
         wsz9L/4Uv/DJpJpdpwfcYg6nBYeMkePhlOu1Y=
Received: by 10.204.154.141 with SMTP id o13mr1259323bkw.33.1326273397958;
        Wed, 11 Jan 2012 01:16:37 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.39.200 with SMTP id h8ls520873bke.3.gmail; Wed, 11 Jan
 2012 01:16:36 -0800 (PST)
Received: by 10.205.139.10 with SMTP id iu10mr1507474bkc.4.1326273396651;
        Wed, 11 Jan 2012 01:16:36 -0800 (PST)
Received: by 10.205.139.10 with SMTP id iu10mr1507473bkc.4.1326273396640;
        Wed, 11 Jan 2012 01:16:36 -0800 (PST)
Received: from lo.gmane.org (lo.gmane.org. [80.91.229.12])
        by gmr-mx.google.com with ESMTP id e4si1124470bkv.1.2012.01.11.01.16.36;
        Wed, 11 Jan 2012 01:16:36 -0800 (PST)
Received-SPF: pass (google.com: domain of gcvm-msysgit@m.gmane.org designates 80.91.229.12 as permitted sender) client-ip=80.91.229.12;
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvm-msysgit@m.gmane.org>)
	id 1RkuIN-00041f-MO
	for msysgit@googlegroups.com; Wed, 11 Jan 2012 10:16:35 +0100
Received: from jambul.zib.de ([130.73.68.203])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <msysgit@googlegroups.com>; Wed, 11 Jan 2012 10:16:35 +0100
Received: from sschuberth by jambul.zib.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <msysgit@googlegroups.com>; Wed, 11 Jan 2012 10:16:35 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: jambul.zib.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
X-Original-Sender: sschuberth@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of gcvm-msysgit@m.gmane.org designates 80.91.229.12 as permitted
 sender) smtp.mail=gcvm-msysgit@m.gmane.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188345>

This tiny series makes the long-pending t9200-git-cvsexportcommit.sh pass on MSYS.

Sebastian Schuberth (2):
  t9200: On MSYS, do not pass Windows-style paths to CVS
  git-cvsexportcommit: Fix calling Perl's rel2abs() on MSYS

 git-cvsexportcommit.perl       |    7 +++++++
 t/t9200-git-cvsexportcommit.sh |    6 +++---
 2 files changed, 10 insertions(+), 3 deletions(-)

-- 
1.7.9.rc0.5096.g30a61
