From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Sun, 18 Feb 2007 02:29:17 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702180226480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net> <7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
 <20070217232603.GB30839@coredump.intra.peff.net>
 <Pine.LNX.4.63.0702180105000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v64a0qpa8.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702180151060.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vhctkp8gk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 18 02:29:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIarj-0005kr-6l
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 02:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965540AbXBRB3U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 20:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965545AbXBRB3U
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 20:29:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:45088 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965540AbXBRB3T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 20:29:19 -0500
Received: (qmail invoked by alias); 18 Feb 2007 01:29:18 -0000
X-Provags-ID: V01U2FsdGVkX1/5aa00JX/5Xc1abCgwPz8ircTaahDfpefnYg8r8n
	klzg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vhctkp8gk.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40048>

Hi,

On Sat, 17 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > And I use git-apply to apply patches way more often than "patch" these 
> > days. And I _think_ that it is a feature that it does not cd-up before 
> > trying to apply the stuff. In git.git, I cannot think of a reasonable use 
> > case for applying something not relative-to-root, but I had that use case 
> > in some other (git-tracked) project.
> >
> > So my vote is to leave the cwd where it is in git-apply.
> 
> I strongly disagree from my recent day-job experience. [Explains a 
> convincing use case in favour of cd-up.]

Hmm. I have to think about that. But a consequence of what you suggest 
would be to disallow git-apply outside of a repository, because then you 
would introduce _another_ inconsistency (git-apply without --index would 
behave differently when inside a repo than when outside of one).

Ciao,
Dscho
