From: Tony Finch <dot@dotat.at>
Subject: Re: git+http:// proof-of-concept (not using CONNECT)
Date: Tue, 7 Jul 2009 17:14:31 +0100
Message-ID: <alpine.LSU.2.00.0907071712580.30197@hermes-2.csi.cam.ac.uk>
References: <20090702085440.GC11119@dcvr.yhbt.net> <85647ef50907020252u41e36187jaacacad3d8a10f75@mail.gmail.com> <20090703202839.GB12072@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jul 07 18:14:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MODJj-0007Qc-Lt
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 18:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757970AbZGGQOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 12:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758472AbZGGQOe
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 12:14:34 -0400
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:57432 "EHLO
	ppsw-7.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758707AbZGGQOd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 12:14:33 -0400
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:49855)
	by ppsw-7.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:25)
	with esmtpa (EXTERNAL:fanf2) id 1MODJP-0003Em-PE (Exim 4.70)
	(return-path <fanf2@hermes.cam.ac.uk>); Tue, 07 Jul 2009 17:14:31 +0100
Received: from fanf2 (helo=localhost) by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1MODJP-0006sm-Q6 (Exim 4.67)
	(return-path <fanf2@hermes.cam.ac.uk>); Tue, 07 Jul 2009 17:14:31 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <20090703202839.GB12072@dcvr.yhbt.net>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122852>

On Fri, 3 Jul 2009, Eric Wong wrote:
>
> That and my approach requires both the client and server to be
> simutaneously sending and receiving responses in full-duplex channel
> which makes it impossible to work without chunking.  IOW, there's no
> chance any HTTP proxy that dechunks or queues/coalesces chunked
> requests/responses can work with my approach.

Many HTTP servers will not be able to support it either because HTTP is a
half-duplex protocol (modulo request pipelining).

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
GERMAN BIGHT HUMBER: SOUTHWEST 5 TO 7. MODERATE OR ROUGH. SQUALLY SHOWERS.
MODERATE OR GOOD.
