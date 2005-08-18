From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: git-whatchanged -p anomoly?
Date: Thu, 18 Aug 2005 15:44:03 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F042C819D@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 19 00:44:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5t7Z-0007lC-28
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 00:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbVHRWoN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 18:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbVHRWoN
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 18:44:13 -0400
Received: from fmr16.intel.com ([192.55.52.70]:59089 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S932505AbVHRWoN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2005 18:44:13 -0400
Received: from fmsfmr101.fm.intel.com (fmsfmr101.fm.intel.com [10.253.24.21])
	by fmsfmr006.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j7IMi5r9021324;
	Thu, 18 Aug 2005 22:44:05 GMT
Received: from fmsmsxvs040.fm.intel.com (fmsmsxvs040.fm.intel.com [132.233.42.124])
	by fmsfmr101.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id j7IMhF3L011760;
	Thu, 18 Aug 2005 22:44:05 GMT
Received: from fmsmsx332.amr.corp.intel.com ([132.233.42.148])
 by fmsmsxvs040.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2005081815440507378
 ; Thu, 18 Aug 2005 15:44:05 -0700
Received: from fmsmsx312.amr.corp.intel.com ([132.233.42.227]) by fmsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 18 Aug 2005 15:44:05 -0700
Received: from scsmsx401.amr.corp.intel.com ([10.3.90.12]) by fmsmsx312.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 18 Aug 2005 15:44:04 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git-whatchanged -p anomoly?
Thread-Index: AcWkQavgK+tGg8UsT4uhr/PvmucXswAA6bMQ
To: "Linus Torvalds" <torvalds@osdl.org>
X-OriginalArrivalTime: 18 Aug 2005 22:44:04.0904 (UTC) FILETIME=[56188280:01C5A446]
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


>Now, I suspect you didn't mean to commit that thing: it really looks like 
>you've mixed up your patches somehow, because the commit message seems to 
>match only a very small portion of the patch.
>
>Did you perhaps have a failed merge or something that was in your index 
>when you applied that patch? If you have a dirty index when you do 
>"git-applymbox", it the commit done as part of the applymbox might commit 
>other state too.

Yes I had a failed merge ... I thought that I had cleaned up from it, but
clearly I hadn't.  Bother.

I guess I have a bit of tree maintenance to do ... But I think that it
should be easy ... I can just step "test" back to before I merged in
the Alex patch.  Redo the Alex patch properly.  Then re-merge all the
branches that happened after this.  Followed by crossing my fingers and
running "git prune".

Maybe I'll try all that in a *copy" of my GIT tree first!

-Tony
