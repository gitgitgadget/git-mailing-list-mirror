From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Support cvs via git-shell
Date: Wed, 10 Oct 2007 14:29:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710101427160.4174@racer.site>
References: <200710051453.47622.wielemak@science.uva.nl>
 <Pine.LNX.4.64.0710091531360.4174@racer.site> <20071009223538.GG31659@planck.djpig.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, hjemli@gmail.com,
	Jan Wielemaker <wielemak@science.uva.nl>,
	Git Mailing List <git@vger.kernel.org>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Wed Oct 10 15:29:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifbcx-0008Hp-18
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 15:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbXJJN3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 09:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752552AbXJJN3U
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 09:29:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:45571 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752516AbXJJN3U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 09:29:20 -0400
Received: (qmail invoked by alias); 10 Oct 2007 13:29:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 10 Oct 2007 15:29:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18BujNcMN0BKinackmOCeHwa8jtRsmjkzlwr1teWq
	8Lxe9KQMJLgBrS
X-X-Sender: gene099@racer.site
In-Reply-To: <20071009223538.GG31659@planck.djpig.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60493>

Hi,

On Wed, 10 Oct 2007, Frank Lichtenheld wrote:

> On Tue, Oct 09, 2007 at 03:33:25PM +0100, Johannes Schindelin wrote:
> >  static struct commands {
> >  	const char *name;
> >  	int (*exec)(const char *me, char *arg);
> >  } cmd_list[] = {
> >  	{ "git-receive-pack", do_generic_cmd },
> >  	{ "git-upload-pack", do_generic_cmd },
> > +	{ "cvs", do_cvs_cmd },
> >  	{ NULL },
> 
> Maybe this should also allow git-cvsserver for completeness' sake?

Umm.  Why?

If you use a cvs client with :ext: protocol, it will call ssh (or rsh!) 
with the command "cvs server", not "git-cvsserver".

Only in setups where you set (IIRC) the environment variable "CVSSERVER" 
on the client to "git-cvsserver" will it call something different, but 
these setups exist already, and never used git-shell to begin with.

Ciao,
Dscho
