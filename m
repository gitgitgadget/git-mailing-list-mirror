X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 15:17:19 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612141507200.18171@xanadu.home>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
 <200612140959.19209.andyparkins@gmail.com>
 <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net>
 <200612141136.59041.andyparkins@gmail.com> <20061214114546.GI1747@spearce.org>
 <8764ce6654.wl%cworth@cworth.org> <20061214120518.GL1747@spearce.org>
 <Pine.LNX.4.64.0612141251520.18171@xanadu.home>
 <7vy7pa45m8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 14 Dec 2006 20:17:47 +0000 (UTC)
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7vy7pa45m8.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34391>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gux1Q-0000ms-Py for gcvg-git@gmane.org; Thu, 14 Dec
 2006 21:17:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932777AbWLNURW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 15:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932784AbWLNURW
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 15:17:22 -0500
Received: from relais.videotron.ca ([24.201.245.36]:45628 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932781AbWLNURV (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 15:17:21 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JAA008ZE5OVUHR0@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Thu,
 14 Dec 2006 15:17:20 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Thu, 14 Dec 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > I'd say screw that.  The solution should really be this patch:
> >
> > diff --git a/environment.c b/environment.c
> > index 84d870c..98275b2 100644
> > --- a/environment.c
> > +++ b/environment.c
> > @@ -15,7 +15,7 @@ int use_legacy_headers = 1;
> >  int trust_executable_bit = 1;
> >  int assume_unchanged;
> >  int prefer_symlink_refs;
> > -int log_all_ref_updates;
> > +int log_all_ref_updates = 1;
> >  int warn_ambiguous_refs = 1;
> >  int repository_format_version;
> >  char git_commit_encoding[MAX_ENCODING_LENGTH] = "utf-8";
> >
> 
> That changes what the command does to existing repositories,
> which is somewhat impolite.

You must be kidding, aren't you?

Just in case you really are serious, let's pretend that being impolite 
for something that has the potential of saving people's arses is 
certainly worth it, much more that the little inconvenience of having 
log files mysteriously appear and make no harm otherwise.

> I am not opposed too much to an updated version of the tool that
> sets the configuration on by default for newly created
> repositories, though.

Hmmm....

Well it is just that I strongly believe users with existing repos have 
no really valid reason to not have this feature enabled.  But making it 
on in a default config file at repo creation time is better than 
nothing.


