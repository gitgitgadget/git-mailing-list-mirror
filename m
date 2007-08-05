From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-clone: use cpio's --quiet flag
Date: Sun, 5 Aug 2007 04:06:51 -0400
Message-ID: <20070805080651.GB10863@coredump.intra.peff.net>
References: <20070804070308.GA6493@coredump.intra.peff.net> <Pine.LNX.4.64.0708041636290.14781@racer.site> <20070804160409.GA16326@sigill.intra.peff.net> <7vwswbgphu.fsf@assigned-by-dhcp.cox.net> <20070804175240.GB17113@sigill.intra.peff.net> <7vps23gnpj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 10:07:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHb8d-0005po-WB
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 10:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755963AbXHEIG4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 04:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756243AbXHEIG4
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 04:06:56 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4761 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754751AbXHEIGy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 04:06:54 -0400
Received: (qmail 14450 invoked from network); 5 Aug 2007 08:06:56 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 5 Aug 2007 08:06:56 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Aug 2007 04:06:51 -0400
Content-Disposition: inline
In-Reply-To: <7vps23gnpj.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54966>

On Sat, Aug 04, 2007 at 11:27:04AM -0700, Junio C Hamano wrote:

> Try cloning across filesystem boundaries so that you do not get
> a hardlink -- you will get block count of the copy ;-)

I see, though the hardlink warning is a bit much.

$ git-clone /path/on/fs/one /path/on/fs/two
Initialized empty Git repository in /path/on/fs/two/.git/
Warning: -l asked but cannot hardlink to /path/on/fs/one/.git
36634 blocks

-Peff
