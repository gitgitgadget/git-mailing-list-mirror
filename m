From: Gerrit Pape <pape@smarden.org>
Subject: Re: pull-fetch-param.txt
Date: Fri, 20 Jul 2007 14:32:14 +0000
Message-ID: <20070720143214.23897.qmail@511f57d39b0a54.315fe32.mid.smarden.org>
References: <tkrat.4532d38d43e16a62@s5r6.in-berlin.de> <7vhcymt07a.fsf@assigned-by-dhcp.cox.net> <452211C2.8020402@s5r6.in-berlin.de> <7vven1rfpj.fsf@assigned-by-dhcp.cox.net> <45222B18.1090305@s5r6.in-berlin.de> <20070712130631.13667.qmail@594d46613ccd9b.315fe32.mid.smarden.org> <7vvecps2rz.fsf@assigned-by-dhcp.cox.net> <20070713055346.634.qmail@1e54e4f4e1041d.315fe32.mid.smarden.org> <7vejjcpyb5.fsf@assigned-by-dhcp.cox.net> <20070713074824.9806.qmail@df2dc1a3890a6b.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 20 16:35:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBtZg-0005HY-C7
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 16:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761075AbXGTOcS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 10:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761976AbXGTOcS
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 10:32:18 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:40701 "HELO a.mx.smarden.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with SMTP
	id S1761123AbXGTOcR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 10:32:17 -0400
Received: (qmail 23898 invoked by uid 1000); 20 Jul 2007 14:32:14 -0000
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070713074824.9806.qmail@df2dc1a3890a6b.315fe32.mid.smarden.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53095>

On Fri, Jul 13, 2007 at 07:48:24AM +0000, Gerrit Pape wrote:
> On Fri, Jul 13, 2007 at 12:17:34AM -0700, Junio C Hamano wrote:
> > Sorry, does not reproduce for me, with asciidoc 8.2.1.  There
> > must be something different between our environments.
> 
> Yes, I have docbook-xsl 1.72.0.

> > $ git commit \-a \-c ORIG_HEAD  \fB(3)\fR
> 
> I get the same with docbook-xsl 1.71.0, but with 1.72.0:

> $ git commit \-a \-c ORIG_HEAD  \efB(3)\efR

> I'll check with the docbook-xsl Debian maintainer.

The change in docbook-xsl was by intention, please see
 http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=420114#22

Regards, Gerrit.
