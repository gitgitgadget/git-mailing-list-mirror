From: Pavel Sanda <ps@twin.jikos.cz>
Subject: git commands for 3rd-party commit/update hooks
Date: Thu, 11 Sep 2008 03:22:47 +0200
Message-ID: <20080911012247.GB11362@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 03:30:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdb0y-00023c-0G
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 03:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbYIKBXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 21:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752223AbYIKBXS
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 21:23:18 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38583 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbYIKBXS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 21:23:18 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 4054)
	id 2A423F0B8E; Thu, 11 Sep 2008 03:23:17 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95572>

hi,
please can you help me to figure out, whether the following task can
be accomplished by git?

imagine that:
1. user configures rcs in two different modes:
a) working in private
b) sharing work via some public repo

2. after configuration all rcs communication goes through some 3rd
   party tool which API knows only commit and update(/merge) hooks.

all docs on git i have seen divide the workflow into the local part
eg. git commit and the sharing part eg. git pull/push.

is it somehow doable with git that after appropriate setup i will
get single git command for each commiting/updating operation
regardless of 1a or 1b scenario? something which can be stuffed
into that 3rd-party as external commands for rcs commit/update while
keeping it oblivious whether the work is stored locally or on some 
remote place.

thanks,
pavel
