From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Enumerating all objects in the Git object store
Date: Fri, 26 Mar 2010 16:24:09 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003261621560.694@xanadu.home>
References: <a1138db31003260831q34967f69u9fc8de861f7931b1@mail.gmail.com>
 <4BACD86E.4020803@viscovery.net>
 <alpine.LFD.2.00.1003261324350.694@xanadu.home>
 <201003262111.48298.j.sixt@viscovery.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_bgpqf+If1TxhwMW/lgQ0tQ)"
Cc: Paul Richards <paul.richards@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 26 21:24:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvG54-0005ul-4u
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 21:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492Ab0CZUY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 16:24:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:27111 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446Ab0CZUY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 16:24:28 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KZW005ADOO9WBJ0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 26 Mar 2010 16:24:09 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <201003262111.48298.j.sixt@viscovery.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143282>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_bgpqf+If1TxhwMW/lgQ0tQ)
Content-type: TEXT/PLAIN; charset=iso-8859-1
Content-transfer-encoding: 8BIT

On Fri, 26 Mar 2010, Johannes Sixt wrote:

> On Freitag, 26. März 2010, Nicolas Pitre wrote:
> > On Fri, 26 Mar 2010, Johannes Sixt wrote:
> > > Use 'git rev-list --objects --all' to find all objects connected to all
> > > refs (use something else than --all if you want to). Do *not* look at the
> > > path that the tree and blob objects have attached - it is not authorative
> > > information.
> >
> > Really??
> 
> Yes, really. Consider the same content at two differen paths. Now what? 
> rev-list will only ever list the object once.

Sure. It is still a valid path though.


Nicolas

--Boundary_(ID_bgpqf+If1TxhwMW/lgQ0tQ)--
