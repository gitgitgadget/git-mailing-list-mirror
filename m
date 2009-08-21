From: Daniel Convissor <danielc@analysisandsolutions.com>
Subject: hitting home directory's parent
Date: Fri, 21 Aug 2009 16:05:04 -0400
Message-ID: <20090821200503.GA19660@panix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 21 22:26:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeahE-0003Ac-UI
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 22:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbZHUU0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 16:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbZHUU0Y
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 16:26:24 -0400
Received: from l2mail1.panix.com ([166.84.1.75]:63695 "EHLO l2mail1.panix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932390AbZHUU0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 16:26:24 -0400
X-Greylist: delayed 1281 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Aug 2009 16:26:24 EDT
Received: from mail2.panix.com (mail2.panix.com [166.84.1.73])
	by l2mail1.panix.com (Postfix) with ESMTP id 7F00192F
	for <git@vger.kernel.org>; Fri, 21 Aug 2009 16:06:37 -0400 (EDT)
Received: from panix5.panix.com (panix5.panix.com [166.84.1.5])
	by mail2.panix.com (Postfix) with ESMTP id 56E8C38E53
	for <git@vger.kernel.org>; Fri, 21 Aug 2009 16:05:04 -0400 (EDT)
Received: by panix5.panix.com (Postfix, from userid 14662)
	id 3BE7324201; Fri, 21 Aug 2009 16:05:04 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126750>

Hi:

I just installed git in my Cygwin installation for the first time.  The 
git version is 1.6.1.2, which is the latest version they have.  When I 
enter one of the following commands:
    git --help
    git config --global user.name "Daniel Convissor"

I get this error:
    fatal: Cannot change to /home/danielc/..: Permission denied

Though "git --version" executes fine.

I've been using Cygwin for many years and no other program has ever 
produced this issue for me.  For example, svn --help, ls --help, etc work 
just fine.

Why is git venturing into to the home directory's parent directory?  Is 
this a bug?  If not, is this really necessary?

Thanks,

--Dan

PS:  I'm not subscribed to the list.

-- 
 T H E   A N A L Y S I S   A N D   S O L U T I O N S   C O M P A N Y
            data intensive web and database programming
                http://www.AnalysisAndSolutions.com/
 4015 7th Ave #4, Brooklyn NY 11232  v: 718-854-0335 f: 718-854-0409
