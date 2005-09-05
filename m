From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: git/cogito suggestion: tags with descriptions
Date: Mon, 5 Sep 2005 14:24:31 -0700
Message-ID: <20050905212431.GB14720@tumblerings.org>
References: <20050905184551.GA14720@tumblerings.org> <7vd5nn49uz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 23:26:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECOSF-0005f4-Px
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 23:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbVIEVYh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 17:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbVIEVYh
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 17:24:37 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:34198 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S932573AbVIEVYg
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2005 17:24:36 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.52)
	id 1ECOS7-0000sl-GZ; Mon, 05 Sep 2005 14:24:31 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5nn49uz.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8118>

Hi Junio!

On Mon, Sep 05, 2005 at 12:01:40PM -0700, Junio C Hamano wrote:
> Zack Brown <zbrown@tumblerings.org> writes:
> 
> > It would be great if tags also allowed a brief description to go along with
> > them, that would show up in cg-tag-ls. Then I could seek to a tag that's just
> > an easy-to-type version number, and still have an idea of what's significant
> > about that version because of the descriptive text.
> 
> Would 'git tag -a' work for you?
> 
> : siamese; git tag -a -m 'This is to just demonstrate.' test-for-brown
> : siamese; git cat-file tag test-for-brown
> object 0516de30e8bdd26086e2a3edd3375981fd0c34d6
> type commit
> tag test-for-brown
> tagger Junio C Hamano <junkio@cox.net> 1125946805 -0700
> 
> This is to just demonstrate.
> : siamese; 

I'm not sure. I'm not as familiar with the low-level git commands as I am with
cogito. But cogito has a -d option for giving a tag description. I guess what
would be closest to what I was thinking about would be this:

$ cg-tag -d "First draft, everything in place." 0.3 7540e503b9b9c1b03e44ee7fd700c844b2a02224
$ cg-tag-ls
0.1     Initial idea complete                 f953b71b21a0bea682c2bed91362f2dce2cc204f
0.3     First draft, everything in place.     7540e503b9b9c1b03e44ee7fd700c844b2a02224 
$

or something like that. Currently when I do the above cg-tag command,
a subsequent cg-tag-ls gives just:

$ cg-tag-ls
0.1     f953b71b21a0bea682c2bed91362f2dce2cc204f
0.3     7540e503b9b9c1b03e44ee7fd700c844b2a02224

In fact, I probably wouldn't even be interested in seeing the actual hash key
unless I gave a special flag, maybe -f (for "full"):

$ cg-tag-ls
0.1     Initial idea complete
0.3     First draft, everything in place.
$ cg-tag-ls -f
0.1     Initial idea complete                 f953b71b21a0bea682c2bed91362f2dce2cc204f
0.3     First draft, everything in place.     7540e503b9b9c1b03e44ee7fd700c844b2a02224
$

> 
> BTW, when will the next issue of GIT traffic appear ;-)?

Honestly, I don't know. I seem to be having my hands full just trying to
keep Kernel Traffic up-to-date (just caught up today, finally). I really did
the first Git Traffic to kind of spread the word about how mind-blowing the
whole git development process was.

But whether I'll keep on doing it, I don't know. Between Kernel Traffic,
my day job, and a few non-Linux projects, I may have my hands full.

On the other hand, if someone wanted to volunteer to write Git Traffic, I'd
be happy to help them get started. I don't mean you, but perhaps a regular
reader of this list would be interested. It seems like there's at least some
interest in seeing it continue. :-)

Be well,
Zack

> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Zack Brown
