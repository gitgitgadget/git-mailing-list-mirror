From: Tony Finch <dot@dotat.at>
Subject: Re: [PATCH] upload-archive: fix infinite loop on Cygwin
Date: Thu, 18 Jun 2009 18:18:16 +0100
Message-ID: <alpine.LSU.2.00.0906181817400.2474@hermes-2.csi.cam.ac.uk>
References: <e664dae0905180737mae29811ie4cae889b3e3904f@mail.gmail.com> <4A151A15.6040609@lsrfire.ath.cx> <alpine.LSU.2.00.0905211431060.23478@hermes-2.csi.cam.ac.uk> <4A156556.900@lsrfire.ath.cx> <4A38C13E.6050800@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1870870024-1535096171-1245345496=:2474"
Cc: Junio C Hamano <gitster@pobox.com>, Bob Kagy <bobkagy@gmail.com>,
	git@vger.kernel.org
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jun 18 19:18:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHLFq-0001DL-Rh
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 19:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbZFRRSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 13:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753848AbZFRRSR
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 13:18:17 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:56464 "EHLO
	ppsw-0.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426AbZFRRSR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 13:18:17 -0400
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:53029)
	by ppsw-0.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.150]:25)
	with esmtpa (EXTERNAL:fanf2) id 1MHLFg-0003Kb-2V (Exim 4.70)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 18 Jun 2009 18:18:16 +0100
Received: from fanf2 (helo=localhost) by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1MHLFg-00036Z-OV (Exim 4.67)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 18 Jun 2009 18:18:16 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <4A38C13E.6050800@lsrfire.ath.cx>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121859>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1870870024-1535096171-1245345496=:2474
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 17 Jun 2009, Ren=C3=A9 Scharfe wrote:

> On Cygwin, poll() reports POLLIN even for file descriptors that have
> reached their end.  This caused git upload-archive to be stuck in an
> infinite loop, as it only looked at the POLLIN flag.

I think it isn't just Cygwin that does this - see
http://www.greenend.org.uk/rjk/2001/06/poll.html

Tony.
--=20
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
GERMAN BIGHT HUMBER: SOUTHWEST 5 TO 7. MODERATE OR ROUGH. SQUALLY SHOWERS.
MODERATE OR GOOD.
--1870870024-1535096171-1245345496=:2474--
