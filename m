From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH] Fix pulling into the same branch.
Date: Fri, 26 Aug 2005 11:13:45 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F043BA469@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <git@vger.kernel.org>, "Linus Torvalds" <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Aug 26 20:15:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8iiN-0003hP-IC
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 20:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbVHZSOE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 14:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbVHZSOE
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 14:14:04 -0400
Received: from fmr14.intel.com ([192.55.52.68]:58302 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S965161AbVHZSOB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2005 14:14:01 -0400
Received: from fmsfmr101.fm.intel.com (fmsfmr101.fm.intel.com [10.253.24.21])
	by fmsfmr002.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j7QIDl4F014029;
	Fri, 26 Aug 2005 18:13:47 GMT
Received: from fmsmsxvs040.fm.intel.com (fmsmsxvs040.fm.intel.com [132.233.42.124])
	by fmsfmr101.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id j7QIDlEC019737;
	Fri, 26 Aug 2005 18:13:47 GMT
Received: from fmsmsx332.amr.corp.intel.com ([132.233.42.148])
 by fmsmsxvs040.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2005082611134600085
 ; Fri, 26 Aug 2005 11:13:46 -0700
Received: from fmsmsx312.amr.corp.intel.com ([132.233.42.227]) by fmsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 26 Aug 2005 11:13:46 -0700
Received: from scsmsx401.amr.corp.intel.com ([10.3.90.12]) by fmsmsx312.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 26 Aug 2005 11:13:46 -0700
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Fix pulling into the same branch.
Thread-Index: AcWqaHr/x7SU/m2tSnaBJTAojxpBuQAAIXTg
To: "Junio C Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-OriginalArrivalTime: 26 Aug 2005 18:13:46.0326 (UTC) FILETIME=[E65FE760:01C5AA69]
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7818>

>I am tempted to move this logic to "git fetch" instead, because
>it has the same issue.  Tony's "linus" branch example has been
>updated to do a "git fetch" instead of "git pull" from the
>earlier description in his howto, but if he happens to be on the
>"linus" branch, he would still have this same problem.

I don't spend much time on the linus branch (just to build an
updated cscope database, etc.).  I never want to check anything
in on that branch [sometime I should figure out how use the "hooks"
to keep me from shooting myself in the foot here].

>In the meantime, warning the user about the issue and suggesting
>how to do the fast-forwarding of the working tree himself in the
>warning message might be the safest and the most sensible thing
>to do.

Yes please ... a big fat warning with coloured flashing lights
and explosions from the sound card.

-Tony
