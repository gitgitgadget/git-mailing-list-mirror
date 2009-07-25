From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git fast-export: add --no-data option
Date: Sat, 25 Jul 2009 19:44:05 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907251942390.8306@pacific.mpi-cbg.de>
References: <7f9d599f0907250645s6e6f9b81w3cf20f07eff088eb@mail.gmail.com> <7vfxcku13i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Geoffrey Irving <irving@naml.us>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 19:44:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUlI5-0004H3-Cp
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 19:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbZGYRoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 13:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbZGYRoE
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 13:44:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:48864 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751630AbZGYRoC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 13:44:02 -0400
Received: (qmail invoked by alias); 25 Jul 2009 17:44:02 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp029) with SMTP; 25 Jul 2009 19:44:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/tCuxEKXntbiSUWj/hHr0M6ZVs1tCkLzOlkoABkc
	hV/BEKg6ZlsXYi
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vfxcku13i.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124027>

Hi,

On Sat, 25 Jul 2009, Junio C Hamano wrote:

> Geoffrey Irving <irving@naml.us> writes:
> 
> > @@ -504,6 +508,8 @@ int cmd_fast_export(int argc, const char **argv,
> > const char *prefix)
> >  			     "Import marks from this file"),
> >  		OPT_BOOLEAN(0, "fake-missing-tagger", &fake_missing_tagger,
> >  			     "Fake a tagger when tags lack one"),
> > +		OPT_BOOLEAN(0, "no-data", &no_data,
> > +			     "Skip output of blob data"),
> 
> Shouldn't this be --[no-]data option that defaults to true?  Otherwise you
> would accept --no-no-data that looks silly.

Maybe

		OPT_NEGBIT(0, "data", &no_data,
			     "Skip output of blob data", 1),

Hmm?

Ciao,
Dscho
		
