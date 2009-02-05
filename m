From: Robert Haines <rhaines@manchester.ac.uk>
Subject: How to use git-fmt-merge-msg?
Date: Thu, 5 Feb 2009 12:31:57 +0000
Message-ID: <84B3CCAA-A044-4517-B2C8-14D5DD754FD2@manchester.ac.uk>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 05 13:55:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV3lH-00056z-0Z
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 13:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203AbZBEMxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 07:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753006AbZBEMxx
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 07:53:53 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:53116 "EHLO
	probity.mcc.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674AbZBEMxw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 07:53:52 -0500
X-Greylist: delayed 1313 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Feb 2009 07:53:51 EST
Received: from kelvin.its.manchester.ac.uk ([130.88.25.195])
	by probity.mcc.ac.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <rhaines@manchester.ac.uk>)
	id 1LV3Of-000KoW-FM; Thu, 05 Feb 2009 12:31:57 +0000
Received: from leela.rcs.manchester.ac.uk ([130.88.1.66]:57536)
	by kelvin.its.manchester.ac.uk with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <rhaines@manchester.ac.uk>)
	id 1LV3Of-0005vP-Bt; Thu, 05 Feb 2009 12:31:57 +0000
X-Mailer: Apple Mail (2.930.3)
X-Authenticated-Sender: Robert Haines from leela.rcs.manchester.ac.uk [130.88.1.66]:57536
X-Authenticated-From: Robert.Haines@manchester.ac.uk
X-UoM: Scanned by the University Mail System. See http://www.itservices.manchester.ac.uk/email/filtering/information/ for details.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108554>

Hi all,

I would like to use git-fmt-merge-msg to produce automatic summaries  
of what commits are being merged when I merge one branch into the  
other - like I see all the time in git.git, etc. The problem I am  
having is that I can only seem to get it to work with remote branches  
via .git/FETCH_HEAD - basically I don't know what else I can feed it  
to do what I want.

Say I have a local repo with no remotes so no .git/FETCH_HEAD. Can I  
use git-fmt-merge-msg to produce such a summary when I'm just merging  
local branches? I've tried feeding just about everything I can find  
in .git/ into it but with no luck. Is there anything generated during  
the merge that can be used as input if I do a merge --no-commit? A  
list of merged commits or something?

I'm sure I've missed something simple here... Alternatively, am I just  
barking up the wrong tree?

Thanks,
Rob

-- 
Robert Haines

Research Associate, RealityGrid          Tel. : +44 (0)161 275 6067
Research Computing Services              Fax. : +44 (0)161 275 0637
University of Manchester                 Email: rhaines@manchester.ac.uk
Oxford Road                              Web  : www.realitygrid.org
Manchester, M13 9PL                           : www.rcs.manchester.ac.uk
