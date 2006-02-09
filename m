From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: What's in git.git
Date: Thu, 9 Feb 2006 15:49:16 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F05AA1FB3@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 10 00:50:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7LY0-00010O-6S
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 00:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWBIXt6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 18:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWBIXt6
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 18:49:58 -0500
Received: from fmr22.intel.com ([143.183.121.14]:10425 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750840AbWBIXt5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2006 18:49:57 -0500
Received: from scsfmr101.sc.intel.com (scsfmr101.sc.intel.com [10.3.253.10])
	by scsfmr002.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k19NnIvU025171;
	Thu, 9 Feb 2006 23:49:18 GMT
Received: from scsmsxvs041.sc.intel.com (scsmsxvs041.sc.intel.com [10.3.90.10])
	by scsfmr101.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id k19Ni8s3014823;
	Thu, 9 Feb 2006 23:44:32 GMT
Received: from scsmsx332.amr.corp.intel.com ([10.3.90.6])
 by scsmsxvs041.sc.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2006020915491812104
 ; Thu, 09 Feb 2006 15:49:18 -0800
Received: from scsmsx401.amr.corp.intel.com ([10.3.90.12]) by scsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 9 Feb 2006 15:49:18 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: What's in git.git
Thread-Index: AcYt0RLXT95YQLBgREyThBce0DXHQwAAWdsw
To: "Ryan Anderson" <ryan@michonline.com>
X-OriginalArrivalTime: 09 Feb 2006 23:49:18.0203 (UTC) FILETIME=[70E4CCB0:01C62DD3]
X-Scanned-By: MIMEDefang 2.52 on 10.3.253.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15843>

Looks very close to what I want.

> git checkout topic
> git format-patch --stdout origin > topic-diff

 topic-diff contains each commit as a separate message

> $VISUAL topic-diff
> # Fix comments

 so this needs some skill & care to rearrange the pieces
 and end up with legal input to git-am

Perhaps I'd like to have:

 git diff SHA-where-I-branched..HEAD

but I don't see the way to compute the SHA-where-I-branched

-Tony
