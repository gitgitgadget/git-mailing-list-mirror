From: Matt Seitz <mseitz@mhseitz.onmicrosoft.com>
Subject: RE: Question re. git remote repository
Date: Fri, 18 Jan 2013 05:51:39 +0000
Message-ID: <1BBEF94B6B46E54980290D150A6F2EDD46B7AAE2@BN1PRD0612MB635.namprd06.prod.outlook.com>
References: <201301161749.r0GHnGV6007806@smtpb02.one-mail.on.ca>
 <20130116220615.48c159546bccfa5b9cd9028e@domain007.com>
 <20130116182156.GB4426@sigill.intra.peff.net>
 <20130116233744.7d0775eaec98ce154a9de180@domain007.com>
 <0630A778-9AC8-4023-889C-4FC58ABAB683@gmail.com>
 <alpine.DEB.2.02.1301161459060.21503@nftneq.ynat.uz>,<201301172153.r0HLrU4F019815@smtpb02.one-mail.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Konstantin Khomoutov <kostix+git@007spb.ru>,
	Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Stephen Smith <ishchis2@gmail.com>
To: "Lang, David" <David.Lang@uhn.ca>, David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Fri Jan 18 06:52:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tw4s3-00030x-3z
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 06:52:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092Ab3ARFvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 00:51:45 -0500
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:55024
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751053Ab3ARFvo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 00:51:44 -0500
Received: from mail172-va3-R.bigfish.com (10.7.14.239) by
 VA3EHSOBE006.bigfish.com (10.7.40.26) with Microsoft SMTP Server id
 14.1.225.23; Fri, 18 Jan 2013 05:51:43 +0000
Received: from mail172-va3 (localhost [127.0.0.1])	by
 mail172-va3-R.bigfish.com (Postfix) with ESMTP id 674E448016F;	Fri, 18 Jan
 2013 05:51:43 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:132.245.2.53;KIP:(null);UIP:(null);IPV:NLI;H:BN1PRD0612HT003.namprd06.prod.outlook.com;RD:none;EFVD:NLI
X-SpamScore: 7
X-BigFish: VS7(zzzz1ee6h1de0h1202h1e76h1d1ah1d2ah1957ozz17326ah19a27bh8275dhz31h87h2a8h668h839h944hd25h1220h1288h12a5h12a9h12bdh137ah13b6h13eah1441h1504h1537h153bh15d0h162dh1631h1758h1155h)
Received-SPF: softfail (mail172-va3: transitioning domain of mhseitz.onmicrosoft.com does not designate 132.245.2.53 as permitted sender) client-ip=132.245.2.53; envelope-from=mseitz@mhseitz.onmicrosoft.com; helo=BN1PRD0612HT003.namprd06.prod.outlook.com ;.outlook.com ;
X-FB-DOMAIN-IP-MATCH: fail
Received: from mail172-va3 (localhost.localdomain [127.0.0.1]) by mail172-va3
 (MessageSwitch) id 135848830166984_11899; Fri, 18 Jan 2013 05:51:41 +0000
 (UTC)
Received: from VA3EHSMHS022.bigfish.com (unknown [10.7.14.243])	by
 mail172-va3.bigfish.com (Postfix) with ESMTP id 0ABB22A0057;	Fri, 18 Jan 2013
 05:51:41 +0000 (UTC)
Received: from BN1PRD0612HT003.namprd06.prod.outlook.com (132.245.2.53) by
 VA3EHSMHS022.bigfish.com (10.7.99.32) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Fri, 18 Jan 2013 05:51:40 +0000
Received: from BN1PRD0612MB635.namprd06.prod.outlook.com ([169.254.8.51]) by
 BN1PRD0612HT003.namprd06.prod.outlook.com ([10.255.195.36]) with mapi id
 14.16.0257.004; Fri, 18 Jan 2013 05:51:40 +0000
Thread-Topic: Question re. git remote repository
Thread-Index: AQHN9BQsiS9Wz5z5QQCdt+r50PLYHphMmGQAgAAVLgCAADhAAIAAAHSAgAEp7QCAAHgWMQ==
In-Reply-To: <201301172153.r0HLrU4F019815@smtpb02.one-mail.on.ca>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213905>

From: git-owner@vger.kernel.org [git-owner@vger.kernel.org] on behalf of Lang, David [David.Lang@uhn.ca]

> I thought the idea was that each developer installed git locally on their machines 

Yes.

> and (as needed) committed their changes to the master repository which resides externally to any of the local machines, such as on a network 
> server 

Yes, but committing their changes to the master repository is a two step process:

1.  Each developer first commits their changes to their personal repository using the "git commit" command.
2.  Each developer pushes their changes from their personal repository to the master repository with the "git push" command

> (and which I'm assuming has git installed locally as well).

Maybe.

If the machine with the master repository has git installed locally, then each developer can push their changes to the master repository using either the git protocol or the ssh protocol.

If the machine with the master repository does not have git installed locally, then each developer can push their changes to the master repository using NFS or CIFS/SMB.  The git documentation refers to this method as the "file protocol".

The other David Lang (david@lang.hm) believes that using "git push" using NFS or CIFS/SMB may not be safe and reliable.  Based on the following article by the creator of git, I believe using "git push" over NFS or CIFS/SMB is safe and reliable:

http://permalink.gmane.org/gmane.comp.version-control.git/122670

The GitFaq wiki also says that using "git push" over NFS or CIFS/SMB is safe and reliable:

https://git.wiki.kernel.org/index.php/GitFaq#What_can_I_use_to_set_up_a_public_repository.3F
