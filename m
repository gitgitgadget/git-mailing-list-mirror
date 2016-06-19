Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7B4120189
	for <e@80x24.org>; Sun, 19 Jun 2016 13:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbcFSNHv (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 09:07:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44240 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750768AbcFSNHu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 09:07:50 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5JD4RSL068417
	for <git@vger.kernel.org>; Sun, 19 Jun 2016 09:07:49 -0400
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
	by mx0b-001b2d01.pphosted.com with ESMTP id 23mywusu1f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sun, 19 Jun 2016 09:07:49 -0400
Received: from localhost
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <git@vger.kernel.org> from <VADIME@il.ibm.com>;
	Sun, 19 Jun 2016 14:07:47 +0100
Received: from d06dlp01.portsmouth.uk.ibm.com (9.149.20.13)
	by e06smtp17.uk.ibm.com (192.168.101.147) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	Sun, 19 Jun 2016 14:07:46 +0100
X-IBM-Helo: d06dlp01.portsmouth.uk.ibm.com
X-IBM-MailFrom:	VADIME@il.ibm.com
X-IBM-RcptTo: git@vger.kernel.org
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1024317D8042
	for <git@vger.kernel.org>; Sun, 19 Jun 2016 14:09:01 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com [9.149.37.229])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u5JD7jGh7143848
	for <git@vger.kernel.org>; Sun, 19 Jun 2016 13:07:45 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u5JD7j69008578
	for <git@vger.kernel.org>; Sun, 19 Jun 2016 07:07:45 -0600
Received: from d50lp03.ny.us.ibm.com (d50lp03.pok.ibm.com [146.89.104.211])
	by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u5JD7i4f008555
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Sun, 19 Jun 2016 07:07:45 -0600
Received: from localhost
	by d50lp03.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <git@vger.kernel.org> from <VADIME@il.ibm.com>;
	Sun, 19 Jun 2016 09:07:44 -0400
Received: from smtp.notes.na.collabserv.com (192.155.248.73)
	by d50lp03.ny.us.ibm.com (158.87.18.22) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128/128)
	Sun, 19 Jun 2016 09:07:42 -0400
X-IBM-Helo: smtp.notes.na.collabserv.com
X-IBM-MailFrom:	VADIME@il.ibm.com
X-IBM-RcptTo: git@vger.kernel.org
Received: from localhost
	by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
	for <git@vger.kernel.org> from <VADIME@il.ibm.com>;
	Sun, 19 Jun 2016 13:07:40 -0000
Received: from us1a3-smtp05.a3.dal06.isc4sb.com (10.146.71.159)
	by smtp.notes.na.collabserv.com (10.106.227.90) with smtp.notes.na.collabserv.com ESMTP;
	Sun, 19 Jun 2016 13:07:39 -0000
X-IBM-Helo: us1a3-smtp05.a3.dal06.isc4sb.com
X-IBM-MailFrom:	VADIME@il.ibm.com
X-IBM-RcptTo: peff@peff.net;sbeller@google.com;git@vger.kernel.org
Received: from us1a3-mail106.a3.dal06.isc4sb.com ([10.146.45.214])
          by us1a3-smtp05.a3.dal06.isc4sb.com
          with ESMTP id 2016061913073849-60827 ;
          Sun, 19 Jun 2016 13:07:38 +0000 
In-Reply-To: <20160619100051.GA14584@sigill.intra.peff.net>
To:	Jeff King <peff@peff.net>
Cc:	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [BUG REPORT] git 2.9.0 clone --recursive fails on cloning a submodule
From:	"Vadim Eisenberg" <VADIME@il.ibm.com>
Date:	Sun, 19 Jun 2016 16:07:41 +0300
References: <OFC76C15DC.FC882C57-ONC2257FD7.00261552-C2257FD7.002660FC@LocalDomain>
 <OFE09D48F2.D1D14F49-ONC2257FD7.00280736-C2257FD7.0028245A@notes.na.collabserv.com>
 <20160619100051.GA14584@sigill.intra.peff.net>
MIME-Version: 1.0
X-KeepSent: C46A8782:5F47CDBA-C2257FD7:00475209;
 type=4; name=$KeepSent
X-Mailer: IBM Notes Release 9.0.1EXT September 15, 2015
X-LLNOutbound: False
X-Disclaimed: 26011
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="US-ASCII"
x-cbid:	16061913-0004-0000-0000-000003355B8B
X-IBM-ISS-SpamDetectors: Score=0.49; BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.49; ST=0; TS=0; UL=0; ISC=
X-IBM-ISS-DetailInfo: BY=3.00005404; HX=3.00000240; KW=3.00000007;
 PH=3.00000004; SC=3.00000170; SDB=6.00718493; UDB=6.00335096; UTC=2016-06-19
 13:07:40
x-cbparentid: 16061913-0132-0000-0000-000000188524
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
Message-Id: <OFC46A8782.5F47CDBA-ONC2257FD7.00475209-C2257FD7.00483117@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2016-06-19_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1604210000
 definitions=main-1606190151
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The problem is with other tools that use git, like Swift Package Manager - 
https://swift.org/package-manager/.
Versions of git before 2.9.0 have no option --no-shallow-submodules. So 
the tools that use git would have to check if the version of git is 
greater than or equal 2.9.0 to know to specify that option.

Best Regards,
Vadim

Jeff King <peff@peff.net> wrote on 06/19/2016 01:00:51 PM:

> From: Jeff King <peff@peff.net>
> To: Vadim Eisenberg/Haifa/IBM@IBMIL
> Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
> Date: 06/19/2016 01:01 PM
> Subject: Re: [BUG REPORT] git 2.9.0 clone --recursive fails on 
> cloning a submodule
> 
> On Sun, Jun 19, 2016 at 10:17:36AM +0300, Vadim Eisenberg wrote:
> 
> > /usr/local/bin/git clone --recursive --depth 10 
> > https://github.com/IBM-Swift/Kitura-net.git
> > Cloning into 'Kitura-net'...
> > remote: Counting objects: 253, done.
> > remote: Compressing objects: 100% (142/142), done.
> > remote: Total 253 (delta 134), reused 188 (delta 86), pack-reused 0
> > Receiving objects: 100% (253/253), 63.28 KiB | 0 bytes/s, done.
> > Resolving deltas: 100% (134/134), done.
> > Checking connectivity... done.
> > Submodule 'Kitura-Build' (
https://github.com/IBM-Swift/Kitura-Build.git) 
> > registered for path 'Kitura-Build'
> > Cloning into '/home/vadime/Kitura-net/Kitura-Build'...
> > error: no such remote ref d0d9d6c739a79627641e6438fe4f39bd0eba83bb
> > Fetched in submodule path 'Kitura-Build', but it did not contain 
> > d0d9d6c739a79627641e6438fe4f39bd0eba83bb. Direct fetching of that 
commit 
> > failed.
> 
> The problem seems to be the shallow clone. The super-project points to a
> commit in the submodule that is not near the tip of any branch, so
> shallow-cloning the submodule means we don't get that commit. Prior to
> d22eb04 (clone: add `--shallow-submodules` flag, 2016-04-25), submodules
> were _always_ cloned fully.
> 
> The immediate workaround is to add "--no-shallow-submodules" to your
> clone invocation.
> 
> Stefan, I think it might be worth revisiting the default set by d22eb04
> to propagate shallowness from the super-project clone. In an ideal
> world, we would be asking each submodule for the actual commit we are
> interested in, and shallowness would not matter. But until
> uploadpack.allowReachableSHA1InWant works everywhere, I suspect this is
> going to be a problem.
> 
> -Peff
> 


