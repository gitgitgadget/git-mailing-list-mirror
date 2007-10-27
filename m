From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: remote#branch
Date: Sun, 28 Oct 2007 00:01:57 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710280000240.4362@racer.site>
References: <20071015233800.6306e414@paolo-desktop> <20071016021933.GH12156@machine.or.cz>
 <Pine.LNX.4.64.0710161139530.25221@racer.site> <20071016210904.GI26127@efreet.light.src>
 <Pine.LNX.4.64.0710162228560.25221@racer.site> <20071027204757.GA3058@efreet.light.src>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Oct 28 01:03:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlugI-0005nz-VV
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 01:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbXJ0XCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 19:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbXJ0XCf
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 19:02:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:48570 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751313AbXJ0XCe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 19:02:34 -0400
Received: (qmail invoked by alias); 27 Oct 2007 23:02:32 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 28 Oct 2007 01:02:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19N3NQvB0dNsMYsAXc82MoIJbTHfK9H7PmWA1dVf8
	EIqYb536Ut4sLZ
X-X-Sender: gene099@racer.site
In-Reply-To: <20071027204757.GA3058@efreet.light.src>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62516>

Hi,

On Sat, 27 Oct 2007, Jan Hudec wrote:

> On Tue, Oct 16, 2007 at 22:35:25 +0100, Johannes Schindelin wrote:
>
> > ',' is allowed in ref names, so ',' is out.
> 
> Actually since many characters that are allowed in ref name are not 
> allowed in URL at all, the ref-name has to be url-escaped. Which brings 
> all characters back in, because they can always be specified escaped.

No.  The URL part of it has to be encoded.  But the ref names do _not_.  
(If we really want to have a way to specify the remote URL and the 
branch(es) we want to fetch _at the same time_.)

Ciao,
Dscho
