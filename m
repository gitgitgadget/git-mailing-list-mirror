From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: baffled again
Date: Wed, 24 Aug 2005 13:10:33 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F04385192@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 24 22:12:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E81ad-0001yx-SM
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 22:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbVHXUKy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 16:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbVHXUKy
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 16:10:54 -0400
Received: from fmr16.intel.com ([192.55.52.70]:54657 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S932082AbVHXUKx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2005 16:10:53 -0400
Received: from fmsfmr101.fm.intel.com (fmsfmr101.fm.intel.com [10.253.24.21])
	by fmsfmr006.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j7OKAgqh004765;
	Wed, 24 Aug 2005 20:10:42 GMT
Received: from fmsmsxvs040.fm.intel.com (fmsmsxvs040.fm.intel.com [132.233.42.124])
	by fmsfmr101.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id j7OKAenS008374;
	Wed, 24 Aug 2005 20:10:40 GMT
Received: from fmsmsx331.amr.corp.intel.com ([132.233.42.156])
 by fmsmsxvs040.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2005082413103931805
 ; Wed, 24 Aug 2005 13:10:40 -0700
Received: from fmsmsx311.amr.corp.intel.com ([132.233.42.214]) by fmsmsx331.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 24 Aug 2005 13:10:36 -0700
Received: from scsmsx401.amr.corp.intel.com ([10.3.90.12]) by fmsmsx311.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 24 Aug 2005 13:10:35 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: baffled again
Thread-Index: AcWo3EnS+597X0XbQhGlKIUJCr4HYAACoAIA
To: "Linus Torvalds" <torvalds@osdl.org>,
	"Junio C Hamano" <junkio@cox.net>
X-OriginalArrivalTime: 24 Aug 2005 20:10:36.0018 (UTC) FILETIME=[E3A68520:01C5A8E7]
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7727>

>I think git did the "right thing", it just happened to be the thing that
>Tony didn't want. Which makes it the "wrong thing", of course, but from a
>purely technical standpoint, I don't think there's anything really wrong
>with the merge. 

On the plus side ... at least it wasn't a dumb user error this time [unless
you count merging the incorrect patch in the first place, and then having
to revert it :-) ].

Could GIT be smarter here?  Perhaps it could pick a few likely
ancestors and run the merge with each ... and then give some
warnings if there are files that come out differently?

-Tony
