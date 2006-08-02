From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitweb: optionally read config from GITWEB_CONFIG
Date: Wed, 2 Aug 2006 16:56:06 -0400
Message-ID: <20060802205606.GC15678@sigio.intra.peff.net>
References: <20060802192333.GA30861@coredump.intra.peff.net> <20060802205120.84032.qmail@web31808.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 22:57:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8NlM-0003V2-GX
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 22:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWHBU4K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 16:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWHBU4J
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 16:56:09 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:30678 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751202AbWHBU4I (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 16:56:08 -0400
Received: (qmail 528 invoked from network); 2 Aug 2006 16:55:31 -0400
Received: from unknown (HELO sigio.intra.peff.net) (10.0.0.10)
  by segfault.intra.peff.net with SMTP; 2 Aug 2006 16:55:31 -0400
Received: by sigio.intra.peff.net (sSMTP sendmail emulation); Wed,  2 Aug 2006 16:56:06 -0400
To: Luben Tuikov <ltuikov@yahoo.com>
Content-Disposition: inline
In-Reply-To: <20060802205120.84032.qmail@web31808.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24686>

On Wed, Aug 02, 2006 at 01:51:20PM -0700, Luben Tuikov wrote:

> I don't think users should even edit the Makefile.  Makefiles are normally
> edited when the _build_ environment differs, not when the deployment
> environment differs.

I don't either; I should have stated more clearly: users can edit
config.mak or use command line parameters to make (the same way they do
for prefix or other variables).

You don't even have to do that if the default config-file path is fine
for you. And even if you don't, you should be able to set GITWEB_CONF
with Matthias' patch.

-Peff
