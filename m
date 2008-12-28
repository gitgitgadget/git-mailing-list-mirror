From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: getting started, happy with cmd line on windows [Scanned]
Date: Sun, 28 Dec 2008 13:39:48 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0812281326300.19665@iabervon.org>
References: <BB5F02FD3789B54E8964D38D6775E718242D07@ALTMORE-SVR.altmore.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Conor Rafferty <conor.rafferty@altmore.co.uk>
X-From: git-owner@vger.kernel.org Sun Dec 28 19:41:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LH0Zb-0002ZD-Dr
	for gcvg-git-2@gmane.org; Sun, 28 Dec 2008 19:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041AbYL1Sju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Dec 2008 13:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753966AbYL1Sju
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Dec 2008 13:39:50 -0500
Received: from iabervon.org ([66.92.72.58]:52197 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753509AbYL1Sjt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Dec 2008 13:39:49 -0500
Received: (qmail 10055 invoked by uid 1000); 28 Dec 2008 18:39:48 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Dec 2008 18:39:48 -0000
In-Reply-To: <BB5F02FD3789B54E8964D38D6775E718242D07@ALTMORE-SVR.altmore.local>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104056>

On Fri, 26 Dec 2008, Conor Rafferty wrote:

> We want to use git to
> a) archive old versions of our project that have till now had no SCM
> applied

There's actually an importer for this; if you can put all of the old 
versions into tar files in the same format and list them in order, you can 
use "import-tars.perl", which is in contrib/fast-import in the git source 
tree. Of course, using that won't teach you anything about the tools, but 
it might be the best way to get the real import done with the least chance 
of mistakes.

	-Daniel
*This .sig left intentionally blank*
