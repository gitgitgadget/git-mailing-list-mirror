From: Petr Baudis <pasky@suse.cz>
Subject: Re: latest stg/git commandline completions code
Date: Thu, 10 Nov 2005 10:40:13 +0100
Message-ID: <20051110094013.GM30496@pasky.or.cz>
References: <Pine.LNX.4.60.0510251222510.8565@mundungus.clifford.ac> <200510251642.46169.blaisorblade@yahoo.it> <A44A02AA-BDA8-4623-825E-288F1107A5ED@hawaga.org.uk> <20051109222338.GK16061@pasky.or.cz> <CDEAA4E3-54FE-4825-BFCF-DCE34DBD138A@hawaga.org.uk> <Pine.LNX.4.60.0510251222510.8565@mundungus.clifford.ac> <200510251642.46169.blaisorblade@yahoo.it> <A44A02AA-BDA8-4623-825E-288F1107A5ED@hawaga.org.uk> <20051109222338.GK16061@pasky.or.cz> <33CE6BA8-415D-405F-89B3-982811C3A0CF@hawaga.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Blaisorblade <blaisorblade@yahoo.it>,
	Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
X-From: git-owner@vger.kernel.org Thu Nov 10 10:41:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ea8uy-0007cx-HT
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 10:40:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVKJJkR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 04:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbVKJJkR
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 04:40:17 -0500
Received: from w241.dkm.cz ([62.24.88.241]:46270 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750727AbVKJJkP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 04:40:15 -0500
Received: (qmail 12112 invoked by uid 2001); 10 Nov 2005 10:40:13 +0100
To: Ben Clifford <benc@hawaga.org.uk>
Content-Disposition: inline
In-Reply-To: <CDEAA4E3-54FE-4825-BFCF-DCE34DBD138A@hawaga.org.uk> <33CE6BA8-415D-405F-89B3-982811C3A0CF@hawaga.org.uk>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11473>

Dear diary, on Thu, Nov 10, 2005 at 02:59:09AM CET, I got a letter
where Ben Clifford <benc@hawaga.org.uk> said that...
> There are a few small common functions that are used by all the git  
> completions, though. I suppose for going into cogito's contrib/ I  
> should include them directly in cogito completion code, but that  
> seems a little messy, as it would be nice to keep them in-sync with  
> what is used in the other completion files. hmm.

Then could you please separate those from the git completion to some
kind of 'library'?

Dear diary, on Thu, Nov 10, 2005 at 07:57:34AM CET, I got a letter
where Ben Clifford <benc@hawaga.org.uk> said that...
> On 10 Nov 2005, at 09:23, Petr Baudis wrote:
> >Besides, it would be probably best to just autogenerate the
> >auto-completion code - the usage information in Cogito is supposed  
> >to be
> >100% consistent and correct, so it should be a reliable source for  
> >that.
> 
> Maybe reliable and consistent but I think that info would need a bit  
> of augmentation to use for specifying autocompletion - for example,  
> in the case of:
> 
> > Usage: cg-branch-add BRANCH_NAME LOCATION
> 
> BRANCH_NAME should *not* exist so it doesn't make sense to  
> autocomplete from the branch list, but in the case of:

When you do

	cat > <tab><tab>

bash happily autocompletes as well. I don't think this is a problem,
besides it can be useful when you want to use some existing branch name,
just slightly modified.

> The amount of augmentation is probably not too much -  probably  
> sufficient  to specify for each parameter a completion-source(s)  
> (heads, branches, filenames, blah) that doesn't get displayed in -- 
> help. But this is more information to maintain and get out of date...

It's enough if we auto-build the completion and complain loudly and
error out when we hit something unknown.

> (I confess to having pretty much no idea how zsh completion works...)

Me neither. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
