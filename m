From: "Brown, Len" <len.brown@intel.com>
Subject: RE: new file leaked onto release branch
Date: Wed, 14 Dec 2005 16:51:06 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30056B86A3@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 23:00:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmedC-0006j5-8g
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 22:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbVLNV5j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 16:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbVLNV5j
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 16:57:39 -0500
Received: from fmr14.intel.com ([192.55.52.68]:20447 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S964961AbVLNV5i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2005 16:57:38 -0500
Received: from fmsfmr101.fm.intel.com (fmsfmr101.fm.intel.com [10.253.24.21])
	by fmsfmr002.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id jBELvALN023872;
	Wed, 14 Dec 2005 21:57:10 GMT
Received: from fmsmsxvs040.fm.intel.com (fmsmsxvs040.fm.intel.com [132.233.42.124])
	by fmsfmr101.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id jBELsZCt029754;
	Wed, 14 Dec 2005 21:57:03 GMT
Received: from fmsmsx332.amr.corp.intel.com ([132.233.42.148])
 by fmsmsxvs040.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2005121413514822541
 ; Wed, 14 Dec 2005 13:51:53 -0800
Received: from fmsmsx312.amr.corp.intel.com ([132.233.42.227]) by fmsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 14 Dec 2005 13:51:12 -0800
Received: from hdsmsx401.amr.corp.intel.com ([10.127.2.60]) by fmsmsx312.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 14 Dec 2005 13:51:12 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: new file leaked onto release branch
Thread-Index: AcYA6oW57hUS86TXR4enwzULGCd1KQADbMwg
To: "Linus Torvalds" <torvalds@osdl.org>
X-OriginalArrivalTime: 14 Dec 2005 21:51:12.0328 (UTC) FILETIME=[7FD65480:01C600F8]
X-Scanned-By: MIMEDefang 2.52 on 10.253.24.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13648>

 
>That's what I get when I try this:
>
>	git checkout -b test-merge 0a47c906342e2447003e207d23917dfa5c912071
>	git merge "Testing merging" HEAD d2149b542382bfc206cb28485108f6470c979566
>
>results in a very immediate
>
>	"Already up-to-date."
>
>message. Does it do that for you too?

Yes.

>I think this list has been pretty responsive to reports of strange 
>behaviour, so yes. 

Agreed.
If I see anything strange like this in the future I'll report it immediately.

thanks,
-Len
