From: "Luck, Tony" <tony.luck@intel.com>
Subject: getting a list of changes I commited
Date: Thu, 15 Sep 2005 11:14:45 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F046625FC@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-From: git-owner@vger.kernel.org Thu Sep 15 20:16:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFyG1-00016t-VW
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 20:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030505AbVIOSOr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 14:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030507AbVIOSOr
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 14:14:47 -0400
Received: from fmr16.intel.com ([192.55.52.70]:47031 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030505AbVIOSOr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 14:14:47 -0400
Received: from fmsfmr100.fm.intel.com (fmsfmr100.fm.intel.com [10.253.24.20])
	by fmsfmr006.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j8FIEkVi021200
	for <git@vger.kernel.org>; Thu, 15 Sep 2005 18:14:46 GMT
Received: from fmsmsxvs043.fm.intel.com (fmsmsxvs043.fm.intel.com [132.233.42.129])
	by fmsfmr100.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id j8FIEKF8026182
	for <git@vger.kernel.org>; Thu, 15 Sep 2005 18:14:46 GMT
Received: from fmsmsx332.amr.corp.intel.com ([132.233.42.148])
 by fmsmsxvs043.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2005091511144628005
 for <git@vger.kernel.org>; Thu, 15 Sep 2005 11:14:46 -0700
Received: from fmsmsx312.amr.corp.intel.com ([132.233.42.227]) by fmsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 15 Sep 2005 11:14:46 -0700
Received: from scsmsx401.amr.corp.intel.com ([10.3.90.12]) by fmsmsx312.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 15 Sep 2005 11:14:45 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: getting a list of changes I commited
Thread-Index: AcW6IVms1+Hk2YeZTkewxCbWR7F2NA==
To: <git@vger.kernel.org>
X-OriginalArrivalTime: 15 Sep 2005 18:14:45.0902 (UTC) FILETIME=[5A257AE0:01C5BA21]
X-Scanned-By: MIMEDefang 2.52 on 10.253.24.20
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8619>

I've been asked whether I can provide e-mail notification
when I take patches into my tree.  I took a look at the
existing hooks, and I don't think that I want to do this
when I first make a commit ... sometimes I back these out
again if there is a problem when I test.

So I think that what I want is to produce a list of changes
that I commited when I push a new tree out to kernel.org.
But ... such a push usually contains lots of flow-through
changes that I pulled from Linus ... so a simple:

 $ git-rev-list --no-merges newhead ^oldhead

gives a long list of changes.  I'd like to filter out
all the ones that weren't commited by me.  Is there an
argument to git-rev-list that will just print the entries
where I'm listed as the commiter, or do I have to use
"--pretty-full" and write a little script to do the trim?

Or is there some other way to do this?

-Tony
