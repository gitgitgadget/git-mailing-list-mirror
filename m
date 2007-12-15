From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Post-1.5.4 stuff: builtin-checkout
Date: Sat, 15 Dec 2007 15:44:16 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0712151529300.5349@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 15 21:44:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3dsK-0003ha-VY
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 21:44:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757638AbXLOUoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 15:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757927AbXLOUoS
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 15:44:18 -0500
Received: from iabervon.org ([66.92.72.58]:59146 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756445AbXLOUoR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 15:44:17 -0500
Received: (qmail 14259 invoked by uid 1000); 15 Dec 2007 20:44:16 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Dec 2007 20:44:16 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68415>

I've got my builtin-checkout implementation at:

 git://iabervon.org/~barkalow/git.git builtin-checkout

This may be interesting to some other people at this point, despite it not 
being relevant to 1.5.4, because (a) it includes a slew of small 
preliminary patches to other stuff that might be useful for making other 
things builtin and (b) these changes reflect my debugging of my naive 
implementation of builtin-checkout, and may suggest things that might be 
wrong in existing builtins that do multiple operations in the same 
process.

I'll actually send patches to the list post-1.5.4 of all this stuff.

	-Daniel
*This .sig left intentionally blank*
