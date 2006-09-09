From: Jeff King <peff@peff.net>
Subject: Re: Change set based shallow clone
Date: Sat, 9 Sep 2006 17:14:20 -0400
Message-ID: <20060909211420.GA17339@coredump.intra.peff.net>
References: <17666.4936.894588.825011@cargo.ozlabs.ibm.com> <Pine.LNX.4.64.0609081944060.27779@g5.osdl.org> <17666.13716.401727.601933@cargo.ozlabs.ibm.com> <Pine.LNX.4.64.0609082054560.27779@g5.osdl.org> <e5bfff550609090147q37d61f37j9c3e8ae6d3a0cf35@mail.gmail.com> <Pine.LNX.4.64.0609091022360.27779@g5.osdl.org> <e5bfff550609091104s3709b82fld3057a07a84ae857@mail.gmail.com> <Pine.LNX.4.64.0609091256110.27779@g5.osdl.org> <20060909204307.GB16906@coredump.intra.peff.net> <7v4pvgwxrc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 09 23:14:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMA9i-0001iM-K3
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 23:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWIIVOX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 17:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWIIVOX
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 17:14:23 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:32166 "HELO
	peff.net") by vger.kernel.org with SMTP id S964867AbWIIVOW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Sep 2006 17:14:22 -0400
Received: (qmail 15736 invoked from network); 9 Sep 2006 17:13:47 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 9 Sep 2006 17:13:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat,  9 Sep 2006 17:14:20 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4pvgwxrc.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26767>

On Sat, Sep 09, 2006 at 02:11:51PM -0700, Junio C Hamano wrote:

> The trouble Linus illustrated is that in a global project you
> cannot rely on timestamps always being correct.  You can use
> them as HINT, but you need to be prepared to do sensible things
> when some people screw up the time.

Right, I forgot about the unreliability of the timestamps. Thanks for
the explanation!

-Peff
