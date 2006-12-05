X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-explain
Date: Tue, 5 Dec 2006 09:58:25 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612050950450.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200612031701.15594.alan@chandlerfamily.org.uk>
 <Pine.LNX.4.64.0612031024480.3476@woody.osdl.org> <7v1wngwws6.fsf@assigned-by-dhcp.cox.net>
 <7vwt57j94c.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612042253250.2630@xanadu.home>
 <20061205035721.GA26735@fieldses.org> <7v1wnekh6a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 5 Dec 2006 08:58:40 +0000 (UTC)
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v1wnekh6a.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33320>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrW8G-00064z-22 for gcvg-git@gmane.org; Tue, 05 Dec
 2006 09:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968116AbWLEI63 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 03:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968110AbWLEI63
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 03:58:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:57330 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S968116AbWLEI62
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 03:58:28 -0500
Received: (qmail invoked by alias); 05 Dec 2006 08:58:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp037) with SMTP; 05 Dec 2006 09:58:26 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Mon, 4 Dec 2006, Junio C Hamano wrote:

> "J. Bruce Fields" <bfields@fieldses.org> writes:
> 
> > On Mon, Dec 04, 2006 at 10:55:49PM -0500, Nicolas Pitre wrote:
> >> ...
> >> > [PATCH] git-explain
> >> > ...
> >> 
> >> What about calling it git-whatsup instead?
> >
> > No, clearly it should be git-wtf.
> 
> Should I take these responses to mean that you two are negative
> about the approach [...]

I think they just were in the mood for some slashdot style 
unimportant-aspects-in-a-funny-way discussion.

> An issue with this approach is that this can be the beginning of
> hardwiring the official "right way of doing things" in the set
> of tools.  Pursuing this approach would enhance the set of state
> markers like "FAILED_MERGE" in the example, which means:
> 
>  - more commands would actively record what they were attempting
>    to do, obviously;

... which is a good thing.

>  - over time "git explain" will learn about these state markers,
>    and we would hardwire the "best current practice" exits from
>    various states in the help messages;

... which is also a good thing.

>  - also commands other than "git explain" would learn about the
>    state markers of other commands, and change their behaviour.
>    For example, "git am" might learn to refuse running while a
>    merge in progress much earlier than with the current
>    implementation.

If the other commands are outside of git, it will be a problem.

> The last point [git-am refusing to run during a merge] can easily become 
> a double-edged sword.

This particular behaviour seems like a good thing, too!

> Hardwiring the recommended workflow in the tools would reduce chances of 
> mistakes, but it could rob the flexibility from them if we are not 
> careful and forget to take into account some useful combination of tools 
> when adding such safety valves.

As has been the case not at all long ago, a saftey valve which no longer 
made sense was just removed.

As for the inflexibility of a recommended workflow: by now, long-time 
gitsters have had enough time to fiddle around with git and to develop a 
workflow which Just Works. It is just a nice gesture of old-time users 
towards new-time users to pass that knowledge. And new-time users are 
often not in the least interested in learning the ropes the hard way.

Besides, the recommended workflow(s) can be changed/replaced by other 
porcelainish commands, because only those will contain the safety valves, 
right?

Ciao,
Dscho
