From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: .gitignore, .gitattributes, .gitmodules, .gitprecious?, .gitacls?
 etc.
Date: Mon, 27 Aug 2007 12:30:26 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708271226360.28586@racer.site>
References: <2646CA4BEA644C9E9089C4A1AC395250@ntdev.corp.microsoft.com>
 <7v1wdqud0z.fsf@gitster.siamese.dyndns.org> <52E107D8068148B795FB4279B6272B8E@ntdev.corp.microsoft.com>
 <7vsl66svv4.fsf@gitster.siamese.dyndns.org> <C22431BFCD8E403FA10C8E91DE8AC19A@ntdev.corp.microsoft.com>
 <7vhcmmpxed.fsf@gitster.siamese.dyndns.org> <B4A2AE9980774365B5D14B442A7A22F6@ntdev.corp.microsoft.com>
 <46D23C48.6060904@vilain.net> <85ps19a5hm.fsf@lola.goethe.zz>
 <46D2ADF6.70100@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Mon Aug 27 13:28:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPclZ-0006eC-Bo
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 13:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356AbXH0L2S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 07:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754479AbXH0L2S
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 07:28:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:38713 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754300AbXH0L2R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 07:28:17 -0400
Received: (qmail invoked by alias); 27 Aug 2007 11:28:16 -0000
Received: from ppp-82-135-74-69.dynamic.mnet-online.de (EHLO [192.168.1.4]) [82.135.74.69]
  by mail.gmx.net (mp050) with SMTP; 27 Aug 2007 13:28:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18161dtbxk1/7WG1ka59KfrbT8ru0/pjKgst1KHF2
	acDUSSlnsGv0cu
X-X-Sender: gene099@racer.site
In-Reply-To: <46D2ADF6.70100@vilain.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56817>

Hi,

On Mon, 27 Aug 2007, Sam Vilain wrote:

> David Kastrup wrote:
> >> These files which store metadata would be stored in a way that is
> >> "in another dimension" to the project files, despite being a part of
> >> the history.  That means that all tools built to deal with regular
> >> files and directories will not be able to merge the changes to the
> >> attributes without special support.  I think this is broken.
> >>     
> >
> > That presumes that a good way to merge attributes is to use a text
> > file merge algorithm, complete with finding diff context lines in a
> > basically unchanged order.
> >   
> 
> Yes.  Is that not a reasonable assumption, in the absence of anything
> more enlightened?

Umm.

It is not about _text_ file merge algorithms, but algorithms _outside of 
git_!

If you tuck the stuff away in some obscure database where it is hard to 
access, you make it more complicated and time consuming to access the data 
than it needs to be to _begin with_.

> >> As far as file properties goes, I still like Linus' idea of making 
> >> these files which are accessed by treating the file as a directory 
> >> (eg filename.txt/ACL, filename.txt/mime-type), and that approach 
> >> could be represented in git well.
> >
> > Well, at least _some_ interesting Reiser4 idea resurfaces.
> 
> That was in there too?  Man that Reiser4 manifesto read like the Naked 
> Lunch.

It is funny.  No, I mean really funny.  People criticise Reiser4, and only 
preciously few actually have ideas as good as in Reiser4.  Yes, Reiser4 
was not developed as openly as it should have been.  Yes, Hans was not the 
most diplomatic poster ever, on lkml.  No, even the stupid ideas in 
Reiser4 are not half as stupid as mistaking the working tree for a place 
where only _text_ files reside.

Ciao,
Dscho
