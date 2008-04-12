From: Santiago Gala <sgala@apache.org>
Subject: Re: git annoyances
Date: Sat, 12 Apr 2008 18:59:45 +0000 (UTC)
Message-ID: <loom.20080412T184726-395@post.gmane.org>
References: <20080409101428.GA2637@elte.hu> <20080409145758.GB20874@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 21:00:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jkkxs-0005ZN-0A
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 21:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895AbYDLS74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 14:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753836AbYDLS74
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 14:59:56 -0400
Received: from main.gmane.org ([80.91.229.2]:33168 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753459AbYDLS7z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 14:59:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Jkkx7-0001UR-RK
	for git@vger.kernel.org; Sat, 12 Apr 2008 18:59:53 +0000
Received: from 233.Red-81-33-31.staticIP.rima-tde.net ([81.33.31.233])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 Apr 2008 18:59:53 +0000
Received: from sgala by 233.Red-81-33-31.staticIP.rima-tde.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 Apr 2008 18:59:53 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 81.33.31.233 (Mozilla/5.0 (X11; U; Linux x86_64; es-ES; rv:1.8.1.13) Gecko/20080327 Firefox/2.0.0.13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79376>

Jeff King <peff <at> peff.net> writes:

(...)
> Unless you are planning on merging this remote a lot, the common usage
> is probably to just forget the remote stuff and do:
> 
>   git pull ~/linux-2.6-x86.git latest
> 

Well, he wants to *merge*, not really to *pull*. A problem I'm encountering a
lot with git is this kind of mismatch between the naming of the command and the
actions. Most of the time the things make sense when they are explained, but
they are not intuitive and I forget them once and again.

I have special problems with "pull" and "fetch". I mean, for me "pull" is about
"pulling code" from other repo, but not really to the working copy, or at least
not always to the working copy.

In fact, the first line of git-pull --help is "Fetch from and merge with another
repository or a local" (pulling together the other two words, fetch and merge,
if you allow the pun). For my very limited git intuition, and I guess for a lot
of people too, pull is just "fetch".
