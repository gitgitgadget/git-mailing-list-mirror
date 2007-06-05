From: "Matt Seitz" <seitz@neopathnetworks.com>
Subject: RE: How to remove invalid remote repository
Date: Tue, 5 Jun 2007 15:57:08 -0500
Message-ID: <8A00BB77B01133479F4A56D932A113220290715F@EX-401.mail.navisite.com>
References: <8A00BB77B01133479F4A56D932A1132202906FD8@EX-401.mail.navisite. com> <alpine.LFD.0.98.0706051308090.4921@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 05 22:57:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvg5t-0006go-2L
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 22:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764032AbXFEU5V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 16:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765525AbXFEU5V
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 16:57:21 -0400
Received: from iss04.interliant.com ([207.113.241.148]:43114 "EHLO
	iss04.interliant.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764584AbXFEU5U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jun 2007 16:57:20 -0400
Received: from EX-009.mail.navisite.com (ex-009.interliant.com [207.113.240.184])
	by iss04.interliant.com (8.10.2/8.10.2) with ESMTP id l55KvC517188;
	Tue, 5 Jun 2007 15:57:12 -0500 (CDT)
Received: from EX-401.mail.navisite.com ([172.16.1.235]) by EX-009.mail.navisite.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 5 Jun 2007 15:57:09 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <alpine.LFD.0.98.0706051308090.4921@woody.linux-foundation.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to remove invalid remote repository
Thread-Index: AcenrqpMkoiHnxMaRJG17CCyq69ddQABLZ7g
X-OriginalArrivalTime: 05 Jun 2007 20:57:09.0506 (UTC) FILETIME=[15347620:01C7A7B4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49228>

From: Linus Torvalds [mailto:torvalds@linux-foundation.org] 
> Well, this is because you apparently didn't call the remote 
> "origin", but something else. So when you do
> 
> 	git fetch
> 
> without giving any remote name at all, git will *default* to 
> using "origin" as a remote,

Ah, I see now.  I misread that section of the "Git User's Manual".
Using 

git fetch root-etc

worked fine.

Sorry to have bothered everyone with my error.
