From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 23 Apr 2007 19:25:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704231924410.8822@racer.site>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net> 
 <7vr6qlxexe.fsf@assigned-by-dhcp.cox.net>  <7v647tcjr6.fsf@assigned-by-dhcp.cox.net>
  <7vejmdq63w.fsf@assigned-by-dhcp.cox.net>  <7v647ninbq.fsf@assigned-by-dhcp.cox.net>
 <81b0412b0704231007i81ee20cx9a37f1c8a3df62b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 19:25:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg2IU-0008AQ-Fx
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 19:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbXDWRZv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 13:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161113AbXDWRZv
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 13:25:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:53428 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161095AbXDWRZu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 13:25:50 -0400
Received: (qmail invoked by alias); 23 Apr 2007 17:25:49 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp049) with SMTP; 23 Apr 2007 19:25:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19VsPpHYGRVDM4LhzGShJVewe4D424/JE5jvjJMEd
	3I1umHWvVL+2EE
X-X-Sender: gene099@racer.site
In-Reply-To: <81b0412b0704231007i81ee20cx9a37f1c8a3df62b1@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45340>

Hi,

On Mon, 23 Apr 2007, Alex Riesen wrote:

> On 4/23/07, Junio C Hamano <junkio@cox.net> wrote:
> > * jc/attr (Sat Apr 21 03:14:13 2007 -0700) 2 commits
> >  - Add 'filter' attribute and external filter driver definition.
> >  - Add 'ident' conversion.
> >
> > As 'ident' conversion is stateless, I do not mind too much
> > including it in v1.5.2-rc1.  On the other hand, the arbitrary
> > 'filter' is quite contentious, although the character-code
> > conversion example I gave myself might be a good enough reason
> > for people to want it.  Undecided.
> 
> Can I suggest a config option to completely disable content
> munging code? So that people who really care about the
> real content, or just don't have the tools for the filters still
> can checkout the repos depending on the filters.

In my worldview, these filters are a local thing. Exactly like crlf. So, 
no need for a config option.

Ciao,
Dscho
