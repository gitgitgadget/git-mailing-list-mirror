From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: RFC - "git editlog" feature for fixing up local commit messages
Date: Mon, 29 Mar 2010 11:08:21 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003291102250.694@xanadu.home>
References: <20100329133132.GA12201@thyrsus.com>
 <fabb9a1e1003290641s27306373k3a2669318a7b67a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_nZwI8FlKsIkxHeTjRAD5Uw)"
Cc: esr@thyrsus.com, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 17:08:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwGZp-0006Ve-AI
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 17:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338Ab0C2PIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 11:08:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:20779 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328Ab0C2PIW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 11:08:22 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L01003M4U1X7NB0@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 29 Mar 2010 11:08:22 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <fabb9a1e1003290641s27306373k3a2669318a7b67a8@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143480>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_nZwI8FlKsIkxHeTjRAD5Uw)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Mon, 29 Mar 2010, Sverre Rabbelier wrote:

> Heya,
> 
> On Mon, Mar 29, 2010 at 07:31, Eric Raymond <esr@thyrsus.com> wrote:
> > Now, about step 3.  The official git command set only directly supports
> > amending the tip commit.  There is a semi-documented procedure for
> > amending previous commits using an interactive rebase, but trying to
> > understand it makes my brain hurt.  Don't want to go there.
> 
> Go there anyway. These days it's as simple as changing "pick" to
> "reword" on the appropriate commit. Really, give it a try.

While the 'git rebase -i' solution has its place (and I do use it 
myself), it essentially deals with only one branch while having a 
filter-branch based solution allows for such changes to be applied 
globally i.e. to all branches in the presence of history fork points.


Nicolas

--Boundary_(ID_nZwI8FlKsIkxHeTjRAD5Uw)--
