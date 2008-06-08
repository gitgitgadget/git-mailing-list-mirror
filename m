From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [TOY PATCH] git wrapper: show similar command names for an
 unknown command
Date: Mon, 9 Jun 2008 00:26:36 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806090024430.1783@racer>
References: <alpine.DEB.1.00.0806050747000.21190@racer> <20080607072721.GA3347@steel.home> <alpine.DEB.1.00.0806071603470.1783@racer> <20080607175103.GA5822@steel.home> <7vmylxnmnz.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806081607040.1783@racer>
 <484BF751.1000203@dirk.my1.cc> <7vskvnke34.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-305902094-1212967604=:1783"
Cc: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 01:28:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5UJf-0000QU-D8
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 01:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756033AbYFHX17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 19:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755962AbYFHX16
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 19:27:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:36462 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753845AbYFHX16 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 19:27:58 -0400
Received: (qmail invoked by alias); 08 Jun 2008 23:27:56 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp031) with SMTP; 09 Jun 2008 01:27:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+oHKxAC9yoIF678n1Q9LA4S8/uJ/K8/xf5JT0zmF
	/Jl3NkOUMaOlA+
X-X-Sender: gene099@racer
In-Reply-To: <7vskvnke34.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84345>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-305902094-1212967604=:1783
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 8 Jun 2008, Junio C Hamano wrote:

> Dirk Süsserott <newsletter@dirk.my1.cc> writes:
> 
> > Johannes Schindelin schrieb:
> >> This patch is not meant for inclusion, as indicated by the "TOY
> >> PATCH" prefix.
> 
> Yes, I understand it.
> 
> I was not complaining about the "who cares, we will exit after we are 
> done with this processing anyway" attitude in this code.  I think it is 
> a reasonable approach to take because it is not likely that this 
> codepath to change and would start wanting to access the original 
> command table after it did its munging.  I was suggesting a positive 
> improvement to the patch by making it explicitly documented to help 
> people polish further, that's all.

I understood that.  However, I simply do not have the time to take care of 
that.  That's why I said it is a toy patch, and I did not mean it for 
inclusion.  It was just a nice time waster for me; it's not even something 
I'd find terribly useful myself, unless it asked me if I wanted to execute 
this or that instead (provided that isatty()).

> You do not have to be so defensive.

I wasn't.  At least I did not mean to.

Ciao,
Dscho

--8323329-305902094-1212967604=:1783--
