From: "Brown, Len" <len.brown@intel.com>
Subject: RE: The merge from hell...
Date: Thu, 2 Feb 2006 23:20:54 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005EFE7FF@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Paul Mackerras" <paulus@samba.org>,
	"Marco Costalba" <mcostalba@yahoo.it>,
	"Aneesh Kumar" <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 05:21:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4sRw-0004b6-W5
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 05:21:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWBCEVP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 23:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbWBCEVP
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 23:21:15 -0500
Received: from fmr20.intel.com ([134.134.136.19]:31697 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750935AbWBCEVN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2006 23:21:13 -0500
Received: from orsfmr100.jf.intel.com (orsfmr100.jf.intel.com [10.7.209.16])
	by orsfmr005.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k134KwIN013104;
	Fri, 3 Feb 2006 04:20:58 GMT
Received: from fmsmsxvs042.fm.intel.com (fmsmsxvs042.fm.intel.com [132.233.42.128])
	by orsfmr100.jf.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id k134KqWm027246;
	Fri, 3 Feb 2006 04:20:57 GMT
Received: from fmsmsx332.amr.corp.intel.com ([132.233.42.148])
 by fmsmsxvs042.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2006020220205706906
 ; Thu, 02 Feb 2006 20:20:57 -0800
Received: from fmsmsx312.amr.corp.intel.com ([132.233.42.227]) by fmsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 2 Feb 2006 20:20:57 -0800
Received: from hdsmsx401.amr.corp.intel.com ([10.127.2.60]) by fmsmsx312.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 2 Feb 2006 20:20:57 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: The merge from hell...
Thread-Index: AcYnzdgybAKvBtVPR0KD8CPaqf9V9AAqD4UQ
To: "Linus Torvalds" <torvalds@osdl.org>,
	"Junio C Hamano" <junkio@cox.net>
X-OriginalArrivalTime: 03 Feb 2006 04:20:57.0149 (UTC) FILETIME=[3AEE56D0:01C62879]
X-Scanned-By: MIMEDefang 2.52 on 10.7.209.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15523>

 
>Thank Len. He may have done it as a way to avoid having extra merges, 
>since I complained about those last time ;)

Seems I'm batting 1000 for entertainment value
over my last two kernel patch pushes:-)

The previous one I took abuse for unwittingly cluttering
history with "extra" merges.  The thread went on
and on, but buried in there were some interesting
observations on work flow, and somebody
asserted that the "cleanest" way to cherry pick
the topic branches onto the release branch was
with a multi-branch merge.

As git merge seemed to advertise support for it w/o
me needing to learn a new command, I tried it out
and it seemed to work fine -- including a nice colorful
diagram in gitk:-)

I can do 16 next time, or 22, or none -- or you can have
git merge under the covers do this via iteration instead
of all at once -- that's up to you guys.  My topic branches
tend to be disjoint topics with little expected overlap;
so grabbing a bunch of them when they're fully "cooked"
in -mm and plunking them down in one merge is actually
an example of history matching reality.

cheers,
-Len
