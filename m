From: Junio C Hamano <junkio@cox.net>
Subject: Re: diff machinery cleanup
Date: Thu, 10 Aug 2006 14:02:24 -0700
Message-ID: <7virl0uwwv.fsf@assigned-by-dhcp.cox.net>
References: <20060810082455.GA30739@coredump.intra.peff.net>
	<7vejvpvsni.fsf@assigned-by-dhcp.cox.net>
	<20060810103836.GA1317@coredump.intra.peff.net>
	<7vzmecv7tp.fsf@assigned-by-dhcp.cox.net>
	<20060810201049.GA4759@sigio.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 23:02:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBHg2-0001Gl-8x
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 23:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWHJVC1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 17:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWHJVC1
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 17:02:27 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:40404 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932316AbWHJVCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 17:02:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060810210225.PQLZ6711.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 10 Aug 2006 17:02:25 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060810201049.GA4759@sigio.intra.peff.net> (Jeff King's message
	of "Thu, 10 Aug 2006 16:10:50 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25210>

Jeff King <peff@peff.net> writes:

> Ah, OK, that makes more sense. Is there any reason then that this
> wouldn't work (it certainly seems to, but I don't want to be causing
> invisible problems that will come back later)?

It should.  I wanted to avoid re-reading the index from the
filesystem for some reason I cannot justify anymore.  The
response was sent before my first caffeine for the day, perhaps
that was the reason ;-).
