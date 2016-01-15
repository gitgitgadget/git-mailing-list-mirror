From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/4] Fix compile warnings with MSys2's compiler
Date: Fri, 15 Jan 2016 14:24:19 +0100 (CET)
Message-ID: <cover.1452864241.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 14:25:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK4Mf-0003Ti-MH
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 14:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161068AbcAONY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 08:24:26 -0500
Received: from mout.gmx.net ([212.227.15.19]:54155 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161062AbcAONYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 08:24:25 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MaIPo-1aZPOH0NvU-00Jthx; Fri, 15 Jan 2016 14:24:21
 +0100
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:OVZWd/YlH8dJjDNqyZmipSsaVACvtMJWGoQnizr2a30ji2QR9oV
 oaxQkrJFjVqx9gxL5RbHk+5Hcvh5jnHY0SKTVSslbBzz/MbshwGDrYp+eDzXfT1xyUEXgEe
 SVPHLGJLkFnCrt8udYl9RPvJFjNRDZ+oHc7b1V3m66rnyO62SS30a/L1/v1wpL3gz8xR2Ci
 0e33u9H3+q8fbMQcH1GQg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iQIO3XqqU/c=:iwlWWaIrtzAMBZvCtuwbsY
 HuQWQ5PrRmihBDENA4k23os6iHpk5HIu2Ve0HuFRhCcGLpb0ztaWE0RpcyRaWG9sTKSUvwhxG
 pgQZDZwDmf3ARkhYUjzyx2dVcNtXap+VLqi54L6ycxItq9HjQTE5LPo/YH8lvMVgEMohKX1Dk
 g5QJyr2uAhxq5NmgIxnJwGKwu3TNtODQp+knRe0UFawLvw2z2pP8m0dQjgU6XFbu/IcQ2LJbD
 kVhGOsE3Lj0Mt012pJTd2whs40V0s2oGijYoY3N95HZMNVRHwo7+Ffpbxwpn+bBPRCkd6gxD6
 OAd2dkNpvRKwYU/+qKrnsZFo/97frV4U8pIici4AJVa8ww4iplgz4gu0W3fqyx7yaSAS+dYbz
 XapAqp23odkk6pZckoM0VYq17y3RM4JRD384iLGrLtI2EERxSDr79gRZgF4WQkiP1/AiAqnSG
 GcgpKixH1z8Jx1dNjx/qwR++pdvy4tksv3lXMkgFcqGinNDHhuMILdbrGUHjtTsyDDf8lMTez
 eSD3Ay7I3H1pP3q74K7ajhN2ekgtx+/rNBC6yIj2KxD3bZoZbbDUiImhviVXbdpI+ZeMtIlAH
 rSrKlatMswQ5aDJvMOuvgeiTVyrDGnLmOlJaBAh2ZNo34HoX/hiaLD35SgNHaW28sOpiWpPSr
 OGXx4KAFFdpiSf9juJn2Afc/PIolU4wfaN9BS7GutlVFdENGrgeGi1R9DtMcCEgziFuvurj4E
 sfpDwfMxFvTBIFP7Jvxfz+pVlI2bIIYfE7RLmZBrgcz2SkpPJJzmVI9XdH2oxcVmeEY6JkjC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284166>

This is the second batch of Windows-specific patches from the Git for
Windows project. Naturally, it is based on the first batch of patches
that fixed the compile errors.

Please note that this series does the *minimal* job of fixing the
compile warnings. Don't try to run the tests, they will still fail. You
have been warned.


Johannes Schindelin (4):
  mingw: avoid redefining S_* constants
  mingw: avoid warnings when casting HANDLEs to int
  mingw: squash another warning about a cast
  mingw: uglify (a, 0) definitions to shut up warnings

 compat/mingw.c              | 9 ++++++---
 compat/mingw.h              | 4 ++++
 compat/nedmalloc/malloc.c.h | 3 ++-
 compat/poll/poll.c          | 2 +-
 compat/win32/pthread.h      | 7 +++++--
 compat/winansi.c            | 3 ++-
 6 files changed, 20 insertions(+), 8 deletions(-)

-- 
2.7.0.windows.1.7.g55a05c8
