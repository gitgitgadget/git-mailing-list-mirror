From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: Re: backwards compatibility, was Re: [PATCH v1 1/3] Introduce config
 variable "diff.primer"
Date: Mon, 26 Jan 2009 19:01:33 -0800 (PST)
Message-ID: <alpine.GSO.2.00.0901261749230.16158@kiwi.cs.ucla.edu>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu> <1232904657-31831-2-git-send-email-keith@cs.ucla.edu> <7v1vurf7lq.fsf@gitster.siamese.dyndns.org> <alpine.GSO.2.00.0901251345240.12651@kiwi.cs.ucla.edu> <20090126031206.GB14277@sigill.intra.peff.net>
 <alpine.DEB.1.00.0901261154330.14855@racer> <20090126111605.GB19993@coredump.intra.peff.net> <alpine.DEB.1.00.0901261220300.14855@racer> <20090126115957.GA20558@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 27 04:03:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LReEF-0007i3-JE
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 04:03:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbZA0DBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 22:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752241AbZA0DBm
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 22:01:42 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:64619 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977AbZA0DBl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 22:01:41 -0500
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n0R31Ygm023241;
	Mon, 26 Jan 2009 19:01:34 -0800 (PST)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n0R31Yl3023238;
	Mon, 26 Jan 2009 19:01:34 -0800 (PST)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <20090126115957.GA20558@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107301>

On Mon, 26 Jan 2009, Jeff King wrote:

> Yep, that's what defaults are. And guess what: we _already_ have the same 
> thing. I have diff.renames set in my ~/.gitconfig. That does _exactly_ what
> 
>   git config --global diff.primer -M
> 
> would do. It's just a syntax that saves us from having to introduce a boatload 
> of new variables, one per command line option.


Great point, IOW, primer magnifies already existing pitfalls.  I like that about 
primer v1, however unsatisfying it is otherwise.  Rather than stick a piece of 
chewing gum in that chink in the dam, let's repair it and get the whole darn 
thing ready for the 21st century while we're at it.

> However, there are two other drawbacks of aliases that I can think of:
>   1. They are tied to a specific command, whereas diff options are tied
>      to the concept of diffing. So now I have to write an alias (with a
>      new name) for each command:
>        git config alias.mylog 'log -w'
>        git config alias.mydiff 'diff -w'
>        git config alias.myshow 'show -w'
>   2. They can't change defaults based on the file to be diffed. One of
>      the things Keith mentioned (and I don't remember if this was
>      implemented in his patch series) was supporting this for
>      gitattributes diff drivers. How do I do
>        git config diff.tex.primer -w
>      using aliases?

This scenario was specifically part of my motivation for imagining primer v1 as 
I did.

> But now you have me defending Keith's proposal

And well.

> which he should be doing himself ;P

True.  I'm at the point here where I will demand of myself one of two outcomes.  
Either I:

(1) Satisfy myself on a deep, foundational level why the inescapable structure 
of not just this particularly well-constituted software project (Git!), but 
software projects in general, since surely many a fearless development team has 
braved this philosophical sticky place before us, prevents one from getting 
everything one wants, i.e. forces a compromise, a.k.a. the "no silver bullet" 
interpretation.

(2) Write primer patch v2 that somehow does THE RIGHT THING, also satisfying on 
a deep level to at least myself, a.k.a. the silver bullet.

                                            -- Keith
