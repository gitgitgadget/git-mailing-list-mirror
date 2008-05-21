From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git gui: Possible to see which commands are executed?
Date: Wed, 21 May 2008 09:30:39 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805210930150.30431@racer>
References: <48301B17.30309@dirk.my1.cc> <20080519022125.GV29038@spearce.org> <4833206E.1080300@dirk.my1.cc> <20080520194403.GC29038@spearce.org> <bd6139dc0805201305k61807561k8026b4c6509e4041@mail.gmail.com> <20080520201722.GF29038@spearce.org>
 <bd6139dc0805201322r6c8dae8cy45d31af6c25fd25a@mail.gmail.com> <20080520203153.GH29038@spearce.org> <7v3aoc8xtg.fsf@gitster.siamese.dyndns.org> <20080521024126.GI29038@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, sverre@rabbelier.nl,
	=?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed May 21 10:31:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyjjL-0004Xr-Ex
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 10:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757624AbYEUIag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 04:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757449AbYEUIae
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 04:30:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:50280 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756074AbYEUIac (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 04:30:32 -0400
Received: (qmail invoked by alias); 21 May 2008 08:30:30 -0000
Received: from R1e9a.r.pppool.de (EHLO racer.local) [89.54.30.154]
  by mail.gmx.net (mp054) with SMTP; 21 May 2008 10:30:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+DDC4APcaDBDgH9vXrv/RYdv/5zPy6v3arWUCzSQ
	38ujdzwkBRGBli
X-X-Sender: gene099@racer
In-Reply-To: <20080521024126.GI29038@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82536>

Hi,

On Tue, 20 May 2008, Shawn O. Pearce wrote:

> Junio C Hamano <gitster@pobox.com> wrote:
> > > Sverre Rabbelier <alturin@gmail.com> wrote:
> > >> 
> > >> Ah, I didn't realise git-gui does stuff that you can't really do
> > >> through the regular porcelain. In that case it would indeed be
> > >> impossible to print the regular porcelain commands. I think the
> > >> '--trace' option should be advertised as 'debugging option' so that
> > >> the user can see what is going on in the case something goes wrong
> > >> perhaps?
> > 
> > Probably --trace should be renamed to --debug then?
> 
> Well, we do have GIT_TRACE, and git-gui --trace is sort of the
> same idea.  :-)

Which brings me to the suggestion to reuse GIT_TRACE instead of adding 
an option...

Ciao,
Dscho
