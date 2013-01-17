From: Matt Seitz <mseitz@mhseitz.onmicrosoft.com>
Subject: Re: Question re. git remote repository
Date: Thu, 17 Jan 2013 05:20:07 +0000
Message-ID: <1BBEF94B6B46E54980290D150A6F2EDD46B718CB@BLUPRD0612MB625.namprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "david@lang.hm" <david@lang.hm>,
	"'matseitz@cisco.com'" <matseitz@cisco.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 06:21:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvhuO-000872-F1
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 06:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284Ab3AQFUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 00:20:39 -0500
Received: from co9ehsobe004.messaging.microsoft.com ([207.46.163.27]:32825
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752238Ab3AQFUi convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 00:20:38 -0500
Received: from mail159-co9-R.bigfish.com (10.236.132.244) by
 CO9EHSOBE006.bigfish.com (10.236.130.69) with Microsoft SMTP Server id
 14.1.225.23; Thu, 17 Jan 2013 05:20:37 +0000
Received: from mail159-co9 (localhost [127.0.0.1])	by
 mail159-co9-R.bigfish.com (Postfix) with ESMTP id 59BB1401F5;	Thu, 17 Jan
 2013 05:20:37 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:132.245.1.181;KIP:(null);UIP:(null);IPV:NLI;H:BLUPRD0612HT001.namprd06.prod.outlook.com;RD:none;EFVD:NLI
X-SpamScore: 5
X-BigFish: VS5(zz98dI1432Izz1ee6h1de0h1202h1e76h1d1ah1d2ah1957ozzz31h87h2a8h668h839h944hd25h1220h1288h12a5h12a9h12bdh137ah13b6h13eah1441h1504h1537h153bh15d0h162dh1631h1758h1155h)
Received-SPF: softfail (mail159-co9: transitioning domain of mhseitz.onmicrosoft.com does not designate 132.245.1.181 as permitted sender) client-ip=132.245.1.181; envelope-from=mseitz@mhseitz.onmicrosoft.com; helo=BLUPRD0612HT001.namprd06.prod.outlook.com ;.outlook.com ;
X-FB-DOMAIN-IP-MATCH: fail
Received: from mail159-co9 (localhost.localdomain [127.0.0.1]) by mail159-co9
 (MessageSwitch) id 1358400034481644_14713; Thu, 17 Jan 2013 05:20:34 +0000
 (UTC)
Received: from CO9EHSMHS029.bigfish.com (unknown [10.236.132.246])	by
 mail159-co9.bigfish.com (Postfix) with ESMTP id 733782005F;	Thu, 17 Jan 2013
 05:20:34 +0000 (UTC)
Received: from BLUPRD0612HT001.namprd06.prod.outlook.com (132.245.1.181) by
 CO9EHSMHS029.bigfish.com (10.236.130.39) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Thu, 17 Jan 2013 05:20:32 +0000
Received: from BLUPRD0612MB625.namprd06.prod.outlook.com ([169.254.1.12]) by
 BLUPRD0612HT001.namprd06.prod.outlook.com ([10.255.217.162]) with mapi id
 14.16.0257.004; Thu, 17 Jan 2013 05:20:23 +0000
Thread-Topic: Question re. git remote repository
Thread-Index: Ac30clBfiS9Wz5z5QQCdt+r50PLYHg==
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213842>

"David Lang" <david@lang.hm> wrote in message news:<alpine.DEB.2.02.1301161843390.21503@nftneq.ynat.uz>...
> >>
> >> On Thu, 17 Jan 2013, Matt Seitz (matseitz) wrote:
> >>
> >>> 2. a repository where only one user does "git add" and "git commit",
> >> while other users will do "git pull", the peer-to-peer model (you pull changes
> >> from me, I pull changes from you).
> >>
> 
> you may _be_ safe, and if others who really know the internals speak up, take 
> their word on it. 

Well, we already have Linus's article.  I guess the question is whether the use case I describe above falls under:

A. "maintenance operations"

B. "normal git workflow"

Personally, I would consider this use case to be a "normal git workflow".
