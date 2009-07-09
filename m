From: David Reitter <david.reitter@gmail.com>
Subject: Re: New Bzr to Git migration tool
Date: Thu, 9 Jul 2009 13:36:13 -0400
Message-ID: <37B936CB-2B2F-49DB-B282-EAD6C87E9A63@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1068)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Henrik Nilsson <henrik30000@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 09 19:44:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOxfH-0008Ni-Pn
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 19:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753772AbZGIRoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 13:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753587AbZGIRoE
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 13:44:04 -0400
Received: from mail-px0-f193.google.com ([209.85.216.193]:61221 "EHLO
	mail-px0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613AbZGIRoD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 13:44:03 -0400
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jul 2009 13:44:03 EDT
Received: by pxi31 with SMTP id 31so213056pxi.33
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 10:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:content-type
         :content-transfer-encoding:subject:date:message-id:to:mime-version
         :x-mailer;
        bh=O0CUofw+u082fUe6mfyODUvpE9h+OC/KHkghdbJajSk=;
        b=wYKRBJi2W/m2ax4bwTXYyQSjrnvvyNztLGeG1RP1AlT4fLmZyWfIhr7BWcd/959PfD
         qRroj+GsMbk5ttm0biuK1Drw6qeZ/nd+C1RsQC3Wf3fCefS647IZa/3RqRX95LsZdL4l
         ROKiTuKNPzkg7b8gEprLS0yZqDu96G4FTWz1U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        b=xdcek5JffGf40BFXDoH6ENLu1IluWgZ1Y2PnUe+u4wASA04NqKEEu9FHj9ERv2eUcJ
         LBAiIJ0kydKEN4kp3/yopL5rGlFd2CHk22XPxQmSrKMAExAXD3DN6jjL7xmU+IvnIEUU
         esz8g2UR3n1SbqPkDAXtw/3LiMG/c9u3amdQQ=
Received: by 10.114.255.12 with SMTP id c12mr1607609wai.11.1247160978207;
        Thu, 09 Jul 2009 10:36:18 -0700 (PDT)
Received: from scarlett.psy.cmu.edu (SCARLETT.PSY.CMU.EDU [128.2.249.106])
        by mx.google.com with ESMTPS id k21sm115581waf.24.2009.07.09.10.36.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Jul 2009 10:36:17 -0700 (PDT)
X-Mailer: Apple Mail (2.1068)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122997>

Henrik Nilsson wrote on git@vger.kernel.org:

> I recently wrote a Bzr to Git migration tool and thought I'd share it
> with anyone who might be interested.
> It's written in shell-script and iterates through the Bzr commits
> while adding those changes to a new Git repository.

This is interesting to me, as my use case will involve extending an  
existing git repository iteratively from the bzr commits.
Looking at the technique, this should be possible that way.

I am missing support for converting all branches of the repository.   
More importantly, don't merges get lost?  All your git side commits  
seem to have a single parent.
