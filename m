Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BABB1FEAA
	for <e@80x24.org>; Sun, 19 Jun 2016 07:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbcFSHRr (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 03:17:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63335 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751478AbcFSHRq convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 03:17:46 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5J7Dpq5022384
	for <git@vger.kernel.org>; Sun, 19 Jun 2016 03:17:45 -0400
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23n2t90bpb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sun, 19 Jun 2016 03:17:45 -0400
Received: from localhost
	by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <git@vger.kernel.org> from <VADIME@il.ibm.com>;
	Sun, 19 Jun 2016 08:17:42 +0100
Received: from d06dlp03.portsmouth.uk.ibm.com (9.149.20.15)
	by e06smtp16.uk.ibm.com (192.168.101.146) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	Sun, 19 Jun 2016 08:17:41 +0100
X-IBM-Helo: d06dlp03.portsmouth.uk.ibm.com
X-IBM-MailFrom:	VADIME@il.ibm.com
X-IBM-RcptTo: git@vger.kernel.org
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id CCBC91B08069
	for <git@vger.kernel.org>; Sun, 19 Jun 2016 08:18:51 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com [9.149.37.248])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u5J7HfYR23724384
	for <git@vger.kernel.org>; Sun, 19 Jun 2016 07:17:41 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u5J7Hfoa007556
	for <git@vger.kernel.org>; Sun, 19 Jun 2016 03:17:41 -0400
Received: from d50lp32.co.us.ibm.com (d50lp32.boulder.ibm.com [9.17.249.36])
	by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u5J7HdaW007542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Sun, 19 Jun 2016 03:17:41 -0400
Received: from localhost
	by d50lp32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <git@vger.kernel.org> from <VADIME@il.ibm.com>;
	Sun, 19 Jun 2016 01:17:39 -0600
Received: from smtp.notes.na.collabserv.com (192.155.248.74)
	by d50lp32.co.us.ibm.com (192.168.2.143) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128/128)
	Sun, 19 Jun 2016 01:17:37 -0600
X-IBM-Helo: smtp.notes.na.collabserv.com
X-IBM-MailFrom:	VADIME@il.ibm.com
X-IBM-RcptTo: git@vger.kernel.org
Received: from localhost
	by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
	for <git@vger.kernel.org> from <VADIME@il.ibm.com>;
	Sun, 19 Jun 2016 07:17:37 -0000
Received: from us1a3-smtp04.a3.dal06.isc4sb.com (10.106.154.237)
	by smtp.notes.na.collabserv.com (10.106.227.92) with smtp.notes.na.collabserv.com ESMTP;
	Sun, 19 Jun 2016 07:17:35 -0000
X-IBM-Helo: us1a3-smtp04.a3.dal06.isc4sb.com
X-IBM-MailFrom:	VADIME@il.ibm.com
X-IBM-RcptTo: git@vger.kernel.org
Received: from us1a3-mail106.a3.dal06.isc4sb.com ([10.146.45.214])
          by us1a3-smtp04.a3.dal06.isc4sb.com
          with ESMTP id 2016061907173549-21479 ;
          Sun, 19 Jun 2016 07:17:35 +0000 
In-Reply-To: <OFC76C15DC.FC882C57-ONC2257FD7.00261552-C2257FD7.002660FC@LocalDomain>
To:	git@vger.kernel.org
Subject: [BUG REPORT] git 2.9.0 clone --recursive fails on cloning a submodule
From:	"Vadim Eisenberg" <VADIME@il.ibm.com>
Date:	Sun, 19 Jun 2016 10:17:36 +0300
References: <OFC76C15DC.FC882C57-ONC2257FD7.00261552-C2257FD7.002660FC@LocalDomain>
MIME-Version: 1.0
X-KeepSent: E09D48F2:D1D14F49-C2257FD7:00280736;
 type=4; name=$KeepSent
X-Mailer: IBM Notes Release 9.0.1EXT September 15, 2015
X-LLNOutbound: False
X-Disclaimed: 47235
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="US-ASCII"
x-cbid:	16061907-0024-0000-0000-0000021D01FE
X-IBM-ISS-SpamDetectors: Score=0.49; BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.49; ST=0; TS=0; UL=0; ISC=
X-IBM-ISS-DetailInfo: BY=3.00005403; HX=3.00000240; KW=3.00000007;
 PH=3.00000004; SC=3.00000170; SDB=6.00718376; UDB=6.00335028; UTC=2016-06-19
 07:17:36
x-cbparentid: 16061907-2432-0000-0000-000000181D30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
Message-Id: <OFE09D48F2.D1D14F49-ONC2257FD7.00280736-C2257FD7.0028245A@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2016-06-19_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=12
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1604210000
 definitions=main-1606190085
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

/usr/local/bin/git clone --recursive --depth 10 
https://github.com/IBM-Swift/Kitura-net.git
Cloning into 'Kitura-net'...
remote: Counting objects: 253, done.
remote: Compressing objects: 100% (142/142), done.
remote: Total 253 (delta 134), reused 188 (delta 86), pack-reused 0
Receiving objects: 100% (253/253), 63.28 KiB | 0 bytes/s, done.
Resolving deltas: 100% (134/134), done.
Checking connectivity... done.
Submodule 'Kitura-Build' (https://github.com/IBM-Swift/Kitura-Build.git) 
registered for path 'Kitura-Build'
Cloning into '/home/vadime/Kitura-net/Kitura-Build'...
error: no such remote ref d0d9d6c739a79627641e6438fe4f39bd0eba83bb
Fetched in submodule path 'Kitura-Build', but it did not contain 
d0d9d6c739a79627641e6438fe4f39bd0eba83bb. Direct fetching of that commit 
failed.

Linux version:
4.2.0-25-generic #30-Ubuntu SMP Mon Jan 18 12:31:50 UTC 2016 x86_64 x86_64 
x86_64 GNU/Linux



