From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Submodules
Date: Wed, 8 Aug 2007 21:40:59 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708082138520.21916@wbgn129.biozentrum.uni-wuerzburg.de>
References: <a1bbc6950708071537xfa6b9a0ne8cf66e345fa31b4@mail.gmail.com>
 <Pine.LNX.4.64.0708072349400.14781@racer.site>
 <a1bbc6950708071631w5d232e92gd0fa27158b27b5c3@mail.gmail.com>
 <20070808104117.GK999MdfPADPa@greensroom.kotnet.org> <7vhcn94y9l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: skimo@liacs.nl, Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 21:41:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIrPM-0003Wg-Dd
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 21:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763272AbXHHTlI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 15:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764579AbXHHTlH
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 15:41:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:52229 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760378AbXHHTlF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 15:41:05 -0400
Received: (qmail invoked by alias); 08 Aug 2007 19:41:02 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp053) with SMTP; 08 Aug 2007 21:41:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX195UyJDBXN5J9/EEO7EvumrOI3SAp2OiOeKCYDLLM
	g16QYo4zCghVEt
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vhcn94y9l.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55347>

Hi,

On Wed, 8 Aug 2007, Junio C Hamano wrote:

> +  Note that the current submodule support is minimal and this is
> +  deliberately so.  A design decision we made is that operations
> +  at the supermodule level do not recurse into submodules by
> +  default.  The expectation is that later we would add a
> +  mechanism to tell git which submodules the user is interested
> +  in, and this information might be used to determine the
> +  recursive behaviour of certain commands (e.g. "git checkout"
> +  and "git diff"), but currently we haven't agreed on what that
> +  mechanism should look like.  Therefore, if you use submodules,
> +  you would probably need "git submodule update" on the
> +  submodules you care about after running a "git checkout" at
> +  the supermodule level.
> +

Nice write up!

Is it true that you can run "update" without "init" first?  (I haven't 
tried yet.)

Also, I realised that git is not really happy unless you install 
alternates pointing to the object stores of the submodules.  Shouldn't we 
make this my default (for example in "init")?

Ciao,
Dscho
