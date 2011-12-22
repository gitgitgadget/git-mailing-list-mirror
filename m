From: "Schmidt, Marco" <Marco.Schmidt@cassidian.com>
Subject: Patch to support proxy authentication through NTLM?
Date: Thu, 22 Dec 2011 09:45:05 +0100
Message-ID: <4CDEC141B5583D408E79F2931DB7708301691B80@GSX300A.mxchg.m.corp>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 22 09:45:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdeHD-0002tt-5h
	for gcvg-git-2@lo.gmane.org; Thu, 22 Dec 2011 09:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767Ab1LVIpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Dec 2011 03:45:18 -0500
Received: from mail.eads.net ([80.156.45.113]:50670 "EHLO mail.eads.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753913Ab1LVIpR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Dec 2011 03:45:17 -0500
Received: from gsx3071-vs5.mxchg.m.corp ([53.147.176.148])
	by mail.eads.net (8.13.8/8.13.8/Debian-2) with ESMTP id pBM8ioRg007705
	for <git@vger.kernel.org>; Thu, 22 Dec 2011 09:44:51 +0100
Received: from gsx300a.mxchg.m.corp ([10.43.212.131]) by gsx3071-vs5.mxchg.m.corp with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 22 Dec 2011 09:45:09 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Patch to support proxy authentication through NTLM?
Thread-Index: AczAhgBa482iZ/2uQdmSedsZWakbwA==
X-OriginalArrivalTime: 22 Dec 2011 08:45:09.0233 (UTC) FILETIME=[02D16610:01CCC086]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187604>

 
After debugging git proxy authentication and creating my own fix to
support git+https over an NTLM proxy I found a set of patches inside of
the mailing list archives [1]. What is the state of this patch set? The
essence of the patch would be to allow NTLM authentification by giving
the correct options to libcurl.
 
Marco 
 
E: marco point schmidt at taugamma.de 
 
 
[1] http://kerneltrap.org/mailarchive/git/2009/2/2/4873274 
 
