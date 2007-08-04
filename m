From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-gui: Added support for OS X right click
Date: Sat, 4 Aug 2007 03:41:50 -0400
Message-ID: <20070804074150.GA7738@coredump.intra.peff.net>
References: <C4431971-A1F1-463E-B238-D351FCBB57F8@pp.inet.fi> <20070804065516.GS20052@spearce.org> <20070804071131.GA6557@coredump.intra.peff.net> <20070804073321.GU20052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?B?VuRpbvYgSuRydmVs5A==?= <v@pp.inet.fi>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 09:41:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHEGp-0003ZS-A9
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 09:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590AbXHDHlx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 03:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755525AbXHDHlw
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 03:41:52 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3365 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755463AbXHDHlw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 03:41:52 -0400
Received: (qmail 26832 invoked from network); 4 Aug 2007 07:41:55 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 4 Aug 2007 07:41:55 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Aug 2007 03:41:50 -0400
Content-Disposition: inline
In-Reply-To: <20070804073321.GU20052@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54811>

On Sat, Aug 04, 2007 at 03:33:21AM -0400, Shawn O. Pearce wrote:

> My mutt-foo isn't very good.  I tried to tell it utf-8, but I think
> its ignoring me:
> 
>   set allow_8bit=yes
>   set charset=utf8

Try looking at the send_charset config option; by default mutt will try
to send us-ascii if possible. Also, should it be "utf-8"?

> I just tried to reproduce it myself and I can't do whatever I did
> before again now; it Just Works(tm).  *sigh*  No idea how I messed
> the patch application up earlier, but I did.

OK, given that I couldn't reproduce it either, we should perhaps chalk
it up to cosmic rays.

-Peff
