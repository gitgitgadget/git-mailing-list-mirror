X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's in git.git (stable)
Date: Fri, 15 Dec 2006 11:08:28 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612151106580.18171@xanadu.home>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
 <200612140959.19209.andyparkins@gmail.com>
 <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net>
 <200612141136.59041.andyparkins@gmail.com> <eluemi$gc0$1@sea.gmane.org>
 <Pine.LNX.4.64.0612151029080.18171@xanadu.home> <4582C3CE.3000902@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 15 Dec 2006 16:08:33 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <4582C3CE.3000902@op5.se>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34529>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvFbs-0007dA-9b for gcvg-git@gmane.org; Fri, 15 Dec
 2006 17:08:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752795AbWLOQIa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 11:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752796AbWLOQIa
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 11:08:30 -0500
Received: from relais.videotron.ca ([24.201.245.36]:25343 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752795AbWLOQI3 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 11:08:29 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JAB00J99OU418D0@VL-MO-MR004.ip.videotron.ca> for git@vger.kernel.org; Fri,
 15 Dec 2006 11:08:28 -0500 (EST)
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

On Fri, 15 Dec 2006, Andreas Ericsson wrote:

> Nicolas Pitre wrote:
> > On Fri, 15 Dec 2006, Jakub Narebski wrote:
> > 
> > > It would be nice to have some generic place in git config to specify
> > > default options to git commands (at least for interactive shell). It
> > > cannot be done using aliases. Perhaps defaults.<command> config variable?
> > 
> > I would say the alias facility has to be fixed then.
> > 
> > In bash you can alias "ls" to "ls -l" and it just works.
> > 
> 
> I think this is because git scripts that need a certain git command to work a
> certain way don't want some alias to kick in and destroy things for them.
> Shell-scripts would have the same problem if you alias "awk" to "grep" f.e.,
> which is why prudent shell-scripters use the "unalias -a" thing.

Wouldn't it be possible for aliases to be effective only when issued 
from an interactive shell?  It is certainly true that aliases just make 
no sense in a script.


