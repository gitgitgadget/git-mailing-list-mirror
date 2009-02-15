From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] parse-opt: migrate builtin-ls-files.
Date: Sun, 15 Feb 2009 21:13:42 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902152108370.10279@pacific.mpi-cbg.de>
References: <1234727647-18523-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Feb 15 21:14:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYnNa-00013b-Id
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 21:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbZBOUMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 15:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbZBOUMu
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 15:12:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:54868 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751272AbZBOUMt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 15:12:49 -0500
Received: (qmail invoked by alias); 15 Feb 2009 20:12:47 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 15 Feb 2009 21:12:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18l+as/arslYUTrH1NSY1VB+1seaD1TYHiADc93C3
	YsSz7xJDXe5TVg
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1234727647-18523-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110053>

Hi,

On Sun, 15 Feb 2009, Miklos Vajna wrote:

> On Sat, Feb 14, 2009 at 09:56:04PM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Thu, 8 Jan 2009, Miklos Vajna wrote:
> >
> > > +static int option_parse_ignored(const struct option *opt,
> > > +                           const char *arg, int unset)
> > > +{
> > > +   struct dir_struct *dir = opt->value;
> > > +
> > > +   dir->show_ignored = !unset;
> > > +
> > > +   return 0;
> > > +}
> >
> > Maybe this wants to be converted into an OPTION_BIT compatible data 
> > type?
> 
> I think that's not possible, as show_ignored is a bitfield.

Well, in my juvenile folly I dreamt of turning this into a proper 
bitfield...

Ciao,
Dscho
