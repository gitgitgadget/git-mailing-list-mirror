From: Chris Velevitch <chris.velevitch@gmail.com>
Subject: Eclipse Plugin install issue
Date: Sat, 7 Feb 2009 02:17:29 +1100
Message-ID: <b0a3bf780902060717l653cc6dcx385aa147f606a520@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 16:19:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVSTw-0000fy-C7
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 16:19:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310AbZBFPRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 10:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752254AbZBFPRc
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 10:17:32 -0500
Received: from rv-out-0506.google.com ([209.85.198.228]:48636 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbZBFPRc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 10:17:32 -0500
Received: by rv-out-0506.google.com with SMTP id k40so831814rvb.1
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 07:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=XTTZu10Yd99gagdx6+GLs49mKaDxs2nCdD9TDGB5qKM=;
        b=mtsdGR6Dy0EenVfipaedFTR79olKHywMqV4eKiIsxGGvB2L1Ezw1naXUFjDvjCqqx2
         Ij/0ItZZSBr/dbmuwbmzDZtd0rqOEOGS0T2Vf7u67qhvqVAaWkCj7033v9rqTeK8oxEa
         TFYMsPt04IWZyJ2hqrvOOkEtzsC4AyLJiSAco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=hO7ucKesxrBElCceD2K7sJbTWWa+WGxYxaWbAbYH65BP1u2gXSZfTbsF7sxtePdRqw
         giat2p+kqnZz4fqILkKychU2YvVNQOLoa8uG4uzklfnUPVPPxCbuKkN1pKZlTcwmFD++
         YVsxXjitWijzGP6GfMvJap1ZXqzk+a1hjBdmY=
Received: by 10.141.53.4 with SMTP id f4mr881453rvk.155.1233933449575; Fri, 06 
	Feb 2009 07:17:29 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108726>

I've pointed the Eclipse update manager to
http://www.jgit.org/update-site and when try to install it, it get:-

Cannot complete the request.  See the details.
Cannot find a solution satisfying the following requirements
Match[requiredCapability:
org.eclipse.equinox.p2.iu/org.spearce.egit.feature.group/[0.4.0.200901290136,0.4.0.200901290136]].

in the log I see:-

!ENTRY org.eclipse.equinox.p2.ui 4 10005 2009-02-07 01:55:41.561
!MESSAGE Cannot complete the request.  See the details.
!SUBENTRY 1 org.eclipse.equinox.p2.ui 4 10005 2009-02-07 01:55:41.561
!MESSAGE Cannot complete the request.  See the details.
!SUBENTRY 1 org.eclipse.equinox.p2.director 4 1 2009-02-07 01:55:41.561
!MESSAGE Cannot find a solution satisfying the following requirements
Match[requiredCapability:
org.eclipse.equinox.p2.iu/org.spearce.egit.feature.group/[0.4.0.200901290136,0.4.0.200901290136]].

The instructions didn't say there were any prerequisites.

Where do I find these?

Using running Eclipse 3.4.1 on Intel Mac OSX Leopard with JRE 1.5.0_16-b06-284


Chris
--
Chris Velevitch
Manager - Adobe Platform Users Group, Sydney
m: 0415 469 095
www.apugs.org.au

Adobe Platform Users Group, Sydney
Feb '09 meeting: TBA
Date: Mon 23rd Feb January 6pm for 6:30 start
Details and RSVP coming soon
