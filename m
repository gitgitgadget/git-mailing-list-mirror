From: Tony Finch <dot@dotat.at>
Subject: Re: [PATCH] 64-bit fix for date.c.
Date: Wed, 6 May 2009 15:26:36 +0100
Message-ID: <alpine.LSU.2.00.0905061523300.28199@hermes-2.csi.cam.ac.uk>
References: <20090406172637.GA17437@jenna.bytemine.net> <20090406190657.GC28120@coredump.intra.peff.net> <20090504142614.GE8658@jenna.bytemine.net> <20090504143112.GA14214@coredump.intra.peff.net> <7vvdoeye1c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 06 16:26:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1i5B-0005xR-Q7
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 16:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780AbZEFO0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 10:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752567AbZEFO0h
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 10:26:37 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:57296 "EHLO
	ppsw-1.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184AbZEFO0h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 10:26:37 -0400
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:33517)
	by ppsw-1.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.151]:25)
	with esmtpa (EXTERNAL:fanf2) id 1M1i4y-0003Xz-5X (Exim 4.70)
	(return-path <fanf2@hermes.cam.ac.uk>); Wed, 06 May 2009 15:26:36 +0100
Received: from fanf2 (helo=localhost) by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1M1i4y-0004ea-Ml (Exim 4.67)
	(return-path <fanf2@hermes.cam.ac.uk>); Wed, 06 May 2009 15:26:36 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <7vvdoeye1c.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118343>

Jeff King [Mon, Apr 06, 2009 at 03:06:58PM -0400] wrote:
>
>Hmph. According to POSIX, tv_sec _is_ a time_t. But I see on FreeBSD,
>also, it is actually a "long". So I think this fix makes sense.

FreeBSD-7 has time_t tv_sec.

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
GERMAN BIGHT HUMBER: SOUTHWEST 5 TO 7. MODERATE OR ROUGH. SQUALLY SHOWERS.
MODERATE OR GOOD.
