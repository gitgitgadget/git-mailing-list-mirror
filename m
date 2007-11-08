From: Andy Whitcroft <apw@shadowen.org>
Subject: git push mirror mode
Date: Thu, 8 Nov 2007 12:11:36 +0000
Message-ID: <20071108121136.GG9736@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 08 13:11:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq6Ea-0006d5-92
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 13:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755927AbXKHMLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 07:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757536AbXKHMLa
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 07:11:30 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:1515 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704AbXKHML3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 07:11:29 -0500
Received: from localhost ([127.0.0.1] helo=pinky)
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1Iq6EJ-0002yF-5Q
	for git@vger.kernel.org; Thu, 08 Nov 2007 12:11:27 +0000
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Received-SPF: pass
X-SPF-Guess: pass
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64000>

Ok, sometime back Junio sent out a proof-of-concept change to
send-pack allowing a mirror mode.  That patch seemed to interact
badly dropping refs in the .git directorty and I did not have time
to fix it up.

I've just rebased it to the latest next, and updated my follow up patch
to make this available as 'git push --mirror <remote>'.  I have only
tested this lightly.

-apw
