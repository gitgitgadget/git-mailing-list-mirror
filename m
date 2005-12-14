From: "Brown, Len" <len.brown@intel.com>
Subject: RE: new file leaked onto release branch
Date: Wed, 14 Dec 2005 16:31:58 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30056B8652@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Linus Torvalds" <torvalds@osdl.org>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 22:36:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmeFr-0005mb-KN
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 22:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbVLNVdl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 16:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbVLNVdl
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 16:33:41 -0500
Received: from fmr14.intel.com ([192.55.52.68]:65235 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S964989AbVLNVdk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2005 16:33:40 -0500
Received: from fmsfmr101.fm.intel.com (fmsfmr101.fm.intel.com [10.253.24.21])
	by fmsfmr002.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id jBELW7LN009142;
	Wed, 14 Dec 2005 21:32:07 GMT
Received: from fmsmsxvs043.fm.intel.com (fmsmsxvs043.fm.intel.com [132.233.42.129])
	by fmsfmr101.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id jBELVlBx011096;
	Wed, 14 Dec 2005 21:32:07 GMT
Received: from fmsmsx332.amr.corp.intel.com ([132.233.42.148])
 by fmsmsxvs043.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2005121413320613666
 ; Wed, 14 Dec 2005 13:32:06 -0800
Received: from fmsmsx311.amr.corp.intel.com ([132.233.42.214]) by fmsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 14 Dec 2005 13:32:06 -0800
Received: from hdsmsx401.amr.corp.intel.com ([10.127.2.60]) by fmsmsx311.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 14 Dec 2005 13:32:06 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: new file leaked onto release branch
Thread-Index: AcYA9PWBRRFlrs2jRTaUBVyOVufV7gAAJR9w
To: "Tom Prince" <tom.prince@ualberta.net>,
	"Junio C Hamano" <junkio@cox.net>
X-OriginalArrivalTime: 14 Dec 2005 21:32:06.0478 (UTC) FILETIME=[D4DB7EE0:01C600F5]
X-Scanned-By: MIMEDefang 2.52 on 10.253.24.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13646>

>> I pointed out one anomaly which is the commit should never have
>> been created because it was not even a fast forward but already
>> up-to-date case, and it was followed up with exchange of a few
>> messages between Linus and you.
>> 
>
>I don't remember any of the details now, but I remember that an old
>version of git or cogito would create bogus fast-forward 
>merges, if they
>were used without GNU coreutils. The machine it happend on was running
>FreeBSD 4.10, but current versions work fine.

I'm running SuSE Linux 10.0 x86_64 on this box
# rpm -q coreutils
coreutils-5.3.0-20
