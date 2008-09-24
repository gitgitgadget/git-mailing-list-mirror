From: Tom Schutzer-Weissmann <tom.weissmann@siscog.pt>
Subject: Applying changes across divergent branches
Date: Wed, 24 Sep 2008 15:40:14 +0100
Message-ID: <48DA514E.6060904@siscog.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 24 16:47:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiVdM-0006hu-7H
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 16:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbYIXOpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 10:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbYIXOpS
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 10:45:18 -0400
Received: from mail2.siscog.pt ([195.22.30.41]:34261 "EHLO mail2.siscog.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751337AbYIXOpR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 10:45:17 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Sep 2008 10:45:17 EDT
Received: from [194.100.100.174] ([::ffff:194.100.100.174])
  (AUTH: LOGIN trmsw)
  by mail2.siscog.pt with esmtp; Wed, 24 Sep 2008 15:40:15 +0100
  id 000A5FC4.48DA514F.0000254A
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96639>

Hello all,

I am looking into how to apply git to some current working methods.

We tend to have two or three main branches: the development branch, and 
one or two product branches. The development branch is the cutting edge, 
and each product branches off from it.

While the product branch shares history with the development branch, not 
all changes to the development branch will get applied to the product 
branch. We tend to maintain two versions of a product at any time, 
meaning two divergent product branches.

Could we use git, or a tool based on git, to change on the development 
branch and selectively apply changes to the other branches - is it as 
simple as using git cherry-pick?

Thanks in advance,
Tom SW
