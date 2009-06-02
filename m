From: Tony Finch <dot@dotat.at>
Subject: Re: Am able to delete a file with no trace in the log
Date: Tue, 2 Jun 2009 21:29:45 +0100
Message-ID: <alpine.LSU.2.00.0906022128280.9226@hermes-2.csi.cam.ac.uk>
References: <EB2D87B9-3B03-431A-B204-C7799F9BA291@ausperks.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>
To: Graham Perks <gperks@ausperks.net>
X-From: git-owner@vger.kernel.org Tue Jun 02 22:30:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBacm-0003XR-85
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 22:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbZFBUaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 16:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbZFBUaG
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 16:30:06 -0400
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:59331 "EHLO
	ppsw-7.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbZFBUaE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 16:30:04 -0400
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:46545)
	by ppsw-7.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:25)
	with esmtpa (EXTERNAL:fanf2) id 1MBacD-0003BC-Pi (Exim 4.70)
	(return-path <fanf2@hermes.cam.ac.uk>); Tue, 02 Jun 2009 21:29:45 +0100
Received: from fanf2 (helo=localhost) by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1MBacD-0003lm-Ul (Exim 4.67)
	(return-path <fanf2@hermes.cam.ac.uk>); Tue, 02 Jun 2009 21:29:45 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <EB2D87B9-3B03-431A-B204-C7799F9BA291@ausperks.net>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120545>

On Tue, 2 Jun 2009, Graham Perks wrote:

> We just had this come up. A file was accidentally removed during a merge
> operation, and we could find no clue in the gitk and git log output as to
> which change the deletion occurred in. We found the original file addition in
> a change; but no other mention of this file.
>
> This seems like a bug. The log should show the file being deleted.

The manual for git log suggests the -c or --cc options ought to display
the information you want, but it doesn't seem to work in practice.

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
GERMAN BIGHT HUMBER: SOUTHWEST 5 TO 7. MODERATE OR ROUGH. SQUALLY SHOWERS.
MODERATE OR GOOD.
