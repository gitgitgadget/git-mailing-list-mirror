From: Steffen Prohaska <prohaska@zib.de>
Subject: Should we discuss Windows-related changes on
 git@vger.kernel.org?
Date: Fri, 11 Jul 2008 10:07:28 +0200
Message-ID: <DDFD7E3B-8401-4EA0-9BBA-C9D8E25998A3@zib.de>
Reply-To: prohaska@zib.de
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>, Git Mailing List <git@vger.kernel.org>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <johannes.sixt@telecom.at>, Junio C Hamano <gitster@pobox.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Fri Jul 11 10:08:28 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.26])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHDfm-0007Rt-GD
	for gcvm-msysgit@m.gmane.org; Fri, 11 Jul 2008 10:08:10 +0200
Received: by yw-out-2122.google.com with SMTP id 8so3481280yws.63
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2008 01:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:message-id:from:to:content-type:content-transfer-encoding
         :subject:mime-version:date:cc:x-mailer:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        bh=md16Q8aUi/iakukUSnLL3OzyWl1bBSXe4SQkIOonTIU=;
        b=TQA1Szwbs61mMb0ySsx1jQ1eF+Cci82m/0uYFjiPYhpvM9ZdY/8NV0ylOhvY9o8I6v
         pyDnCcObh1zRWmkGbHnuVhemAkBDHtAqrjODK9+uy5x8WTMd1FtN/ueX1iV6pNOThqKN
         a3jMU9Y7Rr9tSx0BV58JQ8TTbBgUhXHSGRvtM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :message-id:from:to:content-type:content-transfer-encoding:subject
         :mime-version:date:cc:x-mailer:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        b=2PgxalAOzPtrXE1WAhjNr6DrkGXGXJFo9f4qJlYXUZVg6f5bnlX53LbO/cAsFQ8h7Q
         zqXAsyM9lZnd7spWEIthp4Ry0bFY0YJDujVoc5LQVxyWoJJveoXBsqwgHtoawYsBFUhW
         iPg+DJtIEZdze3FNsiqDB9KV1Zk4e/B2HrJjQ=
Received: by 10.150.152.17 with SMTP id z17mr283596ybd.25.1215763630504;
        Fri, 11 Jul 2008 01:07:10 -0700 (PDT)
Received: by 10.107.113.4 with SMTP id q4gr2670prm.0;
	Fri, 11 Jul 2008 01:07:10 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.94.2 with SMTP id r2mr12075713agb.13.1215763629760; Fri, 11 Jul 2008 01:07:09 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 39si326326yxd.0.2008.07.11.01.07.08; Fri, 11 Jul 2008 01:07:09 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6B872GG018637; Fri, 11 Jul 2008 10:07:07 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db9309a.pool.einsundeins.de [77.185.48.154]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6B871GB010951 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Fri, 11 Jul 2008 10:07:01 +0200 (MEST)
X-Mailer: Apple Mail (2.926)
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88095>


I decided to stop queuing changes in 4msysgit.  Instead I'd like to
bring the diff between Junio's and 4msysgit's master to zero.  This
seems to be achievable after Junio merged Hannes' MinGW changes.

I think all Windows-related changes to the git code base could be
discussed directly on the main git list and the msysgit list would be
reserved for the MinGW/MSYS runtime environment and the installer.  I do
not expect that Windows-related changes would add too much traffic to
the list.  But, even though we have mechanisms to separate the
platform-specific code from the main code base (like git-compat-util.h),
the Windows-related changes eventually need to be integrated with the
mainline, so it might make sense to discuss them on the main list right
away.

What do you think?

         Steffen
