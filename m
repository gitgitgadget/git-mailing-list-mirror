From: Tony Finch <dot@dotat.at>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Wed, 3 Jun 2009 22:53:20 +0100
Message-ID: <alpine.LSU.2.00.0906032240300.31588@hermes-2.csi.cam.ac.uk>
References: <200905122329.15379.jnareb@gmail.com> <200906030250.01413.jnareb@gmail.com> <alpine.LSU.2.00.0906032147330.31588@hermes-2.csi.cam.ac.uk> <200906032320.23559.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 23:53:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MByOp-0005f5-22
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 23:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507AbZFCVxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 17:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754346AbZFCVxV
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 17:53:21 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:56531 "EHLO
	ppsw-5.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbZFCVxU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 17:53:20 -0400
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:49665)
	by ppsw-5.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.155]:25)
	with esmtpa (EXTERNAL:fanf2) id 1MByOe-00011b-J6 (Exim 4.70)
	(return-path <fanf2@hermes.cam.ac.uk>); Wed, 03 Jun 2009 22:53:20 +0100
Received: from fanf2 (helo=localhost) by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1MByOe-0000pR-TG (Exim 4.67)
	(return-path <fanf2@hermes.cam.ac.uk>); Wed, 03 Jun 2009 22:53:20 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <200906032320.23559.jnareb@gmail.com>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120648>

On Wed, 3 Jun 2009, Jakub Narebski wrote:
>
> Actually git accepts both lowercase and uppercase in HEXDIG (at least
> for pkt-length), but it prefers lowercase.

You should ensure that all hex digit strings follow the same rule.
Are SHA-1 object names case insensitive too?

Case insensitivity has a history of being awkward. SMTP has always had
case-insensitive commands, though the RFCs have always written them in
upper case and implementations have pretty much all emitted them in upper
case. See http://tools.ietf.org/html/rfc5321#section-2.4 especially the
caveat about broken case-sensitive implementations.

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
GERMAN BIGHT HUMBER: SOUTHWEST 5 TO 7. MODERATE OR ROUGH. SQUALLY SHOWERS.
MODERATE OR GOOD.
