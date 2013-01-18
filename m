From: Matt Seitz <mseitz@mhseitz.onmicrosoft.com>
Subject: RE: Question re. git remote repository
Date: Fri, 18 Jan 2013 21:56:31 +0000
Message-ID: <1BBEF94B6B46E54980290D150A6F2EDD46B7D7D0@BN1PRD0612MB635.namprd06.prod.outlook.com>
References: <201301161749.r0GHnGV6007806@smtpb02.one-mail.on.ca>
 <20130116220615.48c159546bccfa5b9cd9028e@domain007.com>
 <20130116182156.GB4426@sigill.intra.peff.net>
 <20130116233744.7d0775eaec98ce154a9de180@domain007.com>
 <0630A778-9AC8-4023-889C-4FC58ABAB683@gmail.com>
 <alpine.DEB.2.02.1301161459060.21503@nftneq.ynat.uz>,<201301172153.r0HLrU4F019815@smtpb02.one-mail.on.ca>
 <1BBEF94B6B46E54980290D150A6F2EDD46B7AAE2@BN1PRD0612MB635.namprd06.prod.outlook.com>
 <201301181833.r0IIXNe7021768@smtpb01.one-mail.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Lang, David" <David.Lang@uhn.ca>, David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Fri Jan 18 22:57:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwJw1-0003yI-Dj
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 22:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755112Ab3ARV4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 16:56:51 -0500
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:4962
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751881Ab3ARV4j convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 16:56:39 -0500
Received: from mail192-co1-R.bigfish.com (10.243.78.201) by
 CO1EHSOBE035.bigfish.com (10.243.66.100) with Microsoft SMTP Server id
 14.1.225.23; Fri, 18 Jan 2013 21:56:39 +0000
Received: from mail192-co1 (localhost [127.0.0.1])	by
 mail192-co1-R.bigfish.com (Postfix) with ESMTP id 07279C605FB;	Fri, 18 Jan
 2013 21:56:39 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:132.245.2.53;KIP:(null);UIP:(null);IPV:NLI;H:BN1PRD0612HT002.namprd06.prod.outlook.com;RD:none;EFVD:NLI
X-SpamScore: 5
X-BigFish: VS5(zz542I1432Izz1ee6h1de0h1202h1e76h1d1ah1d2ah1957ozz8275dhz31h87h2a8h668h839h944hd25h1220h1288h12a5h12a9h12bdh137ah13b6h13eah1441h1504h1537h153bh15d0h162dh1631h1758h1155h)
Received-SPF: softfail (mail192-co1: transitioning domain of mhseitz.onmicrosoft.com does not designate 132.245.2.53 as permitted sender) client-ip=132.245.2.53; envelope-from=mseitz@mhseitz.onmicrosoft.com; helo=BN1PRD0612HT002.namprd06.prod.outlook.com ;.outlook.com ;
X-FB-DOMAIN-IP-MATCH: fail
Received: from mail192-co1 (localhost.localdomain [127.0.0.1]) by mail192-co1
 (MessageSwitch) id 1358546196793859_5287; Fri, 18 Jan 2013 21:56:36 +0000
 (UTC)
Received: from CO1EHSMHS002.bigfish.com (unknown [10.243.78.219])	by
 mail192-co1.bigfish.com (Postfix) with ESMTP id BED9DA4006E;	Fri, 18 Jan 2013
 21:56:36 +0000 (UTC)
Received: from BN1PRD0612HT002.namprd06.prod.outlook.com (132.245.2.53) by
 CO1EHSMHS002.bigfish.com (10.243.66.12) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Fri, 18 Jan 2013 21:56:36 +0000
Received: from BN1PRD0612MB635.namprd06.prod.outlook.com ([169.254.8.51]) by
 BN1PRD0612HT002.namprd06.prod.outlook.com ([10.255.195.35]) with mapi id
 14.16.0257.004; Fri, 18 Jan 2013 21:56:31 +0000
Thread-Topic: Question re. git remote repository
Thread-Index: AQHN9BQsiS9Wz5z5QQCdt+r50PLYHphMmGQAgAAVLgCAADhAAIAAAHSAgAEp7QCAAHgWMYAA5CUAgAAsvnA=
In-Reply-To: <201301181833.r0IIXNe7021768@smtpb01.one-mail.on.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [69.228.170.69]
X-OriginatorOrg: mhseitz.onmicrosoft.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213941>



> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> 
> But ultimately, there shouldn't be a question of "if" you
> have a master repository but "where" you have the master repository, correct?
> Or in other words, it doesn't seem like you'd want to designate any one
> developer's local repository as also being the master repository, right? 

You have two options:

1.  Central model:  
a. each developer has their own private repository
b. each developer uses "git commit" to commit changes into their own private repository
c. in addition, you also have a shared master repository
d. each developer uses "git push" to push their changes from their private repository to the shared master repository
e. each developer uses "git pull" to pull other developers' changes from the shared master repository

2.  Peer-to-peer model:
a. each developer has their own private repository
b. each developer uses "git commit" to commit changes into their own private repository
c. each developer uses "git pull" to pull other developers' changes from other developers' private repositories

You can even mix these models.  Say you have a 5 member team, and 2 members are working on a feature together.  The 2 people working on the feature may use "git pull" to pull changes from each other's private repositories.  Then, when the feature is ready, one of them can use "git push" to push the final version from their private repository into the team's shared repository.

What you don't want to do is this:

Single repository, multiple developers:  just one repository, and every developer uses "git commit" to commit their changes into the same repository.

> My sense is that would defeat the purpose of the DVCS.

Not at all.  The purpose of the DVCS is to allow each developer to have their own private repository where they can commit changes, while still allowing people to share changes from one repository to another.  That's true whether you use the central model or the peer-to-peer model.  

The traditional VCS has just one repository, and everyone has to commit their changes into that one central repository.

> We have access to many servers on our
> company's network, some of which we have full rights to, so there's no issue in
> regards to storage space.

That will work fine.

> I suppose another idea would be to have the master
> simply reside on one of the two developers local machines, so one of us would
> have both a local rep and the master rep and the other of us would have just a
> local rep. 

That will also work.  You could even omit the master rep. and just have each developer have a local repository.  Each developer could then commit changes to their own local repository, and pull the other developer's changes from the other developer's local repository (the peer-to-peer model mentioned above).

> Or is it best to
> always have the master hosted on a machine with no other local reps?

There's no requirement to have the master hosted on a machine with no other local reps.  The only issue is that the machine with the master rep. must be turned on for the other developers to push changes from their private repositories to the master repository.  Having the master repository on a 24x7 server ensures it is always available to all developers.  It also gives you another backup copy of your code, in case the developer's machine's storage fails or gets corrupted.
