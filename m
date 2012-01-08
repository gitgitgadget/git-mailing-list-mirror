From: Abscissa <bus_nabble_git@semitwist.com>
Subject: Re: SVN -> Git *but* with special changes
Date: Sun, 8 Jan 2012 15:38:30 -0800 (PST)
Message-ID: <1326065910362-7166084.post@n2.nabble.com>
References: <1317227849979-6840904.post@n2.nabble.com> <20110928190445.GC1482@sigill.intra.peff.net> <1325999031923-7163706.post@n2.nabble.com> <20120108051051.GA10129@sigill.intra.peff.net> <1325999865995-7163737.post@n2.nabble.com> <1326000327637-7163752.post@n2.nabble.com> <20120108103303.GC2714@centaur.lab.cmartin.tk> <m2hb06mpwn.fsf@linux-m68k.org> <20120108120807.GA7360@angband.pl> <1326061722334-7165979.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 00:38:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rk2Jx-0007I3-5Z
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 00:38:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762Ab2AHXic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 18:38:32 -0500
Received: from sam.nabble.com ([216.139.236.26]:60891 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754748Ab2AHXic (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 18:38:32 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <bus_nabble_git@semitwist.com>)
	id 1Rk2Jq-0000sZ-Bw
	for git@vger.kernel.org; Sun, 08 Jan 2012 15:38:30 -0800
In-Reply-To: <1326061722334-7165979.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188151>

Damn. That 'git-svn-migrate' tool is just giving me errors now. It just gets
through little over 10% of the revisions, and gives:

-----------------------------
Failed to strip path 'bin/lang/.gitignore' ((?-xism:^trunk(/|$)))

- Converting svn:ignore properties into a .gitignore file...
fatal: ambiguous argument 'HEAD': unknown revision or path not in the
working tree.
Use '--' to separate paths from revisions
log --no-color --no-decorate --first-parent --pretty=medium HEAD: command
returned error: 128
-----------------------------

And then it keeps going and gives:

-----------------------------
To /var/git/Goldie.git
 ! [rejected]        master -> trunk (non-fast-forward)
error: failed to push some refs to '/var/git/Goldie.git'
To prevent you from losing history, non-fast-forward updates were rejected
-----------------------------

I guess I'll have to try some other approach. :/


--
View this message in context: http://git.661346.n2.nabble.com/SVN-Git-but-with-special-changes-tp6840904p7166084.html
Sent from the git mailing list archive at Nabble.com.
