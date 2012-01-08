From: Abscissa <bus_nabble_git@semitwist.com>
Subject: Re: SVN -> Git *but* with special changes
Date: Sat, 7 Jan 2012 21:03:51 -0800 (PST)
Message-ID: <1325999031923-7163706.post@n2.nabble.com>
References: <1317227849979-6840904.post@n2.nabble.com> <20110928190445.GC1482@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 06:04:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rjkvc-0004K5-Ua
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 06:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067Ab2AHFDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 00:03:55 -0500
Received: from sam.nabble.com ([216.139.236.26]:57564 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750698Ab2AHFDy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 00:03:54 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <bus_nabble_git@semitwist.com>)
	id 1Rjkv9-0005tr-U2
	for git@vger.kernel.org; Sat, 07 Jan 2012 21:03:51 -0800
In-Reply-To: <20110928190445.GC1482@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188091>

>If you import with
>git-svn, it supports "--preserve-empty-dirs", which will do this for you
>automatically. 

I came across this, and it seems to mostly work:
http://john.albin.net/git/git-svn-migrate

Except it fails to do the "--preserve-empty-dirs". It does say that it
passes any options it doesn't recognize directly to git-svn, so I gave it
that, but just got:

- Cloning repository...
Unknown option: preserve-empty-dirs

Now, I realize this isn't a forum for that particular "git-svn-migrate"
tool, and I don't expect anyone to go digging though it on my account, so
I'm willing to try to add it into the script if I can just find out the
proper way to use "--preserve-empty-dirs".

However, I suspect that script may not be my problem at all: If I do this:

git svn help | grep preserve

I get absolutely nothing. There doesn't seem to be a
"--preserve-empty-dirs".


--
View this message in context: http://git.661346.n2.nabble.com/SVN-Git-but-with-special-changes-tp6840904p7163706.html
Sent from the git mailing list archive at Nabble.com.
