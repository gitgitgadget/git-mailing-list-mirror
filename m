From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] shortlog: add option to group together different
 names/emails of an author
Date: Mon, 19 Jan 2009 15:29:56 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901191528280.3586@pacific.mpi-cbg.de>
References: <1231600589-11811-1-git-send-email-dato@net.com.org.es> <20090119134346.GA27509@chistera.yi.org> <alpine.DEB.1.00.0901191445340.3586@pacific.mpi-cbg.de> <20090119141107.GA27992@chistera.yi.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-343764411-1232375396=:3586"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Adeodato_Sim=F3?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Mon Jan 19 15:31:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOv9o-0004AG-ND
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 15:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893AbZASO3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 09:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbZASO3z
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 09:29:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:47780 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751180AbZASO3y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 09:29:54 -0500
Received: (qmail invoked by alias); 19 Jan 2009 14:29:52 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp019) with SMTP; 19 Jan 2009 15:29:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/bQywEv1Hbs8hHGeK2I8EAGai2LXfJ++F0GzbAvb
	EeDoJs92SWSvYT
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090119141107.GA27992@chistera.yi.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106361>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-343764411-1232375396=:3586
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 19 Jan 2009, Adeodato Simó wrote:

> * Johannes Schindelin [Mon, 19 Jan 2009 14:49:39 +0100]:
> 
> > > Ping? I realize this may be seen as a big patch dropped out of the blue,
> > > but I would very much like to hear some comments on at least the feature
> > > itself, which should not take more than reading the commit message.
> 
> > And you could just as well write a script that takes the output of
> 
> > 	$ git log --pretty=format:%an\ %ae --all | sort | uniq
> 
> > and constructs a valid .mailmap.  That would also have the advantage that 
> > you do not need to perform the analysis each time you call Git.
> 
> No, not really. As mentioned in the commit message, .mailmap files don't 
> help when you invoke shortlog with -e, and different email addresses for 
> an author are involved.

Well, the whole point of -e is that you want to see the email addresses, 
too.  So I am not really convinced it would be a good idea to mangle them.

But hey, I only expressed a personal opinion; If you can convince others, 
you still might bring that feature in.  You'll have to convince them, 
though.

Ciao,
Dscho

--8323328-343764411-1232375396=:3586--
