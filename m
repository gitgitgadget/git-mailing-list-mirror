From: "Dodge, Warren L" <warren.l.dodge@tektronix.com>
Subject: RE: Error 128 Clone succeeded, but checkout failed
Date: Thu, 19 Jun 2014 00:37:39 +0000
Message-ID: <C8DDA0C887F79C468978FDEF2DA46F9F0145B48B@US-BV-EXM01-P.global.tektronix.net>
References: <05c29ee7-8629-424e-b2db-de49db976e55@US-BV-EXH02-P.global.tektronix.net>
 <20140618235539.GL368384@vauxhall.crustytoothpaste.net>
 <C8DDA0C887F79C468978FDEF2DA46F9F0145B453@US-BV-EXM01-P.global.tektronix.net>
 <20140619002444.GM368384@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Jun 19 02:37:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxQMP-0005dE-6L
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 02:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbaFSAhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 20:37:45 -0400
Received: from co9ehsobe004.messaging.microsoft.com ([207.46.163.27]:14902
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751674AbaFSAho convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 20:37:44 -0400
Received: from mail161-co9-R.bigfish.com (10.236.132.225) by
 CO9EHSOBE040.bigfish.com (10.236.130.103) with Microsoft SMTP Server id
 14.1.225.22; Thu, 19 Jun 2014 00:37:43 +0000
Received: from mail161-co9 (localhost [127.0.0.1])	by
 mail161-co9-R.bigfish.com (Postfix) with ESMTP id 318B61C0513;	Thu, 19 Jun
 2014 00:37:43 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:192.65.42.18;KIP:(null);UIP:(null);IPV:NLI;H:mx.danahertm.com;RD:mx.danahertm.com;EFVD:NLI
X-SpamScore: 1
X-BigFish: VPS1(zz98dI9371I542I1432Izz1f42h1ee6h1de0h1fdah2073h2146h1202h1e76h2189h1d1ah1d2ah21bch1fc6h208chzz8275ch1de098h17326ah8275dh1de097h186068hb412mz31h109h2a8h839h8e3h944hd25hf0ah1220h1288h12a5h12a9h12bdh137ah13b6h1441h1504h1537h153bh15d0h162dh1631h1758h18e1h1946h19b5h19ceh1b0ah224fh1d0ch1d2eh1d3fh1dfeh1dffh1e1dh1fe8h1ff5h2216h22d0h2336h2438h2461h2487h24ach24d7h2516h2545h255eh25f6h2605h262fh268bh26d3h27e2h293fh)
Received-SPF: softfail (mail161-co9: transitioning domain of tektronix.com does not designate 192.65.42.18 as permitted sender) client-ip=192.65.42.18; envelope-from=warren.l.dodge@tektronix.com; helo=mx.danahertm.com ;anahertm.com ;
Received: from mail161-co9 (localhost.localdomain [127.0.0.1]) by mail161-co9
 (MessageSwitch) id 1403138261590670_26171; Thu, 19 Jun 2014 00:37:41 +0000
 (UTC)
Received: from CO9EHSMHS021.bigfish.com (unknown [10.236.132.239])	by
 mail161-co9.bigfish.com (Postfix) with ESMTP id 82920300051;	Thu, 19 Jun 2014
 00:37:41 +0000 (UTC)
Received: from mx.danahertm.com (192.65.42.18) by CO9EHSMHS021.bigfish.com
 (10.236.130.31) with Microsoft SMTP Server (TLS) id 14.16.227.3; Thu, 19 Jun
 2014 00:37:41 +0000
Received: from US-BV-EXH02-P.global.tektronix.net (128.181.11.23) by
 US-BV-EXE01-P.global.tektronix.net (128.181.15.45) with Microsoft SMTP Server
 (TLS) id 14.3.146.0; Wed, 18 Jun 2014 17:37:32 -0700
Received: from US-BV-EXM01-P.global.tektronix.net
 ([fe80::9c2d:8d3b:4ab3:6368]) by US-BV-EXH02-P.global.tektronix.net
 ([fe80::91f:91a6:a0ad:f15e%12]) with mapi id 14.03.0169.001; Wed, 18 Jun 2014
 17:37:40 -0700
Thread-Topic: Error 128 Clone succeeded, but checkout failed
Thread-Index: AQHPi0mL4z5ljgpKYkq1skZfmWGJ5Jt4AGKA//+LKmCAAHz2AP//jJUw
In-Reply-To: <20140619002444.GM368384@vauxhall.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.62.182.71]
X-OriginatorOrg: tektronix.com
X-FOPE-CONNECTOR: Id%0$Dn%*$RO%0$TLS%0$FQDN%$TlsDn%
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252084>

Here is the fsck which is ok. Remember that if I do the clone to another file server it works fine.

"c:\Program Files (x86)\Git\bin\git.exe"  fsck --full
Checking object directories: 100% (256/256), done.
Checking objects: 100% (774/774), done.
Checking connectivity: 5128, done.

One thing I notice now, is that the object key is different on each run of the clone. 
81f1bb353f860726835c6d265b3433a72c3fc082 vs a7b8f40dcafba3ec534db6d11e4b928775f26bcd and others we did yesterday.


Also if we do the suggested command 'git checkout -f HEAD' it works fine.


-----Original Message-----
From: brian m. carlson [mailto:sandals@crustytoothpaste.net] 
Sent: Wednesday, June 18, 2014 5:25 PM
To: Dodge, Warren L
Cc: git@vger.kernel.org
Subject: Re: Error 128 Clone succeeded, but checkout failed

On Thu, Jun 19, 2014 at 12:11:43AM +0000, Dodge, Warren L wrote:
> Hi Brian

Hi.  Please do keep the list in CC.  Someone else may be able to help you better than I.

> c:\Program Files (x86)\Git\bin\git.exe" --version git version 
> 1.9.4.msysgit.0
> 
> I also had 1.8.?? and it did the same thing so I updated to try that.
> 
> This is exact.
> "c:\Program Files (x86)\Git\bin\git.exe"  clone --progress -v 
> VHDR_GIT_REPOSITORY fail Cloning into 'fail'...
> done.
> fatal: unable to read tree a7b8f40dcafba3ec534db6d11e4b928775f26bcd

This means that git is unable to read this object.  It could be missing or corrupt.

What do you get if you try to run git fsck --full on this newly cloned repository?  I realize it won't have a working directory, but git fsck should still run.

> warning: Clone succeeded, but checkout failed.
> You can inspect what was checked out with 'git status'
> and retry the checkout with 'git checkout -f HEAD'
> 
> I didn't get the status code but is was 128 when I did this in bash
> 
> Our file servers are many terabytes and use DFS to break them up into 
> the file systems that are used.

>From what I can tell of DFS from Wikipedia, it's using SMB under the hood, and I'm not sure how well git works over SMB.  Maybe some of the msysgit folks can chime in here?

--
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187
