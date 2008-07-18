From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Suggestion: doc restructuring [was: Re: Considering teaching plumbing
 to users harmful]
Date: Fri, 18 Jul 2008 12:14:27 +0200
Message-ID: <48806D03.30603@fastmail.fm>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 12:15:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJn01-0000cT-4F
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 12:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262AbYGRKOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 06:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752976AbYGRKOl
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 06:14:41 -0400
Received: from main.gmane.org ([80.91.229.2]:60511 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821AbYGRKOk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 06:14:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KJmyx-0005wW-Ns
	for git@vger.kernel.org; Fri, 18 Jul 2008 10:14:35 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 10:14:35 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 10:14:35 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <alpine.DEB.1.00.0807161804400.8950@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89026>

Johannes Schindelin venit, vidit, dixit 16.07.2008 19:21:
...
> 
> Am I the only one who deems teaching plumbing to users ("I like it raw!  
> So I teach it the same way!") harmful?
> 
> Ciao,
> Dscho "who is sad"

In an attempt at making not only Dscho happier I suggest a restructuring 
of the man pages in the following way:

In each man page, put a note which says something like:
"This is part of linkgit:gitplumbing[7]." and the like
It should be in a prominent place, such as the last line of "DESCRIPTION".

gitplumbing[7] etc. pages should contain:
- a definition of the respective term together with appropriate usage 
advice (regular use/scripting..., "Let there be dragons.")
- a list of commands like we have in git[1] right now

With the current situation, people don't look at git[1] in order to find 
out what they're supposed to use. It's too long anyways, and could link 
the above pages instead.

If there's enough interest/agreement I'd come up with a refactoring patch.

Michael


P.S.: For me
porcellaine = artistic, fragile
plumbing = plain, robust
Which one would you choose for daily hard work? ;)
