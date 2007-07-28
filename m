From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/8] Add functions get_relative_cwd() and is_inside_dir()
Date: Sat, 28 Jul 2007 02:03:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707280203110.14781@racer.site>
References: <Pine.LNX.4.64.0707271851370.14781@racer.site>
 <Pine.LNX.4.64.0707271956140.14781@racer.site> <7vps2dy3hb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, matled@gmx.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 03:03:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEaiW-0001zL-5A
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 03:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbXG1BDe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 21:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938353AbXG1BDd
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 21:03:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:58500 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S938309AbXG1BDd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 21:03:33 -0400
Received: (qmail invoked by alias); 28 Jul 2007 01:03:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 28 Jul 2007 03:03:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Jk/YNXtWJkzeObr4Q00msKWAzvW+rHl/LqZFlqS
	G3RyRgtR3GMbLG
X-X-Sender: gene099@racer.site
In-Reply-To: <7vps2dy3hb.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53987>

Hi,

On Fri, 27 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > +char *get_relative_cwd(char *buffer, int size, const char *dir)
> > +{
> > +	char *cwd = buffer;
> > +
> > +	if (!dir)
> > +		return 0;
> > +
> > +	if (!getcwd(buffer, PATH_MAX))
> > +		return 0;
> 
> Can size be less than PATH_MAX?

Thanks.  Will fix.

Ciao,
Dscho
