From: Tony Finch <dot@dotat.at>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Wed, 3 Jun 2009 21:56:07 +0100
Message-ID: <alpine.LSU.2.00.0906032147330.31588@hermes-2.csi.cam.ac.uk>
References: <200905122329.15379.jnareb@gmail.com> <200906022339.08639.jnareb@gmail.com> <20090602232724.GN30527@spearce.org> <200906030250.01413.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 22:56:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBxVT-0001JW-Gi
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 22:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898AbZFCU4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 16:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753833AbZFCU4I
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 16:56:08 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:58734 "EHLO
	ppsw-0.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753564AbZFCU4I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 16:56:08 -0400
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:38618)
	by ppsw-0.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.150]:25)
	with esmtpa (EXTERNAL:fanf2) id 1MBxVH-0005p8-0w (Exim 4.70)
	(return-path <fanf2@hermes.cam.ac.uk>); Wed, 03 Jun 2009 21:56:07 +0100
Received: from fanf2 (helo=localhost) by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1MBxVH-0003Es-8v (Exim 4.67)
	(return-path <fanf2@hermes.cam.ac.uk>); Wed, 03 Jun 2009 21:56:07 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <200906030250.01413.jnareb@gmail.com>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120641>

On Wed, 3 Jun 2009, Jakub Narebski wrote:
>
>      HEXDIGIT = 0-9 / a-f
>
> Well, it should probably be spelled in full. Probably, because I have
> no experience with using ABNF... and didn't do my research :-)

The ABNF core rules include a definition for HEXDIG. See appendix B of
RFC 5234.

> (should HEXDIGIT use lowercase a-f, or can it use uppercase A-F?)

Double-quoted strings in ABNF are case-insensitive ASCII, so the HEXDIG
rule accepts both. You need to use %x61 if you want a but not A.

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
GERMAN BIGHT HUMBER: SOUTHWEST 5 TO 7. MODERATE OR ROUGH. SQUALLY SHOWERS.
MODERATE OR GOOD.
