From: Tony Finch <dot@dotat.at>
Subject: Re: Cross-directory hard links
Date: Mon, 11 May 2009 17:40:15 +0100
Message-ID: <alpine.LSU.2.00.0905111738440.7187@hermes-2.csi.cam.ac.uk>
References: <loom.20090511T101424-212@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Cedric Staniewski <cedric@gmx.ca>
X-From: git-owner@vger.kernel.org Mon May 11 18:40:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3YYR-0003HH-Cf
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 18:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753760AbZEKQkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 12:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753477AbZEKQkR
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 12:40:17 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:46368 "EHLO
	ppsw-5.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbZEKQkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 12:40:16 -0400
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:36726)
	by ppsw-5.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.155]:25)
	with esmtpa (EXTERNAL:fanf2) id 1M3YY3-0006uh-Hh (Exim 4.70)
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 11 May 2009 17:40:15 +0100
Received: from fanf2 (helo=localhost) by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1M3YY3-0001ds-FD (Exim 4.67)
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 11 May 2009 17:40:15 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <loom.20090511T101424-212@post.gmane.org>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118809>

On Mon, 11 May 2009, Cedric Staniewski wrote:
>
> The problem only occurs on systems where git's bin and lib directories will be
> installed on different file systems, e.g. if /usr and /usr/lib are different
> mount points.

Some filesystems (a.g. AFS) do not support cross-directory hardlinks
even when they are under the same mount point.

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
GERMAN BIGHT HUMBER: SOUTHWEST 5 TO 7. MODERATE OR ROUGH. SQUALLY SHOWERS.
MODERATE OR GOOD.
