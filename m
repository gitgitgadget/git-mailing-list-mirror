From: Matthew Cline <matt@nightrealms.com>
Subject: git-commit feature request: pass editor command line options
Date: Tue, 13 Oct 2009 21:58:51 -0700 (PDT)
Message-ID: <25885354.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 07:04:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxw2P-0003iP-2o
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 07:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbZJNE72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 00:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752224AbZJNE72
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 00:59:28 -0400
Received: from kuber.nabble.com ([216.139.236.158]:53897 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbZJNE71 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 00:59:27 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1Mxvwp-0006FT-Bi
	for git@vger.kernel.org; Tue, 13 Oct 2009 21:58:51 -0700
X-Nabble-From: matt@nightrealms.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130244>


I'd like to be able to have git-commit pass the commit-message editor command
line options which aren't passed to the editor for other usages.  Right now
I have "co" aliased to "!sh -c 'GIT_EDITOR=git-commit-editor git commit'",
where git-commit-editor is a wrapper around my editor-of-choice which passes
the editor the command line options I want, but it'd be simpler and cleaner
if I could just set "commit.editor_options=-BAR".  Or even let there be a
separate editor for commits, so I could do "core.editor=foo" and
"commit.editor=foo -BAR".
-- 
View this message in context: http://www.nabble.com/git-commit-feature-request%3A-pass-editor-command-line-options-tp25885354p25885354.html
Sent from the git mailing list archive at Nabble.com.
