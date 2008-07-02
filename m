From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: How to reduce remaining differences to 4msysgit? (was
 What's cooking in git.git (topics))
Date: Wed, 2 Jul 2008 10:31:31 +0200
Message-ID: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <7v3amv1e8n.fsf@gitster.siamese.dyndns.org> <4CE52307-A2DE-488B-998B-76D60B66E804@zib.de> <200806302047.56935.johannes.sixt@telecom.at>
Reply-To: prohaska@zib.de
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>, Junio C Hamano <gitster@pobox.com>, Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Jul 02 10:32:29 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.27])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDxlC-0000sP-29
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2008 10:32:18 +0200
Received: by yw-out-2122.google.com with SMTP id 8so2057429yws.63
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 01:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:in-reply-to:subject:references:message-id
         :content-type:content-transfer-encoding:mime-version:date:cc
         :x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=nUdSPFI4tqBz48p1u1t4Xnvu3ZTOjXiil98ytjv7vhY=;
        b=Ao8nIFfdQWh3euy6u027PwkLQZehzTn2g/rVFzjNHijXgxzEMBa0hIz6RlK+9uhsNz
         X47GPrTbnXRjdStqk2szyu2bn0pySzp8ndIgNqVMLoDkcoDbYGJG4rKorBhK112BmdB8
         dHUb6gSOI456Ia04aFJFEUIUuzKNi1TTRSZmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mailer:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere;
        b=eo31WQashQMHVy4DZGJZFAthh6d6UI7diJPu2iVP7sRxZMDP5rhJhbvZPZbydFde/x
         45ivKrImUviVoLF68/D+njq2eoiHf8ybttaUA6hPVAcuFlXvuBSAyVnc/EKIIeirKJ/0
         tVT7lOzPmUo2Bjrdvr1gNPhJfgPJzTVWTHUbY=
Received: by 10.141.4.3 with SMTP id g3mr483333rvi.29.1214987478529;
        Wed, 02 Jul 2008 01:31:18 -0700 (PDT)
Received: by 10.106.193.17 with SMTP id q17gr2543prf.0;
	Wed, 02 Jul 2008 01:31:18 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.70.15 with SMTP id s15mr83090aga.27.1214987477963; Wed, 02 Jul 2008 01:31:17 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 7si7856040yxg.1.2008.07.02.01.31.17; Wed, 02 Jul 2008 01:31:17 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m628V9Uj019025; Wed, 2 Jul 2008 10:31:14 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db94382.pool.einsundeins.de [77.185.67.130]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m628V6lv017294 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Wed, 2 Jul 2008 10:31:08 +0200 (MEST)
In-Reply-To: <200806302047.56935.johannes.sixt@telecom.at>
X-Mailer: Apple Mail (2.924)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87101>



On Jun 30, 2008, at 8:47 PM, Johannes Sixt wrote:

> Then there are the extra patches in 4msysgit. From my POV, they are  
> not
> _required_ because I can appearently work with git on Windows  
> without them. I
> think some of them are not necessary. Can we go through them again?


I'll send a patch series in reply to this mail that contains the
following patches:

  [PATCH 01/12] Fake reencoding success under NO_ICONV instead of  
returning NULL.
  [PATCH 02/12] Do not complain about "no common commits" in an empty  
repo
  [PATCH 03/12] MinGW: Convert CR/LF to LF in tag signatures
  [PATCH 04/12] Avoid calling signal(SIGPIPE, ..) for MinGW builds.
  [PATCH 05/12] Windows(msysgit): Per default, display help as HTML in  
default browser
  [PATCH 06/12] connect: Fix custom ports with plink (Putty's ssh)
  [PATCH 07/12] Fixed text file auto-detection: treat EOF character  
032 at the end of file as printable
  [PATCH 08/12] fast-import: MinGW does not have getppid().  So do not  
print it.
  [PATCH 09/12] We need to check for msys as well as Windows in add-- 
interactive.
  [PATCH 10/12] Add ANSI control code emulation for the Windows console
  [PATCH 11/12] verify_path(): do not allow absolute paths
  [PATCH 12/12] [TODO] setup: bring changes from 4msysgit/next to next

This series would bring *.{c,h,sh,perl} on Junio's next to 4msysgit/ 
next,
except for some minor differences (whitespace, comments, a workaround in
git-parse-remote.sh).

	Steffen
