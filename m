From: Sebastien Tardif <sebastien_tardif@oxfordcorp.com>
Subject: Updated tags on repo are not updated when pull
Date: Mon, 2 Apr 2012 19:16:21 +0000
Message-ID: <27353249354D994D8E42D75D75FBA614896543@OASBEVEXM01.oaifield.onasgn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 02 21:25:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEmt1-0004XQ-6S
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 21:25:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559Ab2DBTZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 15:25:45 -0400
Received: from smtp12.onasgn.net ([166.70.65.168]:39330 "EHLO
	smtp12.onasgn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458Ab2DBTZo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Apr 2012 15:25:44 -0400
X-Greylist: delayed 557 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Apr 2012 15:25:44 EDT
Received: from pps.filterd (smtp12 [127.0.0.1])
	by smtp12.onasgn.net (8.14.4/8.14.4) with SMTP id q32JBmb0005012
	for <git@vger.kernel.org>; Mon, 2 Apr 2012 12:16:24 -0700
Received: from oasslcexh03.oaifield.onasgn.com ([172.23.1.141])
	by smtp12.onasgn.net with ESMTP id 13y7hwsm5e-2
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Mon, 02 Apr 2012 12:16:24 -0700
Received: from OASBEVEXH01.oaifield.onasgn.com (172.22.1.46) by
 oasslcexh03.oaifield.onasgn.com (172.23.1.141) with Microsoft SMTP Server
 (TLS) id 14.1.339.1; Mon, 2 Apr 2012 12:16:23 -0700
Received: from OASBEVEXM01.oaifield.onasgn.com ([fe80::693c:1ef:7afc:6e9f]) by
 OASBEVEXH01.oaifield.onasgn.com ([fe80::70a5:31ce:8a13:d1f8%10]) with mapi id
 14.01.0339.001; Mon, 2 Apr 2012 12:16:22 -0700
Thread-Topic: Updated tags on repo are not updated when pull
Thread-Index: Ac0RBRIJ7NuhP9kdRiGOIq5xgbyYnw==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.23.1.140]
x-loop: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194551>

Default pull behavior does bring new tag that are hitting the revisions involved in the pull, in other words all tags that would point to log entries that are pulled.

I have tag like: LATEST_UIT, LATEST_QA, LATEST_CONTINOUS_BUILD

But with this incoherent behavior of not having the already pulled tag been updated when doing a pull, my developers end-up with misleading information in their log since their tags point to old pointer.

Please fix.
