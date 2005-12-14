From: "Brown, Len" <len.brown@intel.com>
Subject: RE: new file leaked onto release branch
Date: Wed, 14 Dec 2005 13:27:51 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B300567F3B8@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 19:33:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmbMx-0002Ut-5S
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 19:28:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbVLNS2m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 13:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbVLNS2m
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 13:28:42 -0500
Received: from fmr16.intel.com ([192.55.52.70]:63382 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S932498AbVLNS2l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2005 13:28:41 -0500
Received: from fmsfmr101.fm.intel.com (fmsfmr101.fm.intel.com [10.253.24.21])
	by fmsfmr006.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id jBEIRtoe031854;
	Wed, 14 Dec 2005 18:27:55 GMT
Received: from fmsmsxvs040.fm.intel.com (fmsmsxvs040.fm.intel.com [132.233.42.124])
	by fmsfmr101.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id jBEIRnBX012312;
	Wed, 14 Dec 2005 18:27:55 GMT
Received: from fmsmsx332.amr.corp.intel.com ([132.233.42.148])
 by fmsmsxvs040.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2005121410275423309
 ; Wed, 14 Dec 2005 10:27:54 -0800
Received: from fmsmsx312.amr.corp.intel.com ([132.233.42.227]) by fmsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 14 Dec 2005 10:27:54 -0800
Received: from hdsmsx401.amr.corp.intel.com ([10.127.2.60]) by fmsmsx312.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 14 Dec 2005 10:27:53 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: new file leaked onto release branch
Thread-Index: AcYAy3iT1F8h+zG1SIycZV3+F1fYawADxKpw
To: "Linus Torvalds" <torvalds@osdl.org>,
	"Junio C Hamano" <junkio@cox.net>
X-OriginalArrivalTime: 14 Dec 2005 18:27:54.0109 (UTC) FILETIME=[1921D2D0:01C600DC]
X-Scanned-By: MIMEDefang 2.52 on 10.253.24.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13636>

 
>Len, how old a git are you using? "git-merge" really should 
>_never_ have done this, but old (and I mean really old)
>git merges sometimes got confused with the base parent
>and would create a merge even when it was unnecessary.

should be the top of tree on the day the merge was made.

I generally pull from git://git.kernel.org/pub/scm/git/git.git
at the beginning of the day, build it and install it.

Right now git --version answers 0.99.9.GIT

-Len
