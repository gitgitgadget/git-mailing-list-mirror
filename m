X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] make 'git add' a first class user friendly interface to
 the index
Date: Fri, 01 Dec 2006 21:01:04 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612012056420.9647@xanadu.home>
References: <Pine.LNX.4.64.0612011444310.9647@xanadu.home>
 <7vpsb36yem.fsf@assigned-by-dhcp.cox.net>
 <200612020018.32672.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sat, 2 Dec 2006 02:01:34 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <200612020018.32672.alan@chandlerfamily.org.uk>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32997>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqKBr-0000Cs-7W for gcvg-git@gmane.org; Sat, 02 Dec
 2006 03:01:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162716AbWLBCBG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 21:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162717AbWLBCBG
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 21:01:06 -0500
Received: from relais.videotron.ca ([24.201.245.36]:46668 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1162716AbWLBCBF
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 21:01:05 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9M006VRIXSFI70@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Fri,
 01 Dec 2006 21:01:04 -0500 (EST)
To: Alan Chandler <alan@chandlerfamily.org.uk>
Sender: git-owner@vger.kernel.org

On Sat, 2 Dec 2006, Alan Chandler wrote:

> On Friday 01 December 2006 22:31, Junio C Hamano wrote:
> > Nicolas Pitre <nico@cam.org> writes:
> ...
> >
> > > +Contrary to other SCMs, with GIT you have to explicitly "add" all the
> > > +changed file content you want to commit together to form a changeset
> > > +with the 'add' command before using the 'commit' command.
> >
> > ... "before a new commit is made"; it is not an offence to leave
> > local changes outside the index.  Staging such changes to all
> > files is done using the "-a" flag and that is done "before a new
> > commit is made", but not "before using the 'commit' command" --
> > it is done at the same time.

Bleamphfff...  Nah.  There is certainly another way to formulate that.

> How about
> 
> Contrary to other SCM's, with GIT you have to explicitly "add" the content 
> that you want to commit before it is made; it is not an offence to leave 

Before what is made?

> changes outside the index if you want to leave them to a later commit.  
> However if you do want all changes from your working tree to be added to the 
> commit before it is made use the "-a" flag with the commit command and the 
> content will be added just before the commit is made.

Nah.  Too many concepts in the same paragraph.


