From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] Add color_fwrite(), a function coloring each line
 individually
Date: Mon, 12 Jan 2009 00:49:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901120048430.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901112058570.3586@pacific.mpi-cbg.de> <7vwsd1o44i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 00:50:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMA44-0005du-Tn
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 00:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbZAKXsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 18:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbZAKXsS
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 18:48:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:55663 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751249AbZAKXsS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 18:48:18 -0500
Received: (qmail invoked by alias); 11 Jan 2009 23:48:16 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp052) with SMTP; 12 Jan 2009 00:48:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19v1UxnH15v2WwCZv833kbeJyrvfxbldGkfh3nwBz
	4z7t0kl323sTHh
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vwsd1o44i.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105255>

Hi,

On Sun, 11 Jan 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > +/*
> > + * This function splits the buffer by newlines and colors the lines individually.
> > + */
> > +void color_fwrite(FILE *f, const char *color, size_t count, const char *buf)
> 
> Is it just me that this is grossly misnamed?  It is not about fwrite of
> count bytes starting at buf in the specified color.  At list it should be
> called color_fwrite_lines() or something like that.
> 
> > diff --git a/color.h b/color.h
> > index 6cf5c88..9fb58f5 100644
> > --- a/color.h
> > +++ b/color.h
> > @@ -19,5 +19,6 @@ int git_config_colorbool(const char *var, const char *value, int stdout_is_tty);
> >  void color_parse(const char *var, const char *value, char *dst);
> >  int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
> >  int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...);
> > +void color_fwrite(FILE *f, const char *color, size_t count, const char *buf);
> 
> Also if other functions in the family all return int to indicate errors
> and name the FILE * argument fp, I find it a very bad taste not to follow
> their patterns without having a good reason (which I do not see).

Valid points.

Sorry,
Dscho
