From: A Braunsdorf <ab@purdue.edu>
Subject: Perl parts not installed in correct location
Date: Wed, 17 Jun 2009 17:07:47 -0400
Message-ID: <20090617210747.9E4AE1E75F61@ode.ics.purdue.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 23:18:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MH2WH-0001dI-DH
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 23:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbZFQVSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 17:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752260AbZFQVR7
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 17:17:59 -0400
Received: from ode.ics.purdue.edu ([128.210.91.104]:52171 "EHLO
	ode.ics.purdue.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbZFQVR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 17:17:58 -0400
X-Greylist: delayed 613 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jun 2009 17:17:58 EDT
Received: from ode.ics.purdue.edu (localhost [127.0.0.1])
	by ode.ics.purdue.edu (Postfix) with ESMTP id 9E4AE1E75F61
	for <git@vger.kernel.org>; Wed, 17 Jun 2009 17:07:47 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121775>


Doing a make install put the Perl parts of git in a directory that
is >not< in @INC for my copy of Perl.  That's wrong.  If you're not
going to ask Perl for the right place to put it, at least make it
a configure option. :-(

ab
