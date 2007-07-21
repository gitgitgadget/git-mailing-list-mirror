From: Jeff King <peff@peff.net>
Subject: Re: gitk problems: can't unset "idinlist(...)"
Date: Sat, 21 Jul 2007 02:54:05 -0400
Message-ID: <20070721065405.GA9793@coredump.intra.peff.net>
References: <alpine.LFD.0.999.0707201554540.27249@woody.linux-foundation.org> <20070721050912.GB20622@coredump.intra.peff.net> <alpine.LFD.0.999.0707202226130.27249@woody.linux-foundation.org> <alpine.LFD.0.999.0707202304350.27249@woody.linux-foundation.org> <20070721061857.GB29820@coredump.intra.peff.net> <20070721062448.GA8722@coredump.intra.peff.net> <alpine.LFD.0.999.0707202335570.27249@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 21 08:54:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC8r3-0003el-RX
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 08:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755690AbXGUGyL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 02:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755978AbXGUGyK
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 02:54:10 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3183 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753613AbXGUGyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 02:54:09 -0400
Received: (qmail 14575 invoked from network); 21 Jul 2007 06:54:35 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 21 Jul 2007 06:54:35 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Jul 2007 02:54:05 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707202335570.27249@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53149>

On Fri, Jul 20, 2007 at 11:47:24PM -0700, Linus Torvalds wrote:

> So the difference between your version and mine is that the
> 
> 	while ((p = *pp) != NULL)

I actually like your version better (I like saving for loops for
honest-to-god, for-each-element-in-this-list iteration; munging the list
in the middle is something that you _should_ call attention to). I just
found your patch much harder to verify, because I had to make sure the
for/while change was equivalent. So you can blame Junio for writing it
wrong in the first place. :)

Junio, whatever you apply, please credit Linus; he beat me to the fix
and so my patch is completely cribbed from his. :)

-Peff
