X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: merge-recursive, was Re: What's in git.git
Date: Thu, 26 Oct 2006 09:23:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610260921550.12418@xanadu.home>
References: <7vk62npipb.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0610261114520.3286@wbgn013.biozentrum.uni-wuerzburg.de>
 <ehputm$ch2$3@sea.gmane.org> <7vlkn3o1w1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 26 Oct 2006 13:23:47 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7vlkn3o1w1.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30213>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd5Cm-0006yY-Nz for gcvg-git@gmane.org; Thu, 26 Oct
 2006 15:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423510AbWJZNXa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 09:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423511AbWJZNX3
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 09:23:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:33639 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1423510AbWJZNX3
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 09:23:29 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J7Q007DOVV48F70@VL-MO-MR002.ip.videotron.ca> for git@vger.kernel.org; Thu,
 26 Oct 2006 09:23:28 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Thu, 26 Oct 2006, Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Johannes Schindelin wrote:
> >
> >> BTW what happened to the builtin shortlog? It is the last Perl script I 
> >> use regularly... (should make people happy who are stuck with Activision 
> >> Perl...)
> >
> > BTW. both Perl version and builtin shorlog have email->real name translation
> > table built in. In Perl script version it is in __DATA__ section, and we
> > could update it using Inline::Files module, in C version it was in table.
> > But in fact this list is project specific. Shouldn't we make it customizable
> > (::sigh::, yet another file in $GIT_DIR...).
> 
> It already reads from .mailmap which could be tracked as part of
> the sources (if it is project specific it would be better if it
> can be shared among members).

The C version was missing that support if I remember right.

Actually I think that the email table should be removed out of the tool 
entirely and always read from .mailmap instead.


