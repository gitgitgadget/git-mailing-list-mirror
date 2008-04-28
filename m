From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use perl instead of tac
Date: Mon, 28 Apr 2008 14:46:31 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804281444320.5399@eeepc-johanness>
References: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com> <20080427064250.GA5455@sigill.intra.peff.net> <739FA851-F7F5-4CF9-B384-25AA7022B0C2@silverinsanity.com> <slrng1be8l.25r.joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658432-714572824-1209390392=:5399"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Mon Apr 28 15:48:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqThG-0004Jk-M8
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 15:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbYD1NqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 09:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbYD1NqX
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 09:46:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:56020 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1765860AbYD1NqW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 09:46:22 -0400
Received: (qmail invoked by alias); 28 Apr 2008 13:46:20 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.st-andrews.ac.uk) [141.5.11.5]
  by mail.gmx.net (mp055) with SMTP; 28 Apr 2008 15:46:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX198kXNE+y98vQLiGX5fN/T4Po4tPkWcedbamVe80B
	nIOUM+F5raWNMc
X-X-Sender: user@eeepc-johanness
In-Reply-To: <slrng1be8l.25r.joerg@alea.gnuu.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80534>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--658432-714572824-1209390392=:5399
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 28 Apr 2008, Jörg Sommer wrote:

> Brian Gernhardt <benji@silverinsanity.com> wrote:
> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > index 1751b08..303b754 100755
> > --- a/git-rebase--interactive.sh
> > +++ b/git-rebase--interactive.sh
> > @@ -469,7 +469,7 @@ create_extended_todo_list () {
> >   	test -n "${last_parent:-}" -a "${last_parent:-}" != $SHORTUPSTREAM  
> > && \
> >   		echo reset $last_parent
> >   	) | \
> > -	tac | \
> > +	perl -e 'print reverse <>' | \
> 
> What about using a shell function and a *big* variable or an 
> intermediate file?

How about fixing the code to not need tac instead?  We went to great 
lengths to introduce the --reverse option to the rev-list command, in 
order to avoid tac in the original version of rebase -i.

Ciao,
Dscho

--658432-714572824-1209390392=:5399--
