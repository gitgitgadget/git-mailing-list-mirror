From: slinky <slinky@iki.fi>
Subject: Re: Git performance results on a large repository
Date: Sat, 4 Feb 2012 08:57:33 +0000 (UTC)
Message-ID: <loom.20120204T094226-583@post.gmane.org>
References: <CB5074CF.3AD7A%joshua.redstone@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 10:10:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rtbdu-0004hV-Uf
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 10:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239Ab2BDJK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 04:10:29 -0500
Received: from plane.gmane.org ([80.91.229.3]:59905 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753226Ab2BDJKH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 04:10:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RtbdD-0004Om-H7
	for git@vger.kernel.org; Sat, 04 Feb 2012 10:10:03 +0100
Received: from h-20-68.a259.priv.bahnhof.se ([79.136.20.68])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 10:10:03 +0100
Received: from slinky by h-20-68.a259.priv.bahnhof.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 10:10:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 79.136.20.68 (Mozilla/5.0 (Ubuntu; X11; Linux x86_64; rv:9.0.1) Gecko/20100101 Firefox/9.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189861>

Joshua Redstone <joshua.redstone <at> fb.com> writes:

> The git performance we observed here is too slow for our needs.  So the
> question becomes, if we want to keep using git going forward, what's the
> best way to improve performance.  It seems clear we'll probably need some
> specialized servers (e.g., to perform git-blame quickly) and maybe
> specialized file system integration to detect what files have changed in a
> working tree.

Hi Joshua,

sounds like you have everything in a single .git. Split up the massive
repository to separate smaller .git repositories.

For example, Android code base is quite big. They use the repo tool to manage a
number of separate .git repositories as one big aggregate "repository".

Cheers,
Slinky
