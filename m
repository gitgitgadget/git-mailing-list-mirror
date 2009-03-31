From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] graph API: Added logic for colored edges.
Date: Tue, 31 Mar 2009 14:09:57 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0903311409320.7052@intel-tinevez-2-302>
References: <20090318100512.GA7932@linux.vnet> <alpine.DEB.1.00.0903181228420.10279@pacific.mpi-cbg.de> <b2e43f8f0903190959if539048r19e972899bd2132d@mail.gmail.com> <alpine.DEB.1.00.0903191831590.6357@intel-tinevez-2-302> <20090320064813.6117@nanako3.lavabit.com>
 <b2e43f8f0903201213o396de6c0sb52149ed1d889d1@mail.gmail.com> <20090320195806.GC26934@coredump.intra.peff.net> <20090321175726.GA6677@linux.vnet> <20090330141322.GA6221@linux.vnet> <alpine.DEB.1.00.0903311210000.10279@pacific.mpi-cbg.de>
 <49D1EFF2.303@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Allan Caffee <allan.caffee@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 14:11:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LocoZ-0004d6-Rd
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 14:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754568AbZCaMKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 08:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753783AbZCaMKE
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 08:10:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:55935 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752117AbZCaMKB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 08:10:01 -0400
Received: (qmail invoked by alias); 31 Mar 2009 12:09:58 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp015) with SMTP; 31 Mar 2009 14:09:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18yKYc+bQcyCYWVX1aFeMNWr5TpPgV3onsQ0gmHEb
	1HG5ruc36SiKq6
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <49D1EFF2.303@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115254>

Hi,

On Tue, 31 Mar 2009, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > How about this function instead?
> > 
> > static void strbuf_add_column(struct strbuf *sb,
> > 	const struct column *column, const char *fmt, ...)
> > {
> >         va_list ap;
> > 
> >         va_start(ap, fmt);
> > 	if (column->color)
> > 		strbuf_addstr(sb, column->color);
> >         strbuf_vaddf(sb, fmt, ap);
> > 	if (column->color)
> > 		strbuf_addstr(sb, GIT_COLOR_RESET);
> >         va_end(ap);
> > }
> > 
> > Hmm?
> 
> Except the strbuf_vaddf() is only in your private repository ;)

LOL & schenkelklopf!

You're absolutely correct... I'm sorry,
Dscho
