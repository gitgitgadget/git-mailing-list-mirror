X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Documentation: Define symref and update HEAD description
Date: Sat, 18 Nov 2006 22:31:54 +0100
Message-ID: <20061118213153.GR7201@pasky.or.cz>
References: <20061118194408.27106.65771.stgit@machine.or.cz> <7v64dccyx2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 21:32:04 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v64dccyx2.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31802>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlXn5-0006VJ-Gv for gcvg-git@gmane.org; Sat, 18 Nov
 2006 22:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753698AbWKRVb4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 16:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753660AbWKRVb4
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 16:31:56 -0500
Received: from w241.dkm.cz ([62.24.88.241]:48831 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1753357AbWKRVbz (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 16:31:55 -0500
Received: (qmail 4636 invoked by uid 2001); 18 Nov 2006 22:31:54 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Sat, Nov 18, 2006 at 08:55:37PM CET, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > HEAD was still described as a symlink instead of a symref.
> >...
> >  HEAD::
> > +	A symref (see glossary) to the `refs/heads/` namespace
> > +	describing the currently active branch.  It does not mean
> > +	much if the repository is not associated with any working tree
> >  	(i.e. a 'bare' repository), but a valid git repository
> > +	*must* have the HEAD file; some porcelains may use it to
> > +	guess the designated "default" branch of the repository
> > +	(usually 'master').  It is legal if the named branch
> > +	'name' does not (yet) exist.  In some legacy setups, it is
> > +	a symbolic link instead of a symref, but this has been
> > +	deprecated long ago.
> 
> We fully support dealing with repositories with symlinked HEAD,
> and will continue to do so; I do not think we ever talked about
> deprecating it.  Public "distribution point" repositories that
> have been established long ago that do not have reason to switch
> HEAD to point at different branch still have symlinked HEAD and
> they should continue to work.
> 
> What we _don't_ do these days is to set up new repositories with
> symlinked HEAD, but that does not have anything to do with
> deprecating symlinked HEAD.

That's true, perhaps "obsoleted" is a better word.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
