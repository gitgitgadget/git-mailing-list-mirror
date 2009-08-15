From: Tony Finch <dot@dotat.at>
Subject: Re: git-svn bug report: %20 in http:// should translate to a space
 ' ' automatically
Date: Sat, 15 Aug 2009 23:37:09 +0100
Message-ID: <alpine.LSU.2.00.0908152336240.449@hermes-2.csi.cam.ac.uk>
References: <4A86F4DA.5090605@smullindesign.com> <20090815181637.GC19833@atjola.homenet>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1870870024-797902073-1250375829=:449"
Cc: Mike Smullin <mike@smullindesign.com>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 16 00:37:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McRsK-0002xK-Ot
	for gcvg-git-2@gmane.org; Sun, 16 Aug 2009 00:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbZHOWhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 18:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752496AbZHOWhM
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 18:37:12 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:50603 "EHLO
	ppsw-0.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbZHOWhL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 18:37:11 -0400
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:55207)
	by ppsw-0.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.150]:25)
	with esmtpa (EXTERNAL:fanf2) id 1McRs5-0007as-3D (Exim 4.70)
	(return-path <fanf2@hermes.cam.ac.uk>); Sat, 15 Aug 2009 23:37:10 +0100
Received: from fanf2 (helo=localhost) by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1McRs5-0000UT-VQ (Exim 4.67)
	(return-path <fanf2@hermes.cam.ac.uk>); Sat, 15 Aug 2009 23:37:09 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <20090815181637.GC19833@atjola.homenet>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126033>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1870870024-797902073-1250375829=:449
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 15 Aug 2009, Bj=F6rn Steinbrink wrote:
>
> 3) git svn clone -Tgoo "http://host/repo/path with spaces/foo/bar"
>
> Works.

Spaces are not permitted in URLs so this should be treated as a syntax
error.

Tony.
--=20
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
GERMAN BIGHT HUMBER: SOUTHWEST 5 TO 7. MODERATE OR ROUGH. SQUALLY SHOWERS.
MODERATE OR GOOD.
--1870870024-797902073-1250375829=:449--
