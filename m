Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DCC21FF40
	for <e@80x24.org>; Mon, 20 Jun 2016 03:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356AbcFTDQY (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 23:16:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6950 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751862AbcFTDQW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 23:16:22 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5K3Dket007987
	for <git@vger.kernel.org>; Sun, 19 Jun 2016 23:16:21 -0400
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23n2eyq8kt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sun, 19 Jun 2016 23:16:21 -0400
Received: from localhost
	by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <git@vger.kernel.org> from <vadime@il.ibm.com>;
	Mon, 20 Jun 2016 04:16:19 +0100
Received: from d06dlp02.portsmouth.uk.ibm.com (9.149.20.14)
	by e06smtp06.uk.ibm.com (192.168.101.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	Mon, 20 Jun 2016 04:16:17 +0100
X-IBM-Helo: d06dlp02.portsmouth.uk.ibm.com
X-IBM-MailFrom:	vadime@il.ibm.com
X-IBM-RcptTo: git@vger.kernel.org
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id BA7762190046
	for <git@vger.kernel.org>; Mon, 20 Jun 2016 04:15:47 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com [9.149.37.250])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u5K3GGrS64094298
	for <git@vger.kernel.org>; Mon, 20 Jun 2016 03:16:16 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u5K3GFsO029437
	for <git@vger.kernel.org>; Sun, 19 Jun 2016 21:16:16 -0600
Received: from e39.co.us.ibm.com (e39.boulder.ibm.com [9.17.249.49])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u5K31DWW015829
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Sun, 19 Jun 2016 21:01:14 -0600
Received: from localhost
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <git@vger.kernel.org> from <vadime@il.ibm.com>;
	Sun, 19 Jun 2016 21:01:13 -0600
Received: from smtp.notes.na.collabserv.com (192.155.248.66)
	by e39.co.us.ibm.com (192.168.2.139) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256/256)
	Sun, 19 Jun 2016 21:01:11 -0600
X-IBM-Helo: smtp.notes.na.collabserv.com
X-IBM-MailFrom:	vadime@il.ibm.com
X-IBM-RcptTo: git@vger.kernel.org
Received: from /spool/local
	by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
	for <git@vger.kernel.org> from <vadime@il.ibm.com>;
	Mon, 20 Jun 2016 03:01:10 -0000
Received: from us1a3-smtp05.a3.dal06.isc4sb.com (10.146.71.159)
	by smtp.notes.na.collabserv.com (10.106.227.127) with smtp.notes.na.collabserv.com ESMTP;
	Mon, 20 Jun 2016 03:01:09 -0000
Received: from us1a3-mail110.a3.dal06.isc4sb.com ([10.146.45.26])
          by us1a3-smtp05.a3.dal06.isc4sb.com
          with ESMTP id 2016062003010881-163888 ;
          Mon, 20 Jun 2016 03:01:08 +0000 
In-Reply-To: <CAGZ79kZ9NF57EyEZ4PgOhJw50ujt=QmHs+w1ZNFeDO4zitksVQ@mail.gmail.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [BUG REPORT] git 2.9.0 clone --recursive fails on cloning a submodule
From:	"Vadim Eisenberg" <VADIME@il.ibm.com>
Date:	Mon, 20 Jun 2016 06:01:08 +0300
References: <OFC76C15DC.FC882C57-ONC2257FD7.00261552-C2257FD7.002660FC@LocalDomain>
 <OFE09D48F2.D1D14F49-ONC2257FD7.00280736-C2257FD7.0028245A@notes.na.collabserv.com>
 <20160619100051.GA14584@sigill.intra.peff.net>
 <xmqq7fdkx5oz.fsf@gitster.mtv.corp.google.com>
 <20160620001332.GA10101@sigill.intra.peff.net>
 <CAGZ79kZ9NF57EyEZ4PgOhJw50ujt=QmHs+w1ZNFeDO4zitksVQ@mail.gmail.com>
MIME-Version: 1.0
X-KeepSent: A474D4C5:A6C331B9-C2257FD8:00104FEB;
 type=4; name=$KeepSent
X-Mailer: IBM Notes Release 9.0.1EXT September 15, 2015
X-LLNOutbound: False
X-Disclaimed: 23307
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="US-ASCII"
x-cbid:	16062003-0024-0000-0000-000001E31D80
X-IBM-ISS-SpamDetectors: Score=0.49; BY=0.068986; FL=0; FP=0; FZ=0; HX=0;
 KW=0; PH=0; SC=0.49; ST=0; TS=0; UL=0; ISC=
X-IBM-ISS-DetailInfo: BY=3.00005407; HX=3.00000240; KW=3.00000007;
 PH=3.00000004; SC=3.00000170; SDB=6.00718765; UDB=6.00335263; UTC=2016-06-20
 03:01:10
x-cbparentid: 16062003-9588-0000-0000-00000434352A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
Message-Id: <OFA474D4C5.A6C331B9-ONC2257FD8.00104FEB-C2257FD8.0010AA61@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2016-06-20_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1604210000
 definitions=main-1606200036
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

> How often do we see a depth != 1 in practice? 

FYI: Here is an example of depth 10 from Swift Package Manager which is 
git-based 
https://github.com/apple/swift-package-manager/blob/61bdff3e9c2b8456be31861b4cda87a31440d517/Sources/Get/Git.swift

try system(Git.tool, "clone",
        "--recursive",   // get submodules too so that developers can use 
these if they so choose
        "--depth", "10",

Stefan Beller <sbeller@google.com> wrote on 06/20/2016 04:09:28 AM:

> From: Stefan Beller <sbeller@google.com>
> To: Jeff King <peff@peff.net>
> Cc: Junio C Hamano <gitster@pobox.com>, Vadim Eisenberg/Haifa/
> IBM@IBMIL, "git@vger.kernel.org" <git@vger.kernel.org>
> Date: 06/20/2016 04:09 AM
> Subject: Re: [BUG REPORT] git 2.9.0 clone --recursive fails on 
> cloning a submodule
> 
> On Sun, Jun 19, 2016 at 5:13 PM, Jeff King <peff@peff.net> wrote:
> > On Sun, Jun 19, 2016 at 01:51:56PM -0700, Junio C Hamano wrote:
> >
> >> Yup, something like this on top of d22eb04 to be merged before
> >> v2.9.1 for the maintenance track would be necessary.
> >>
> >> -- >8 --
> >> Subject: clone: do not let --depth imply --shallow-submodules
> >>
> >> In v2.9.0, we prematurely flipped the default to force cloning
> >> submodules shallowly, when the superproject is getting cloned
> >> shallowly.  This is likely to fail when the upstream repositories
> >> submodules are cloned from a repository that is not prepared to
> >> serve histories that ends at a commit that is not at the tip of a
> >> branch, and we know the world is not yet ready.
> >>
> >> Use a safer default to clone the submodules fully, unless the user
> >> tells us that she knows that the upstream repository of the
> >> submodules are willing to cooperate with "--shallow-submodules"
> >> option.
> >
> > Yeah, this looks good. To minor comments:
> 
> I agree, but I find the second concern a bit more than just minor.
> 
> >
> >> @@ -730,8 +730,7 @@ static int checkout(void)
> >>               struct argv_array args = ARGV_ARRAY_INIT;
> >>               argv_array_pushl(&args, "submodule", "update", "--
> init", "--recursive", NULL);
> >>
> >> -             if (option_shallow_submodules == 1
> >> -                 || (option_shallow_submodules == -1 && 
option_depth))
> >> +             if (option_shallow_submodules == 1)
> >>                       argv_array_push(&args, "--depth=1");
> >
> > I hadn't paid much attention to this topic originally, but was 
surprised
> > that "--depth 10" in the clone implies "--depth 1" in the submodule.
> > This is not really related to your patch (in fact, your patch makes 
the
> > logic go away). But maybe something to consider if it's ever 
resurrected
> > (or possibly if somebody runs "--shallow-submodules --depth 5" we 
should
> > pass --depth=1; I dunno).
> 
> How often do we see a depth != 1 in practice?
> I have the impression (and no data to back up my claim) that a binary
> switch for nonshallow or depth 1 would serve us just as good, which is 
why
> I did not want to ad complexity to the submodule depth.
> (What if you want submodule A with depth 2 and B with 5? In that
> case get them all shallow and deepen as appropriate, would be my answer)
> 
> >
> >> -test_expect_success 'shallow clone implies shallow submodule' '
> >> +test_expect_success 'shallow clone does not imply shallow submodule' 
'
> >>       test_when_finished "rm -rf super_clone" &&
> >> -     git clone --recurse-submodules --depth 2 "file://$pwd/." 
> super_clone &&
> >> +     git clone --recurse-submodules --depth 2 --shallow-submodules "
> file://$pwd/." super_clone &&
> >>       (
> >>               cd super_clone &&
> >>               git log --oneline >lines &&
> >
> > We are not really testing "does not imply" here, but "passing
> > --shallow-submodules works". The "does not imply" test would be 
cloning
> > without the option and checking that the resulting submodules are not
> > shallow.
> 
> In case we want to be sure that it works for 2.9.1, i.e. we treat it
> as a regression,
> we need to test the "does not imply" a bit more I would think. I cansend 
that
> test on top tomorrow if you'd like to.
> 
> Thanks,
> Stefan
> 
> >
> > -Peff
> 


