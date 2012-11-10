From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: t9350-fast-export.sh  broken on peff/pu under Mac OS X
Date: Sat, 10 Nov 2012 15:37:36 +0100
Message-ID: <509E66B0.3040308@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: felipe.contreras@gmail.com, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 10 15:37:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXCBz-0000S8-Mf
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 15:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853Ab2KJOhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 09:37:38 -0500
Received: from mout.web.de ([212.227.15.4]:63878 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747Ab2KJOhi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 09:37:38 -0500
Received: from birne.lan ([195.67.191.23]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MMFFF-1TPnGX2vDZ-00874Q; Sat, 10 Nov 2012 15:37:36 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
X-Provags-ID: V02:K0:wM92hY+Yjpo3Fe2iWpEtZbUankPiMa1t8DWfVOHth53
 QkFg0pQGSApMJewGVNB8/3UrfHLeJ+Xt8vK+HgO0gEKRZqdEhN
 q2nMRlvveUlTHYwWeOx2R32cS39I02JlLQ+A7ccOEhnu3eOwkn
 fgD9RQX3qLSWOQRriDfK0KGGywoTJ2PA4OdPPnf3fk+F/Cqxi8
 yZSm/DmsZNbcYTgJJrJXQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209276>

The short version:
echo -n doesn't seem to be portable.
The following works for me:

(And is this a typo: test_expect_success 'test biridectionality' ')

/Torsten



 diff ../../git.peff/t/t9350-fast-export.sh t9350-fast-export.sh
444,445c444,445
<       echo -n > marks-cur &&
<       echo -n > marks-new &&
---
>       > marks-cur &&
>       > marks-new &&
464c464
<       echo -n > tmp-marks &&
---
>       > tmp-marks &&
474c474
<       echo -n > expected &&
---
>       > expected &&
