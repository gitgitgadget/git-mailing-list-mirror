From: Alex Vandiver <alex@chmrr.net>
Subject: Re: [PATCH] Make git config fail on variables with no section, as documented
Date: Sun, 26 Jul 2009 16:24:37 -0400
Message-ID: <1248637797-sup-6595@utwig>
References: <1248474081-sup-2762@utwig> <1248625102-472-1-git-send-email-alex@chmrr.net> <alpine.DEB.1.00.0907261849110.8306@pacific.mpi-cbg.de> <1248636518-sup-7499@utwig> <alpine.DEB.1.00.0907262146530.8306@pacific.mpi-cbg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 26 22:24:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVAH1-0002WF-27
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 22:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218AbZGZUYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 16:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753207AbZGZUYh
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 16:24:37 -0400
Received: from chmrr.net ([209.67.253.66]:57776 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752917AbZGZUYh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 16:24:37 -0400
Received: from chmrr by utwig.chmrr.net with local (Exim 4.69)
	(envelope-from <chmrr@chmrr.net>)
	id 1MVAGr-0005y9-Lu; Sun, 26 Jul 2009 16:24:37 -0400
In-reply-to: <alpine.DEB.1.00.0907262146530.8306@pacific.mpi-cbg.de>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124137>

At Sun Jul 26 15:48:20 -0400 2009, Johannes Schindelin wrote:
> That, together with the fact that "git config -f <file>" was meant 
> _explicitely_ to allow 3rd party porcelains having their own config files 
> without having to implement their own "git config" lets me suspect that 
> we'd rather want the current behavior.

*shrug* Note I'm not wholly convinced of the rationale myself -- I'm
merely trying to reconcile the documentation and reality.  I'll also
note that you can't, at current, set or unset such values from the
command-line.

Looking back at the blame for the documentation, it looks like e136f33
in 2007 is what added the claim that section-less variables weren't
acceptable.  The `git repo-config` of the time parsed them just fine,
however.

If you wish to correct the documentation instead, I can send in a doc
patch.  Fixing --set and --unset to work with section-less variables
will take a bit more work, however.
 - Alex
-- 
Networking -- only one letter away from not working
