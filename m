From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config: Add new option to open an editor.
Date: Wed, 4 Feb 2009 16:20:07 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902041619370.22763@intel-tinevez-2-302>
References: <1233700826-11763-1-git-send-email-felipe.contreras@gmail.com>  <20090204145317.GA5712@sigill.intra.peff.net> <94a0d4530902040703u53a9082fsfa7203b6203bd118@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 16:21:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUjZI-0003t0-Ai
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 16:21:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbZBDPUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 10:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752454AbZBDPUM
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 10:20:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:48303 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752370AbZBDPUL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 10:20:11 -0500
Received: (qmail invoked by alias); 04 Feb 2009 15:20:08 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp054) with SMTP; 04 Feb 2009 16:20:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+8SZ9tJ368wTX7yNRAgbuPr+yCOfMTjnkvwEsBTk
	b3Odyr++qC/iBQ
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <94a0d4530902040703u53a9082fsfa7203b6203bd118@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108376>

Hi,

On Wed, 4 Feb 2009, Felipe Contreras wrote:

> On Wed, Feb 4, 2009 at 4:53 PM, Jeff King <peff@peff.net> wrote:
> > On Wed, Feb 04, 2009 at 12:40:26AM +0200, Felipe Contreras wrote:
> >
> >> +             } else if (!strcmp(argv[1], "--edit") || !strcmp(argv[1], "-e")) {
> >> +                     char *config_filename;
> >> +                     if (config_exclusive_filename)
> >> +                             config_filename = xstrdup(config_exclusive_filename);
> >> +                     else
> >> +                             config_filename = git_pathdup("config");
> >> +                     launch_editor(config_filename, NULL, NULL);
> >> +                     free(config_filename);
> >> +                     return 0;
> >>               } else
> >
> > With this patch, won't I get different behavior from:
> >
> >  git config -e --global
> >
> > versus
> >
> >  git config --global -e
> 
> Just like you get different behavior from:
> 
> git config -l --global
> 
> and
> 
> git config --global -l

... which will be fixed once you parseopt'ified builtin-config, right?

:-)

Ciao,
Dscho
