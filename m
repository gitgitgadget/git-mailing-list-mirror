From: <Stefan.Liebl@partner.bmw.de>
Subject: submodules: reuse .git/modules/... for multiple checkouts of same
 URL
Date: Mon, 3 Mar 2014 12:24:23 +0000
Message-ID: <175C83AE67A6484B9A9351B9AE4D0662042809@smucm57a>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 13:34:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKS4e-00079P-NB
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 13:34:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754321AbaCCMeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 07:34:20 -0500
Received: from mailout03.rmx.de ([217.111.120.11]:51230 "EHLO mailout03.rmx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751756AbaCCMeU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2014 07:34:20 -0500
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Mar 2014 07:34:19 EST
Received: from kdin01.retarus.de (kdin01.retarus.de [172.19.17.48] (may be forged))
	by mailout03.rmx.de (8.14.4/8.14.5/retarus.custom) with ESMTP id s23COSAR013392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Mon, 3 Mar 2014 13:24:28 +0100
Received: from cmtamx4b.bmwgroup.com (cmtamx4b.bmwgroup.com [160.46.252.50])
	by kdin01.retarus.de (8.14.5/8.14.2/retarus.custom) with ESMTP id s23COQkH014381
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Mon, 3 Mar 2014 13:24:27 +0100
Received: from cmtabb6a.muc (cmtabb6a.muc [160.50.100.27])
	by cmtamx4a.bmwgroup.com (8.13.8/8.13.8) with ESMTP id s23COORO024779
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Mon, 3 Mar 2014 13:24:24 +0100
Received: from SMUCH56B.europe.bmw.corp (smuch56b.muc [160.46.137.110])
	by cmtabb6a.muc (8.13.8/8.13.8) with ESMTP id s23CONS0023144
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Mon, 3 Mar 2014 13:24:24 +0100
Received: from SMUCM57A.europe.bmw.corp ([160.46.137.89]) by
 SMUCH56B.europe.bmw.corp ([160.46.137.110]) with mapi id 14.02.0342.003; Mon,
 3 Mar 2014 13:24:23 +0100
Thread-Topic: submodules: reuse .git/modules/... for multiple checkouts of
 same URL
Thread-Index: Ac8224JpQ1R39X6eQ4iMKYB2PUX1HA==
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.44.109]
X-Spam-Status: No, No
X-RMX-ID: 20140303-132427-s23COQkH014381-0@kdin01
X-RMX-TRACE: 2014-03-03 13:24:27 RmxMSO@kdin01/mailcc08 [0.1s] 20140303-132427-s23COQkH014381-0@kdin01 0:00:00
X-RMX-TRACE: 2014-03-03 13:24:27 KdIn2013@kdin01/mailcc05 [0.3s] 20140303-132427-s23COQkH014381-0@kdin01 0:00:00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243220>

Hi,

I have a git superproject with 3 submodules. The submodules are cloned from the same URL but use different branches. Git clones the repo three times and I have three entries in .git/modules. Is it possible to reuse the first clone for the next submodule clones?

Stefan
