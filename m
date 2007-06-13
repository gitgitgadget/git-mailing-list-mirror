From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH 2/3] Add gitmodules(5)
Date: Wed, 13 Jun 2007 17:36:11 +0200
Message-ID: <20070613153611.GA11852@moooo.ath.cx>
References: <1181425132239-git-send-email-hjemli@gmail.com> <11814251322779-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 17:36:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyUtM-0007Hs-Lb
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 17:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758034AbXFMPgP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 11:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757804AbXFMPgP
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 11:36:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:38337 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757386AbXFMPgO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 11:36:14 -0400
Received: (qmail invoked by alias); 13 Jun 2007 15:36:12 -0000
Received: from pD9EBB4AE.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.180.174]
  by mail.gmx.net (mp002) with SMTP; 13 Jun 2007 17:36:12 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX19wkKgMuwRwCNYyXIJl8cNdw+nN/h7kpG/QoWsX0A
	wjrYeL92FOJ0R/
Content-Disposition: inline
In-Reply-To: <11814251322779-git-send-email-hjemli@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50077>

Lars Hjemli <hjemli@gmail.com> wrote:
> +SYNOPSIS
> +--------
> +.gitmodules

My asciidoc (7.1.2 and 8.2.1) generates an empty refsynopsisdiv from
this.  xmlto refuses to convert this into anything else:

xmlto -m callouts.xsl man gitmodules.xml
xmlto: input does not validate (status 3)
/path/to/git/Documentation/gitmodules.xml:15: element refsynopsisdiv: validity error : Element refsynopsisdiv content does not follow the DTD, expecting (refsynopsisdivinfo? , (title , subtitle? , titleabbrev?)? , (((calloutlist | glosslist | itemizedlist | orderedlist | segmentedlist | simplelist | variablelist | caution | important | note | tip | warning | literallayout | programlisting | programlistingco | screen | screenco | screenshot | synopsis | cmdsynopsis | funcsynopsis | classsynopsis | fieldsynopsis | constructorsynopsis | destructorsynopsis | methodsynopsis | formalpara | para | simpara | address | blockquote | graphic | graphicco | mediaobject | mediaobjectco | informalequation | informalexample | informalfigure | informaltable | equation | example | figure | table | msgset | procedure | sidebar | qandaset | anchor | bridgehead | remark | highlights | abstract | authorblurb 
 | epigraph | indexterm | beginpage)+ , refsect2*) | refsect2+)), got ()
Document /path/to/git/Documentation/gitmodules.xml does not validate

This breaks the build process for the documentation.  I could not find
out how to fix this.  Probably just needs the right quoting for the
dot at the beginning of the line.
