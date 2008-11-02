From: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
Subject: Re: git reset --hard w/o touching every file
Date: Sun, 02 Nov 2008 00:36:09 -0400
Message-ID: <gejanr$os$1@ger.gmane.org>
References: <gegn38$lku$1@ger.gmane.org> <20081101110529.GC3819@artemis.corp> <geicn8$ss8$1@ger.gmane.org> <20081102033313.GB4936@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 02 05:37:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwUiW-00013v-AC
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 05:37:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbYKBEgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 00:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbYKBEgX
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 00:36:23 -0400
Received: from main.gmane.org ([80.91.229.2]:60342 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751672AbYKBEgW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 00:36:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KwUhI-0004WF-OT
	for git@vger.kernel.org; Sun, 02 Nov 2008 04:36:20 +0000
Received: from lily.mit.edu ([18.243.2.157])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Nov 2008 04:36:20 +0000
Received: from edwardzyang by lily.mit.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Nov 2008 04:36:20 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: lily.mit.edu
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20081102033313.GB4936@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99811>

Jeff King wrote:
> Sorry, I don't quite understand. You want to check out some subset of
> files, but you don't know which subset?

Yeah, I should elaborate a little.

I'm using a script to automatically update a website with the contents
of a Git repository at a specified interval. While I could use git pull,
I've been told that it's safer to do a git fetch, and then a git reset
--hard remotes/master, because the former could trigger a merge and on a
live website that is NOT desirable.

Unfortunately, since Git touches all files on a reset --hard, it's
causing problems with the smart cache system, which checks whether or
not the cache file is older than the source file, and regenerating if it is.

Cheers,
Edward
