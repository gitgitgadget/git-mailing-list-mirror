From: CPD <cdavidson@altsoftware.com>
Subject: Can you do this with GIT?
Date: Fri, 27 Jul 2007 11:02:37 -0700 (PDT)
Message-ID: <11834063.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 27 20:02:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEU9D-0005Nl-Dm
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 20:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860AbXG0SCj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 14:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752932AbXG0SCj
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 14:02:39 -0400
Received: from kuber.nabble.com ([216.139.236.158]:59281 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400AbXG0SCi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 14:02:38 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1IEU97-0006sD-Ip
	for git@vger.kernel.org; Fri, 27 Jul 2007 11:02:37 -0700
X-Nabble-From: cdavidson@altsoftware.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53937>


Hi All,

I hope this is the right forum, it's all I could find. Sincere apologies in
advance if I in the wrong place.

I set up a source control system for the company around CVS, but GIT has
some very attractive features and I'd like to migrate if it can do some
other things that we need.

We produce variations based on a (mostly) common codebase. In CVS I set up
"environment" modules for each platform, then when you are working on that
platform, you simply check out the correct environment and build. Only the
needed code and tools are exposed in that environment (this is important as
clients must NOT see each other's code and most customers have some
customization). I do this by defining and renaming modules in the CVSROOT
modules file.

Does GIT support anything like this? Or another way to acheive the same end?

Thanks muchly, in advance, Colin
-- 
View this message in context: http://www.nabble.com/Can-you-do-this-with-GIT--tf4159350.html#a11834063
Sent from the git mailing list archive at Nabble.com.
