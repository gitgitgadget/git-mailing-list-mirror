From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Errors building git-1.5.2.2 on 64-bit Centos 5
Date: Tue, 19 Jun 2007 14:58:19 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706191457440.4059@racer.site>
References: <18039.52754.563688.907038@lisa.zopyra.com>
 <Pine.LNX.4.64.0706191359160.4059@racer.site> <18039.57163.667319.439210@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 15:58:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0eE3-0005PB-R8
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 15:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbXFSN6a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 09:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752157AbXFSN6a
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 09:58:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:33224 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751492AbXFSN63 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 09:58:29 -0400
Received: (qmail invoked by alias); 19 Jun 2007 13:58:28 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp032) with SMTP; 19 Jun 2007 15:58:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/5rSNLsy/5YTZeZZW43QlT4clfHhOrBZ64ZNI4J2
	0z9VXk3NqzrFRG
X-X-Sender: gene099@racer.site
In-Reply-To: <18039.57163.667319.439210@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50484>

Hi,

On Tue, 19 Jun 2007, Bill Lear wrote:

> On Tuesday, June 19, 2007 at 14:00:07 (+0100) Johannes Schindelin writes:
> >
> >On Tue, 19 Jun 2007, Bill Lear wrote:
> >
> >> Also breaks (tar fails) if I do the 'make configure; ./configure'
> >> route.
> >
> >Then there is a test missing in configure.
> 
> Here is the particular error:
> 
> install git '/opt/git-1.5.2.2/bin'
> make -C templates DESTDIR='' install
> make[1]: Entering directory `/home/blear/build/git-1.5.2.2/templates'
> install -d -m755 '/opt/git-1.5.2.2/share/git-core/templates/'
> (cd blt && gtar cf - .) | \
> 	(cd '/opt/git-1.5.2.2/share/git-core/templates/' && gtar xf -)
> gtar: This does not look like a tar archive
> gtar: Skipping to next header
> gtar: Archive contains obsolescent base-64 headers
> gtar: Error exit delayed from previous errors
> make[1]: *** [install] Error 2
> make[1]: Leaving directory `/home/blear/build/git-1.5.2.2/templates'
> make: *** [install] Error 2

WTF? gtar cannot read its own output?

Be that as may, this is not git error.

Ciao,
Dscho
