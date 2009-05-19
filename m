From: Tony Finch <dot@dotat.at>
Subject: Re: How to check repository/working tree status from a script
Date: Tue, 19 May 2009 16:34:47 +0100
Message-ID: <alpine.LSU.2.00.0905191630120.23478@hermes-2.csi.cam.ac.uk>
References: <20090519143537.GA23505@torres.zugschlus.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Marc Haber <mh+git@zugschlus.de>
X-From: git-owner@vger.kernel.org Tue May 19 17:36:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6RLr-0001kD-Fm
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 17:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377AbZESPes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 11:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbZESPes
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 11:34:48 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:56534 "EHLO
	ppsw-0.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377AbZESPer (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 11:34:47 -0400
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:46471)
	by ppsw-0.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.150]:25)
	with esmtpa (EXTERNAL:fanf2) id 1M6RL5-0003yu-0M (Exim 4.70)
	(return-path <fanf2@hermes.cam.ac.uk>); Tue, 19 May 2009 16:34:47 +0100
Received: from fanf2 (helo=localhost) by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1M6RL5-0000px-3A (Exim 4.67)
	(return-path <fanf2@hermes.cam.ac.uk>); Tue, 19 May 2009 16:34:47 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <20090519143537.GA23505@torres.zugschlus.de>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119539>

On Tue, 19 May 2009, Marc Haber wrote:

Hi Marc.

> I would like to check in a script whether there (a) are uncommitted
> changes (as in "working tree differs from local repository")

# check working tree is not different from the index
git diff --quiet
# check that the index is not different from the head
git diff --quiet --cached

> and/or whether there (b) are unpulled changes in the "remote origin"
> repository.

Dunno, sorry.

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
GERMAN BIGHT HUMBER: SOUTHWEST 5 TO 7. MODERATE OR ROUGH. SQUALLY SHOWERS.
MODERATE OR GOOD.
