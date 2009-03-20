From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] Introduce BEL<branch> as shortcut to the tracked 
 branch
Date: Fri, 20 Mar 2009 15:00:24 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903201455130.6865@intel-tinevez-2-302>
References: <200903181448.50706.agruen@suse.de>  <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de>  <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de>  <20090320004029.GX23521@spearce.org>  <20090320004450.GY23521@spearce.org> 
 <alpine.DEB.1.00.0903201027450.10279@pacific.mpi-cbg.de>  <3F6729A7-76FA-43F4-9538-D644B30576D7@wincent.com>  <alpine.DEB.1.00.0903201053280.10279@pacific.mpi-cbg.de>  <adf1fd3d0903200533s2be08ee7t58a22180b1c886c0@mail.gmail.com> 
 <alpine.DEB.1.00.0903201345190.6865@intel-tinevez-2-302> <237967ef0903200553v58af40b5sfbfa0bbb1f9d96eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-660172411-1237557625=:6865"
Cc: =?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>,
	Wincent Colaiuta <win@wincent.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>,
	Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 15:02:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkfIO-0001Iq-5n
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 15:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757352AbZCTOAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 10:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756912AbZCTOA3
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 10:00:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:38996 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756559AbZCTOA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 10:00:28 -0400
Received: (qmail invoked by alias); 20 Mar 2009 14:00:25 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp019) with SMTP; 20 Mar 2009 15:00:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1//OEMBbC7/0FueC657mAFMdNxvgFjqk6xr8LqAa3
	NwOaVLfHAA1I/Q
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <237967ef0903200553v58af40b5sfbfa0bbb1f9d96eb@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113959>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-660172411-1237557625=:6865
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 20 Mar 2009, Mikael Magnusson wrote:

> 2009/3/20 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>
> > On Fri, 20 Mar 2009, Santi Béjar wrote:
> >
> >> 2009/3/20 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> >>
> >> > On Fri, 20 Mar 2009, Wincent Colaiuta wrote:
> >> >
> >> >> El 20/3/2009, a las 10:29, Johannes Schindelin escribió:
> >> >>
> >> >> >Often, it is quite interesting to inspect the branch tracked by a
> >> >> >given branch.  This patch introduces a nice notation to get at the
> >> >> >tracked branch: 'BEL<branch>' can be used to access that tracked
> >> >> >branch.
> >> >> >
> >> >> >A special shortcut 'BEL' refers to the branch tracked by the current
> >> >> >branch.
> >> >> >
> >> >> >Suggested by Pasky and Shawn.
> >> >>
> >> >> What does BEL actually stand for? I read Shawn's suggestion, but it's
> >> >> not immediately clear to me what "BEL" means.
> >> >
> >> > It is the ASCII "bell" character, 007 (I always wanted to write that
> >> > magic identifier into a patch).
> >> >
> >> > FWIW you could type it in a regular ANSI terminal using Control-v
> >> > Control-g.
> >>
> >> Can we use branch^{origin} instead? It is longer to type, but uses the
> >> same syntax as the ^{tree}, ^{commit}, ^{tag} and you don't have to know
> >> how to produce the bell character.
> >
> > I think I addressed that issue already.  (Summary: I do not like it)
> >
> > Let me spell it out if it was not obvious yet: the BEL patch was meant as
> > a more or less funny reminder that the issue is not solved and that I need
> > help.
> 
> Would :%:foo work? I thought about the reserved prefix :/! , but :/!! 
> isn't reserved so I don't think that would work. And it's pretty 
> annoying to type too.

Or maybe :%foo?

That would have a rather nasty interaction with code I have in my tree to 
refer to the cache-trees via ':<path>', but I guess I can live with that.

Ciao,
Dscho

--8323329-660172411-1237557625=:6865--
