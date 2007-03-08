From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Git building is borked
Date: Thu, 8 Mar 2007 10:29:25 +0000
Message-ID: <F0177878-0A2B-43B0-9838-E032FB3A0A58@cam.ac.uk>
References: <4BBB354C-B000-4EF7-B3FF-7B2A4D6DE538@cam.ac.uk>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 11:29:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPFsc-0002mf-Ux
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 11:29:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbXCHK3s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 05:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbXCHK3s
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 05:29:48 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:37852 "EHLO
	ppsw-9.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbXCHK3r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 05:29:47 -0500
X-Greylist: delayed 503 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Mar 2007 05:29:47 EST
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from pcuxsup2.csi.cam.ac.uk ([131.111.10.66]:49580)
	by ppsw-9.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:587)
	with esmtpsa (PLAIN:aia21) (TLSv1:AES128-SHA:128)
	id 1HPFsE-0008Ot-Uc (Exim 4.63)
	(return-path <aia21@cam.ac.uk>); Thu, 08 Mar 2007 10:29:26 +0000
In-Reply-To: <4BBB354C-B000-4EF7-B3FF-7B2A4D6DE538@cam.ac.uk>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41736>

It is even worse...

Having commented out all mentions of "git-gui" from the main git  
Makefile, I was able to run make and "sudo make install" succesfully  
and now I appear to have a working git.  (-:

But now I put the git-gui mentions back into the Makefile and tried  
again it still fails.  Looking at it closer it actually requires me  
to compile within a checked out git tree, i.e. including the .git  
directory and all its contents!  That seems even weirder than  
requiring git to be installed in the first place...

Best regards,

	Anton

On 8 Mar 2007, at 10:21, Anton Altaparmakov wrote:

> Hi,
>
> I am trying to build git on my Mac Book Pro running OSX Tiger  
> 10.4.8 and I have run into a problem...
>
> [snip lots of successful output]
> make -C git-gui all
> GITGUI_VERSION = 0.6.GITGUI
>     GEN CREDITS-FILE
> error: Cannot locate authorship information.
> make[1]: *** [CREDITS-FILE] Error 1
> make: *** [all] Error 2
>
> Looking at the CREDITS-GEN script it runs git for all sorts of evil  
> purposes thus it appears that in order to build and install git one  
> has to already got installed git!
>
> That seems terminally flawed/broken to me...
>
> So how do I get git installed in the first place on my OSX box?!?
>
> Best regards,
>
> 	Anton

-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
