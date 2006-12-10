X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Documentation/git-commit: rewrite to make it more end-user
 friendly.
Date: Sat, 09 Dec 2006 19:51:09 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612091941230.2630@xanadu.home>
References: <7vy7pik51b.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0612082141260.2630@xanadu.home>
 <7vd56tei20.fsf_-_@assigned-by-dhcp.cox.net>
 <200612100130.48812.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sun, 10 Dec 2006 00:51:20 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	"J. Bruce Fields" <bfields@fieldses.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <200612100130.48812.Josef.Weidendorfer@gmx.de>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33858>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtCuR-0005xc-76 for gcvg-git@gmane.org; Sun, 10 Dec
 2006 01:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758846AbWLJAvL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 19:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758875AbWLJAvL
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 19:51:11 -0500
Received: from relais.videotron.ca ([24.201.245.36]:25287 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1758846AbWLJAvK (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006
 19:51:10 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JA1003UL919RK50@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Sat,
 09 Dec 2006 19:51:09 -0500 (EST)
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

On Sun, 10 Dec 2006, Josef Weidendorfer wrote:

> Very nice.
> 
> On Saturday 09 December 2006 06:48, Junio C Hamano wrote:
> >  DESCRIPTION
> >  -----------
> > -Updates the index file for given paths, or all modified files if
> > -'-a' is specified, and makes a commit object.  The command specified
> > -by either the VISUAL or EDITOR environment variables are used to edit
> > -the commit log message.
> > +Use 'git commit' when you want to record your changes into the repository
> > +along with a log message describing what the commit is about. All changes
> > +to be committed must be explicitly identified using one of the following
> 
> What about: "... must be explicitly identified (that is,
> must be "staged") ..."
> 
> This way, it will be clear for the reader that "to explicitly identify" is the
> same thing as "to stage", which is used quite often later.

Hmmm, maybe, maybe not.  Although I don't have particular problem with 
"staging area", I'm still unconvinced about the verb "stage".

> > +methods:
> >  
> > -Several environment variable are used during commits.  They are
> > -documented in gitlink:git-commit-tree[1].
> > +1. by using gitlink:git-add[1] to incrementally "add" changes to the
> > +   next commit before using the 'commit' command (Note: even modified
> > +   files must be "added");
> 
> Regarding this note: Of course unmodified files do not have to be added ;-)
> 
> What about: "(Note: changes in files already known to git, and even new
> changes done after a previous `git add` for a given file, still must
> be staged again)" 

This is getting too long for what it is worth in this case IMHO.


