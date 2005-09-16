From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: getting a list of changes I commited
Date: Thu, 15 Sep 2005 17:13:03 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F04662C78@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 16 02:14:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EG3qx-0005Eq-05
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 02:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965296AbVIPANQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 20:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965297AbVIPANQ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 20:13:16 -0400
Received: from fmr15.intel.com ([192.55.52.69]:26534 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S965296AbVIPANP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 20:13:15 -0400
Received: from fmsfmr100.fm.intel.com (fmsfmr100.fm.intel.com [10.253.24.20])
	by fmsfmr005.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j8G0D5xp025539;
	Fri, 16 Sep 2005 00:13:05 GMT
Received: from fmsmsxvs043.fm.intel.com (fmsmsxvs043.fm.intel.com [132.233.42.129])
	by fmsfmr100.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id j8G0D5EW023625;
	Fri, 16 Sep 2005 00:13:05 GMT
Received: from fmsmsx332.amr.corp.intel.com ([132.233.42.148])
 by fmsmsxvs043.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2005091517130509513
 ; Thu, 15 Sep 2005 17:13:05 -0700
Received: from fmsmsx311.amr.corp.intel.com ([132.233.42.214]) by fmsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 15 Sep 2005 17:13:05 -0700
Received: from scsmsx401.amr.corp.intel.com ([10.3.90.12]) by fmsmsx311.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 15 Sep 2005 17:13:04 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: getting a list of changes I commited
Thread-Index: AcW6JK9UM9s6gCuNR7e+AR0myx/x1gALeJ4w
To: "Linus Torvalds" <torvalds@osdl.org>
X-OriginalArrivalTime: 16 Sep 2005 00:13:04.0927 (UTC) FILETIME=[68905AF0:01C5BA53]
X-Scanned-By: MIMEDefang 2.52 on 10.253.24.20
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8654>

>Why not just _also_ limit it by what is already merged in my tree?
>
>Ie just do
>
>	git fetch linus
>	git-rev-list --no-merges newhead ^oldhead ^linus

Doh!  Ok, now I see that you mean _instead_ (of trying to select by
committer) rather than _also_.

That is a whole lot simpler!

-Tony

[But finding out what I committed between two releases is also
useful for status report writing purposes, so this has been a
a useful learning exercise]
