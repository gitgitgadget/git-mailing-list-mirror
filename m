From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: metastore (was: Track /etc directory using Git)
Date: Sat, 15 Sep 2007 15:10:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709151507310.28586@racer.site>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Sat Sep 15 16:10:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWYMF-0007uk-J1
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 16:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbXIOOKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 10:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751684AbXIOOKr
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 10:10:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:38368 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751525AbXIOOKr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 10:10:47 -0400
Received: (qmail invoked by alias); 15 Sep 2007 14:10:45 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 15 Sep 2007 16:10:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/sHHQzyEjsxNL5yb34EU2F5bwBx7XgZ0t0skClBG
	2c04XlTLeNoHGu
X-X-Sender: gene099@racer.site
In-Reply-To: <20070915132632.GA31610@piper.oerlikon.madduck.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58244>

Hi,

On Sat, 15 Sep 2007, martin f krafft wrote:

> The problem with metdata getting corrupted, which Nicolas reported,
> may well have to do with the use of a single file.

Then the tool is corrupt.  Introducing a shadow hierarchy, as you propose, 
is very inefficient.

> Anyway, this *really* should go into git itself!

No.  Git is a source code management system.  Everything else that you can 
do with it is a bonus, a second class citizen.  Should we really try to 
support your use case, we will invariably affect the primary use case.

Ciao,
Dscho
