From: Wert Alexander <Alexander.Wert@novatec-gmbh.de>
Subject: Bug: Wrong GitHub API result when retrieving repository information
Date: Wed, 3 Feb 2016 06:58:36 +0000
Message-ID: <7f00f77e5c8946ae8a17c76feb7dc98b@DGPR01.novatec-gmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 03 08:06:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQrVv-0001X2-UA
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 08:06:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933161AbcBCHGD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 02:06:03 -0500
Received: from mx1.novatec-gmbh.de ([193.37.149.230]:54046 "EHLO
	mx1.novatec-gmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933047AbcBCHGB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Feb 2016 02:06:01 -0500
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Feb 2016 02:06:01 EST
Received: from [10.60.1.11] (port=26936 helo=DGPR01.novatec-gmbh.de)
	by mx1.novatec-gmbh.de with esmtps (TLSv1.2:AES256-SHA:256)
	(Exim 4.82_1-5b7a7c0-XX)
	(envelope-from <Alexander.Wert@novatec-gmbh.de>)
	id 1aQrOg-0008UV-0u
	for git@vger.kernel.org; Wed, 03 Feb 2016 07:58:38 +0100
Received: from DGPR01.novatec-gmbh.de (10.60.1.11) by DGPR01.novatec-gmbh.de
 (10.60.1.11) with Microsoft SMTP Server (TLS) id 15.0.1130.7; Wed, 3 Feb 2016
 07:58:36 +0100
Received: from DGPR01.novatec-gmbh.de ([192.168.1.100]) by
 DGPR01.novatec-gmbh.de ([192.168.1.100]) with mapi id 15.00.1130.005; Wed, 3
 Feb 2016 07:58:36 +0100
X-CTCH-RefID: str=0001.0A0C0203.56B1A51E.00FB,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Thread-Topic: Bug: Wrong GitHub API result when retrieving repository
 information
Thread-Index: AdFeUEaoTLYJc6C5QU2+tnLVDipXfw==
Accept-Language: en-GB, de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.70.3.10]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285336>

Dear GitHub Developers,

I'm using the GitHub API for retrieving statistics like stargazers_count or watchers_count.
Unfortunately, an API call to https://api.github.com/users/<USER>/repos returns (as JSON) the same number for stargazers_count and watchers_count, although on the Website the numbers are different.

Example:
...
"size": 5279,
"stargazers_count": 51,
"watchers_count": 51,
"language": "Java",
...


The actual count on the website, however,  are 51 for stargazers and 20 for watchers.

Any idea what could be the problem?

Thank you in advance!

Regards,
Alexander Wert
