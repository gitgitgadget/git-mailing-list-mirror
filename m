From: Tony Finch <dot@dotat.at>
Subject: Re: Why Git is so fast
Date: Fri, 1 May 2009 18:42:38 +0100
Message-ID: <alpine.LSU.2.00.0905011840260.28199@hermes-2.csi.cam.ac.uk>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com> <m3fxfqnxn5.fsf_-_@localhost.localdomain> <b4087cc50904300556s359c91dfu444fa40ea85bd66e@mail.gmail.com> <200904301728.06989.jnareb@gmail.com> <20090430185244.GR23604@spearce.org>
 <86iqkllw0c.fsf@broadpark.no> <20090430204033.GV23604@spearce.org> <8663gllt88.fsf@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Fri May 01 20:10:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzxBy-00026H-Fu
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 20:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755602AbZEASKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 14:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759743AbZEASKH
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 14:10:07 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:60926 "EHLO
	ppsw-1.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756028AbZEASKF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 14:10:05 -0400
X-Greylist: delayed 1645 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 May 2009 14:10:05 EDT
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:42729)
	by ppsw-1.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.151]:25)
	with esmtpa (EXTERNAL:fanf2) id 1Lzwkw-0001SA-5b (Exim 4.70)
	(return-path <fanf2@hermes.cam.ac.uk>); Fri, 01 May 2009 18:42:38 +0100
Received: from fanf2 (helo=localhost) by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1Lzwkw-0001Id-NO (Exim 4.67)
	(return-path <fanf2@hermes.cam.ac.uk>); Fri, 01 May 2009 18:42:38 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <8663gllt88.fsf@broadpark.no>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118084>

On Thu, 30 Apr 2009, Kjetil Barvik wrote:
>
>   I admit that I am not particular familar with intel machine
>   instructions, but I guess that the above 10 mov instructions is the
>   result for the compiled inline hashcpy() in the write_sha1_file()
>   function in sha1_file.c
>
>   Question: would it be possible for the compiler to compile it down to
>   just 5 mov instructions if we had used unsigned 32 bits type?

No, because the x86 can't do direct memory-to-memory moves.

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
GERMAN BIGHT HUMBER: SOUTHWEST 5 TO 7. MODERATE OR ROUGH. SQUALLY SHOWERS.
MODERATE OR GOOD.
