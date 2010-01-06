From: Zing <zing@fastmail.fm>
Subject: git pull --all fails (possible options handling bug in git pull?)
Date: Wed, 6 Jan 2010 19:05:44 +0000 (UTC)
Message-ID: <hi2mu8$9ob$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 06 20:10:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSbGr-0002Ep-9G
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 20:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997Ab0AFTKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 14:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752639Ab0AFTKJ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 14:10:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:44226 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752531Ab0AFTKI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 14:10:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NSbGf-0002AC-7c
	for git@vger.kernel.org; Wed, 06 Jan 2010 20:10:05 +0100
Received: from 204.97.104.30 ([204.97.104.30])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Jan 2010 20:10:05 +0100
Received: from zing by 204.97.104.30 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Jan 2010 20:10:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 204.97.104.30
User-Agent: Pan/0.133 (House of Butterflies)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136288>

In 1.6.6, if I do:

$ git pull --all
Fetching origin
Fetching gnome
You asked to pull from the remote '--all', but did not specify
a branch. Because this is not the default configured remote
for your current branch, you must specify a branch on the command line.

The fetch all remotes works, but shouldn't the "--all" option only apply
to the fetch operation?  It looks like it's getting noticed by the merge
part of the pull.
