From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: cache status after git pull
Date: Thu, 25 Aug 2005 13:46:22 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F043B9B85@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 25 22:47:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8OcU-0000QQ-MW
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 22:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbVHYUqk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 16:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbVHYUqk
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 16:46:40 -0400
Received: from fmr13.intel.com ([192.55.52.67]:9663 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S932568AbVHYUqj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Aug 2005 16:46:39 -0400
Received: from fmsfmr100.fm.intel.com (fmsfmr100.fm.intel.com [10.253.24.20])
	by fmsfmr001.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j7PKkZgM030132;
	Thu, 25 Aug 2005 20:46:35 GMT
Received: from fmsmsxvs040.fm.intel.com (fmsmsxvs040.fm.intel.com [132.233.42.124])
	by fmsfmr100.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id j7PKkZhJ002090;
	Thu, 25 Aug 2005 20:46:35 GMT
Received: from fmsmsx331.amr.corp.intel.com ([132.233.42.156])
 by fmsmsxvs040.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2005082513463519742
 ; Thu, 25 Aug 2005 13:46:35 -0700
Received: from fmsmsx311.amr.corp.intel.com ([132.233.42.214]) by fmsmsx331.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 25 Aug 2005 13:46:23 -0700
Received: from scsmsx401.amr.corp.intel.com ([10.3.90.12]) by fmsmsx311.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 25 Aug 2005 13:46:23 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cache status after git pull
Thread-Index: AcWpszsJpJUMu8ubSh2I6Urqve5tFAAAahoA
To: "Junio C Hamano" <junkio@cox.net>
X-OriginalArrivalTime: 25 Aug 2005 20:46:23.0306 (UTC) FILETIME=[0DF26AA0:01C5A9B6]
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7762>

>To set up "linus" short-hand to be updated with "master" branch
>head from Linus, you would do one of the following:
>
>  * Using new style shorthand
>
>    $ cat >$GIT_DIR/remotes/linus \
>    URL: http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
>    Pull: master:linus
>    $ git fetch linus

This sounds like it does what I want ... so I'd like to confirm
before wiring this into my scripts and fingers.

What I want is to get the latest from kernel.org...linus...master
and update my .refs/heads/linus with the new SHA1.

I'd like to be able to do that without touching what is in my
index, and without changing the state of any checked out files.

If that is what the above does, then you are my hero for today :-)

-Tony
