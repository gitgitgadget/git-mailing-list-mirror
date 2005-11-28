From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC 2/2] Automatically transform .git/{branches,remotes} into .git/config
Date: Mon, 28 Nov 2005 14:59:15 +0100
Message-ID: <20051128135915.GR22159@pasky.or.cz>
References: <Pine.LNX.4.63.0511211455120.13775@wbgn013.biozentrum.uni-wuerzburg.de> <20051127125945.GD22159@pasky.or.cz> <Pine.LNX.4.63.0511280248020.12343@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 14:59:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgjXU-0003zZ-Ik
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 14:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbVK1N7D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 08:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVK1N7D
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 08:59:03 -0500
Received: from w241.dkm.cz ([62.24.88.241]:43996 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751114AbVK1N7B (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 08:59:01 -0500
Received: (qmail 5118 invoked by uid 2001); 28 Nov 2005 14:59:15 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511280248020.12343@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12880>

Dear diary, on Mon, Nov 28, 2005 at 02:52:08AM CET, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> On Sun, 27 Nov 2005, Petr Baudis wrote:
> 
> > I've tried to explain that branches and remotes are different concepts,
> 
> Well, no. They aren't. The "branches" concept is a proper special case of 
> the "remotes" concept.

Yes, but precisely what I want to do is to avoid (most of) the "added
value" of the remotes concept, if you will. Also, it really is a
different namespace than branches (while branches share the same
namespace with heads); I can try to make the namespaces match, but when
they suddenly won't, you are in big mess.

> But what the heck, I don't care what you eventually use.
> 
> I only realized that we -- in the good tradition of UNIX -- have many 
> different formats for different configurations: Some configurations are in 
> .gitignore, some are in .git/branches/, some in .git/remotes/, some in 
> .git/config, and even some in environment variables!
> 
> If everybody says that this should stay so, I'll just shut up.

As I said, I don't care much if this moves to the git configuration
file, but please don't merge it with the remotes.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
