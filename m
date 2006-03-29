From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: Problem with git bisect between 2.6.15 and 2.6.16
Date: Wed, 29 Mar 2006 11:43:20 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F06176441@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "sean" <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Wed Mar 29 21:44:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOgZi-0000uc-3J
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 21:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWC2TnX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Mar 2006 14:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWC2TnX
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Mar 2006 14:43:23 -0500
Received: from mga02.intel.com ([134.134.136.20]:46741 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750879AbWC2TnW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Mar 2006 14:43:22 -0500
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101-1.jf.intel.com with ESMTP; 29 Mar 2006 11:43:22 -0800
Received: from scsmsx332.sc.intel.com (HELO scsmsx332.amr.corp.intel.com) ([10.3.90.6])
  by orsmga001.jf.intel.com with ESMTP; 29 Mar 2006 11:43:21 -0800
X-IronPort-AV: i="4.03,144,1141632000"; 
   d="scan'208"; a="16741898:sNHT238303527"
Received: from scsmsx401.amr.corp.intel.com ([10.3.90.12]) by scsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 29 Mar 2006 11:43:21 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem with git bisect between 2.6.15 and 2.6.16
Thread-Index: AcZR/bastIYtt6KrS1+Kc8O6HAm+fQBZffRAAAExqwA=
To: "Greg Lee" <glee@casabyte.com>, <git@vger.kernel.org>
X-OriginalArrivalTime: 29 Mar 2006 19:43:21.0648 (UTC) FILETIME=[09213300:01C65369]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18180>

 
> This was progressing fine until I ran into an issue that makes the kernel unstable causing
> it to crash at semi-random times.  I'm down to about 350 commits left in the bisect.  I've
> tried:
> 
> git reset --hard HEAD~3
>
>no luck, same problem, unstable

You can try "git bisect visualize" to invoke gitk on the remaining commits, and
then pick a likely looking stable point for your next test.  This is documented
reasonably well in the git Documentation/howto/isolate-bugs-with-bisect.txt

-Tony
