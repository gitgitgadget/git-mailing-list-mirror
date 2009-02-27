From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: avoid 'git reset' when possible
Date: Fri, 27 Feb 2009 14:33:52 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902271433100.6600@intel-tinevez-2-302>
References: <fabb9a1e0902260655g53fa1e1fg7e4aa76b0f3a80fc@mail.gmail.com>  <alpine.DEB.1.00.0902261557300.6258@intel-tinevez-2-302>  <fabb9a1e0902260733k26e5c02i75a7866f9a67530b@mail.gmail.com>  <alpine.DEB.1.00.0902271146460.6600@intel-tinevez-2-302> 
 <alpine.DEB.1.00.0902271354130.6600@intel-tinevez-2-302> <fabb9a1e0902270503p4b769a48xaef5978f0f05797@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1055388058-1235741633=:6600"
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephen Haberman <stephen@exigencecorp.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 14:35:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld2s9-0008CY-IK
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 14:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755290AbZB0Nd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 08:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755116AbZB0Nd5
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 08:33:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:41088 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752064AbZB0Nd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 08:33:56 -0500
Received: (qmail invoked by alias); 27 Feb 2009 13:33:53 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp037) with SMTP; 27 Feb 2009 14:33:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18cva5pVJMcqUUlSTyX9hUz+eL7xzlPa1wk1lBgH+
	Wm2Qdl+8Z3m/o8
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <fabb9a1e0902270503p4b769a48xaef5978f0f05797@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111670>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1055388058-1235741633=:6600
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 27 Feb 2009, Sverre Rabbelier wrote:

> On Fri, Feb 27, 2009 at 13:56, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> 
> >> Having said that, I think yours might be such a common case that it 
> >> is worth optimizing for.
> >
> > And so I did.
> 
> Very nice, I don't think I couldof done it anywhere near as fast ;).

Heh, the time I save now that I read less mails... :-)  It's more fun, 
too.

Ciao,
Dscho

--8323329-1055388058-1235741633=:6600--
