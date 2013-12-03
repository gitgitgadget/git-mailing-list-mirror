From: Nick Townsend <nick.townsend@mac.com>
Subject: [PATCH] Improvements to git-archive tests and add_submodule_odb()
Date: Mon, 02 Dec 2013 16:10:30 -0800
Message-ID: <C74C17E7-0780-4FE1-B916-D1A444F3B592@mac.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?windows-1252?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Nick Townsend <nick.townsend@mac.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 03 01:11:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VndaE-0004hP-LT
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 01:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703Ab3LCALF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Dec 2013 19:11:05 -0500
Received: from nk11p03mm-asmtpout001.mac.com ([17.158.232.236]:65145 "EHLO
	nk11p03mm-asmtp001.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752431Ab3LCALE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 Dec 2013 19:11:04 -0500
Received: from [172.16.1.4]
 (99-120-78-245.lightspeed.sntcca.sbcglobal.net [99.120.78.245])
 by nk11p03mm-asmtp001.mac.com
 (Oracle Communications Messaging Server 7u4-27.08(7.0.4.27.7) 64bit (built Aug
 22 2013)) with ESMTPSA id <0MX700A4FF6CHO10@nk11p03mm-asmtp001.mac.com> for
 git@vger.kernel.org; Tue, 03 Dec 2013 00:11:02 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.11.72,1.0.14,0.0.0000
 definitions=2013-12-02_04:2013-12-02,2013-12-02,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=13 phishscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=7.0.1-1308280000 definitions=main-1312020195
X-Mailer: Apple Mail (2.1822)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238666>

As per the previous patch request, I=92ve delayed the work on git-archi=
ve.
However the following two patches (attached as replies) should still
be considered.
Kind Regards
Nick