From: Tony Finch <dot@dotat.at>
Subject: Re: How to check repository/working tree status from a script
Date: Tue, 19 May 2009 17:16:36 +0100
Message-ID: <alpine.LSU.2.00.0905191710430.23478@hermes-2.csi.cam.ac.uk>
References: <20090519143537.GA23505@torres.zugschlus.de> <alpine.LSU.2.00.0905191630120.23478@hermes-2.csi.cam.ac.uk> <20090519160031.GB23505@torres.zugschlus.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Marc Haber <mh+git@zugschlus.de>
X-From: git-owner@vger.kernel.org Tue May 19 18:17:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6S0J-0006KI-11
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 18:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673AbZESQQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 12:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752827AbZESQQg
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 12:16:36 -0400
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:52597 "EHLO
	ppsw-7.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbZESQQg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 12:16:36 -0400
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:60335)
	by ppsw-7.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:25)
	with esmtpa (EXTERNAL:fanf2) id 1M6RzY-0000X3-PX (Exim 4.70)
	(return-path <fanf2@hermes.cam.ac.uk>); Tue, 19 May 2009 17:16:36 +0100
Received: from fanf2 (helo=localhost) by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1M6RzY-0007Ns-T8 (Exim 4.67)
	(return-path <fanf2@hermes.cam.ac.uk>); Tue, 19 May 2009 17:16:36 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <20090519160031.GB23505@torres.zugschlus.de>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119543>

On Tue, 19 May 2009, Marc Haber wrote:
>
> Am I missing something?

git-diff won't tell you about untracked files.

Use git ls-files --others --exclude-standard

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
GERMAN BIGHT HUMBER: SOUTHWEST 5 TO 7. MODERATE OR ROUGH. SQUALLY SHOWERS.
MODERATE OR GOOD.
