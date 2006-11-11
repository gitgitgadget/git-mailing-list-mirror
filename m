X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: StGIT repository not clonable?
Date: Sat, 11 Nov 2006 00:56:47 -0300
Message-ID: <200611110359.kAB3ul02013227@laptop13.inf.utfsm.cl>
NNTP-Posting-Date: Sat, 11 Nov 2006 12:24:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Delayed for 57:57:34 by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Sat, 11 Nov 2006 09:24:08 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31218>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GiruF-0001mA-0O for gcvg-git@gmane.org; Sat, 11 Nov
 2006 13:24:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424572AbWKKMYN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006
 07:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424573AbWKKMYN
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 07:24:13 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:6096 "EHLO
 inti.inf.utfsm.cl") by vger.kernel.org with ESMTP id S1424572AbWKKMYK (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 07:24:10 -0500
Received: from laptop13.inf.utfsm.cl (as5300-s60-113.cnt.entelchile.net
 [164.77.158.123]) by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id
 kABCO7cV001951 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO) for <git@vger.kernel.org>; Sat, 11 Nov 2006 09:24:08 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kAB3ul02013227; Sat, 11
 Nov 2006 00:59:27 -0300
To: catalin.marinas@gmail.com
Sender: git-owner@vger.kernel.org

I'm trying to update my StGIT repo here, and get a crash from
git-http-fetch (git 1.4.3.4). Trying to clone it anew gives:


[vonbrand@laptop13 tmp]$ git-clone http://homepage.ntlworld.com/cmarinas/stgit.git
error: Unable to start request
error: Could not interpret heads/master as something to pull

What am I doing wrong?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
