From: "Blum, Robert" <rblum@pandemicstudios.com>
Subject: RE: Git vs Monotone
Date: Thu, 31 Jul 2008 13:42:08 -0700
Message-ID: <8778C923356C6541B263428246AE9C2A4FE2966B09@NA-MAIL-2-2.rws.ad.ea.com>
References: <alpine.LFD.1.10.0807311244240.3277@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 31 22:43:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOezS-0003Ww-3r
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 22:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753073AbYGaUmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 16:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753691AbYGaUmN
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 16:42:13 -0400
Received: from smtp-na3.ea.com ([159.153.6.7]:35124 "EHLO smtp-na3.ea.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752899AbYGaUmN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2008 16:42:13 -0400
Received: from EAHQ-BH4.rws.ad.ea.com (eahq-bh4.rws.ad.ea.com [10.30.204.13])
	by smtp-na3.ea.com (Switch-3.3.0/Switch-3.3.0) with ESMTP id m6VKg9TV028025;
	Thu, 31 Jul 2008 13:42:09 -0700
Received: from na-casht3.rws.ad.ea.com ([10.30.128.50]) by EAHQ-BH4.rws.ad.ea.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 31 Jul 2008 13:42:09 -0700
Received: from NA-MAIL-2-2.rws.ad.ea.com ([10.30.204.156]) by
 na-casht3.rws.ad.ea.com ([192.168.37.21]) with mapi; Thu, 31 Jul 2008
 13:42:09 -0700
Thread-Topic: Git vs Monotone
Thread-Index: AcjzR7iw1rqNJccKRu62N8oUBw5P4gABEhzw
In-Reply-To: <alpine.LFD.1.10.0807311244240.3277@nehalem.linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-OriginalArrivalTime: 31 Jul 2008 20:42:09.0190 (UTC) FILETIME=[E6E5A460:01C8F34D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90985>


>The fact is, even without "-s", a local clone will do hardlinks for the
>database. And since the original pack-file is marked as a 'keep' file,
>that original pack-file won't even be broken apart.

Then again, Pidgin is, among other things, a Windows project. I.e. hardlinks are not exactly trivial. There's a good chance nobody jumped through the hoops of junction points for git on win32... (Somebody correct me if I'm wrong)

>So literally, if he had just bothered to even _try_ the git setup, he'd
>have noticed that git actually uses less disk than monotone would do. But
>it sounds like he didn't even try it.

Well, he *did* try it, for *one* repository. He just didn't know that there's a better way than having 11 clones. And I lay the blame for that squarely at the git documentation ;)

Yes, I know, why don't I make it better...?

Because I'm fairly new to git and would feel like an idiot 'documenting' something that I feel I've only scratched the surface of. I do expect to write a few uninformed rants on my blog, though. And maybe at some point, I can contribute to actual docs :)

Either way, it's another interesting data point for all of us still comparing DVCSs. I just wish he had comments on his blog so somebody could inform him that he's mistaken...


 - Robert
