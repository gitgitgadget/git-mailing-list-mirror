From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3 v3] Add support for external programs for handling
 native fetches
Date: Wed, 5 Aug 2009 22:34:26 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908052231461.8306@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0907310109130.2147@iabervon.org> <alpine.DEB.1.00.0908051143000.8306@pacific.mpi-cbg.de> <alpine.LNX.2.00.0908051058130.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 22:34:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYnBc-0006qa-3w
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 22:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650AbZHEUeD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 16:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752628AbZHEUeD
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 16:34:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:60029 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752561AbZHEUeB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 16:34:01 -0400
Received: (qmail invoked by alias); 05 Aug 2009 20:34:01 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp016) with SMTP; 05 Aug 2009 22:34:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19lXw1CrGJl7w1lx7XLuH1VdjPdv7ZKmejCec8UvF
	fzdCZtT8OoA1/y
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LNX.2.00.0908051058130.2147@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124970>

Hi,

On Wed, 5 Aug 2009, Daniel Barkalow wrote:

> On Wed, 5 Aug 2009, Johannes Schindelin wrote:
> 
> > On Fri, 31 Jul 2009, Daniel Barkalow wrote:
> > 
> > > +	}
> > > +	strbuf_release(&buf);
> > > +
> > > +	for (posn = ret; posn; posn = posn->next)
> > > +		resolve_remote_symref(posn, ret);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +int transport_native_helper_init(struct transport *transport)
> > > +{
> > > +	struct helper_data *data = xmalloc(sizeof(*data));
> > > +	char *eom = strchr(transport->url, ':');
> > 
> > "End of message"?
> 
> "End of method"; that's the "method" part of a URL.

I'd have called that "protocol".  At least that's what java.net.URL 
calls it, and I just assume that Sun is very much in love with standards, 
so I could imagine they picked that term from the appropriate RFC.

In any case, I am much less likely to puzzle over "p" than "eom"...

Ciao,
Dscho
