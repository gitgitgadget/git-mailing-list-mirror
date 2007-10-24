From: Michel Marti <mma@objectxp.com>
Subject: Feature request: Limit git-status reports to a directory
Date: Thu, 25 Oct 2007 00:01:26 +0200
Message-ID: <ffofbm$lmc$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 00:06:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkoMc-0006q0-DI
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 00:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757760AbXJXWFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 18:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757494AbXJXWFS
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 18:05:18 -0400
Received: from main.gmane.org ([80.91.229.2]:36067 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760896AbXJXWFO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 18:05:14 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IkoLW-0001Db-F9
	for git@vger.kernel.org; Wed, 24 Oct 2007 22:05:02 +0000
Received: from 84-73-13-217.dclient.hispeed.ch ([84.73.13.217])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Oct 2007 22:05:02 +0000
Received: from mma by 84-73-13-217.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Oct 2007 22:05:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 84-73-13-217.dclient.hispeed.ch
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62246>

I am sometimes interested in only seeing the status for a specific 
directory (and its sub-directories), but git-status is no help in this 
case - passing a directory does some sort of "git-commit --dry-run". I 
first thought that this is a bug until I saw in the man-page that this 
is actually a feature...

What I would like to have is something like "git status --limit <path>" 
and the reported filenames should then be relative to the current 
directory for easier copy/pasting them to e.g. git-add, git-diff, etc.

Cheers,

- Michel
