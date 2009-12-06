From: Sergio <sergio.callegari@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.6.5.5
Date: Sun, 6 Dec 2009 13:47:43 +0000 (UTC)
Message-ID: <loom.20091206T143330-71@post.gmane.org>
References: <7vtyw4il13.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 06 14:48:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHHTA-0000Ly-2w
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 14:48:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473AbZLFNsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 08:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753001AbZLFNsA
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 08:48:00 -0500
Received: from lo.gmane.org ([80.91.229.12]:38367 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752816AbZLFNr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 08:47:59 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NHHT3-0000HZ-Ao
	for git@vger.kernel.org; Sun, 06 Dec 2009 14:48:05 +0100
Received: from host44-54-dynamic.20-87-r.retail.telecomitalia.it ([87.20.54.44])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 06 Dec 2009 14:48:05 +0100
Received: from sergio.callegari by host44-54-dynamic.20-87-r.retail.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 06 Dec 2009 14:48:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.20.54.44 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091109 Ubuntu/9.10 (karmic) Firefox/3.5.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134661>

>  * In configuration files, a few variables that name paths can begin with
>    ~/ and ~username/ and they are expanded as expected.  This is not a
>    bugfix but 1.6.6 will have this and without backporting users cannot
>    easily use the same ~/.gitconfig across versions.

Sorry if posting as a reply to the announcement is improper.
However I am noticing that some kind of shell-like expansion is now allowed in
the config file, wrt home directories, and my wish is somehow related to it.

I wonder if it could be possible in future releases to expand also $HOSTNAME in
fetch/push specs.

The use case is the following. Working on more than one machine (e.g. a
laptop A and a desktop B) you might need to periodically push to a server C and
like to share the same config on both machines. Having $HOSTNAME expansion,
whatever machine you push from, you can say git push C and have the branches go
on remote/A or remote/B automatically on the server.

Sergio
