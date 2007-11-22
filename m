From: Jonathan del Strother <maillist@steelskies.com>
Subject: gitk's copy pasteboard doesn't persist after it quits
Date: Thu, 22 Nov 2007 11:44:16 +0000
Message-ID: <DFBFC631-01BF-4D2D-BCF3-3FC376479CB2@steelskies.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 22 12:44:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvAU4-0006cT-3f
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 12:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbXKVLoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 06:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbXKVLoT
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 06:44:19 -0500
Received: from smtp1.betherenow.co.uk ([87.194.0.68]:59216 "EHLO
	smtp1.bethere.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbXKVLoS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 06:44:18 -0500
Received: from [192.168.1.67] (87-194-43-188.bethere.co.uk [87.194.43.188])
	by smtp1.bethere.co.uk (Postfix) with SMTP id 8DFED984D7
	for <git@vger.kernel.org>; Thu, 22 Nov 2007 11:44:16 +0000 (GMT)
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65807>

On OS X, if I load gitk, copy a sha1, then quit, the sha1 isn't put  
into the system-wide pasteboard.  It's definitely copied - I can paste  
it back into the sha1 field - but it seems to be some sort of local  
pasteboard that's specific to gitk

If I switch to another app, the sha1 is stored in the pasteboard  
correctly, and I can then quit gitk and still have it available.  I'm  
guessing that gitk (or Tcl/Tk) is syncing with the system-wide  
pasteboard on focus change, but not on quit.

I'm using the version of gitk in 388afe7881b, and Tcl 8.4.7


Any suggestions on fixing / working around this?

Jon
