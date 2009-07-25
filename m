From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Make section_name_match start on '[', and return
 the length on success
Date: Sat, 25 Jul 2009 19:41:27 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907251941100.8306@pacific.mpi-cbg.de>
References: <1248470504-16326-1-git-send-email-alex@chmrr.net> <1248470504-16326-2-git-send-email-alex@chmrr.net> <alpine.DEB.1.00.0907251605240.8306@pacific.mpi-cbg.de> <1248542170-sup-4264@utwig>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
To: Alex Vandiver <alex@chmrr.net>
X-From: git-owner@vger.kernel.org Sat Jul 25 19:41:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUlFT-0003MP-Rh
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 19:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbZGYRlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 13:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbZGYRlZ
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 13:41:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:57996 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751851AbZGYRlY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 13:41:24 -0400
Received: (qmail invoked by alias); 25 Jul 2009 17:41:23 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp064) with SMTP; 25 Jul 2009 19:41:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/VEDAivkTVoIojlwLCtwOZKumrH67XsOAQ+O98Vd
	ghKQLyBRaEDmWz
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1248542170-sup-4264@utwig>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124026>

Hi,

On Sat, 25 Jul 2009, Alex Vandiver wrote:

> At Sat Jul 25 10:09:56 -0400 2009, Johannes Schindelin wrote:
> > Is this not unnecessary, given that we  only call that function when we 
> > know that buf[0] == '[':
> 
> Yes.  However, given that I had changed the calling convention for the
> code, (it used to be passed the string starting just _inside_ the
> '['), I wanted to make the new calling convention clearer, and catch
> any places that were using the old convention.
> 
> I'm happy to submit a new version without it, if you wish.
> 
> > I was a bit surprised that "offset" is not used further in your patch, but 
> > I saw that 2/2 uses it.
> 
> Yeah, this hunk should probably have gone in 2/2 instead.

No need to change anything, Junio already applied your patches.

Ciao,
Dscho
