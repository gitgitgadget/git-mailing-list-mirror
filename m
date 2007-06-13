From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH 2/3] Add gitmodules(5)
Date: Wed, 13 Jun 2007 18:31:36 +0200
Message-ID: <20070613163136.GA28101@moooo.ath.cx>
References: <1181425132239-git-send-email-hjemli@gmail.com> <11814251322779-git-send-email-hjemli@gmail.com> <20070613153611.GA11852@moooo.ath.cx> <8c5c35580706130913j2d3095d1n649145ff540d1bec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 18:31:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyVl6-0004Ve-9S
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 18:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758601AbXFMQbl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 12:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758594AbXFMQbl
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 12:31:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:46384 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758578AbXFMQbk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 12:31:40 -0400
Received: (qmail invoked by alias); 13 Jun 2007 16:31:37 -0000
Received: from pD9EBB4AE.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.180.174]
  by mail.gmx.net (mp019) with SMTP; 13 Jun 2007 18:31:37 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1+LTTBXnP+L6a9DCPXjRBbD9WD/VSidrChlgaKv1B
	vxfcTb1nIrpU/3
Content-Disposition: inline
In-Reply-To: <8c5c35580706130913j2d3095d1n649145ff540d1bec@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50092>

Lars Hjemli <hjemli@gmail.com> wrote:
> Could you please try one or both of the following escape-sequences?
> 
> \.gitmodules
> #.gitmodules#

#.gitmodules# seems to produce a good xml file, html is fine too.  But
the conversion from xml to a manpage seems to be broken:

    $ xmlto -m callouts.xsl man gitmodules.xml

transforms

    <refsynopsisdiv>
    <simpara>.gitmodules</simpara>

    </refsynopsisdiv>

to

    .SH "SYNOPSIS"
    .gitmodules

".gitmodules" is not shown in the manpage and vim highlights the ".gi"
just like ".SH" in a special color.  Perhaps we should just highlight
.gitmodules like commands with single quotes.  This solves both
problems :)
