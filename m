From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] gitweb: fill in gitweb configuration by Makefile
Date: Mon, 31 Jul 2006 16:33:14 -0500
Message-ID: <1154381594.5107.55.camel@cashmere.sps.mot.com>
References: <20060731035737.24181.qmail@web31803.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Martin Waitz <tali@admingilde.org>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 31 23:39:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7fSK-00074y-Lk
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 23:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030471AbWGaVhl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 17:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030472AbWGaVhl
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 17:37:41 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:44173 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1030471AbWGaVhl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 17:37:41 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id k6VLbQwo029342;
	Mon, 31 Jul 2006 14:37:26 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k6VLbPuX015896;
	Mon, 31 Jul 2006 16:37:25 -0500 (CDT)
To: ltuikov@yahoo.com
In-Reply-To: <20060731035737.24181.qmail@web31803.mail.mud.yahoo.com>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24547>

On Sun, 2006-07-30 at 22:57, Luben Tuikov wrote:
> --- Martin Waitz <tali@admingilde.org> wrote:
> > Generate gitweb/gitweb.cgi to reduce the need to patch gitweb.cgi by
> > the end user.
> > The GIT installation directory and version are already known by the
> > Makefile, they can be inserted directly into gitweb.
> > All other gitweb configuration parameters can now be specified
> > by providing GITWEB_* variables while building GIT.
> > These are described in gitweb/README.
> 
> NACK.
> 
> I don't like it.  While this method works, it is too much effort
> to have to run make to do this, plus it pollutes your tree.
> 
> Instead, what you can do is make gitweb.cgi read a text file
> from . which has those variables defined.
> 
> This way, I can just copy gitweb.cgi into my web-server directory
> and voila it works, since the variable definition file would
> always be there.  This way:
>   - no need to run make to build "gitweb.cgi" or "gitweb.pl" whatever
>     you call it,
>   - no need to pollute your tree with site defined variables,
>   - simple copy (cp) would install a working version, instead of
>     the current cp + patch with local settings method.
> 
>    Luben

Which sounds frighteningly similar to a patch I submitted
quite a while ago, and brought up again twice, and have
had stomped on once.

So what now? :-)

jdl
