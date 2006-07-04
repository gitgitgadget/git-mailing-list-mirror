From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-fetch per-repository speed issues
Date: Mon, 3 Jul 2006 22:53:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607032240260.12404@g5.osdl.org>
References: <1151949764.4723.51.camel@neko.keithp.com> 
 <Pine.LNX.4.64.0607031603290.12404@g5.osdl.org>  <1151973438.4723.70.camel@neko.keithp.com>
  <Pine.LNX.4.64.0607032008590.12404@g5.osdl.org>  <1151985747.4723.102.camel@neko.keithp.com>
  <Pine.LNX.4.64.0607032115340.12404@g5.osdl.org> <1151990980.4723.132.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 04 07:53:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxdqs-0006yb-Nx
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 07:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWGDFx1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 01:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWGDFx1
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 01:53:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34731 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751167AbWGDFxZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 01:53:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k645rNnW021029
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 3 Jul 2006 22:53:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k645rMbX019268;
	Mon, 3 Jul 2006 22:53:22 -0700
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <1151990980.4723.132.camel@neko.keithp.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23254>



On Mon, 3 Jul 2006, Keith Packard wrote:
>
>     361 /usr/bin/expr
> 
> someone sure likes 'expr'...

Heh. That's a very Junio thing to do.

Junio seems to like

	if expr "z$string" : "z<regexp>" >/dev/null
	then
		..

and I think he explained it as being the way old-fashioned users do it.

		Linus
	
