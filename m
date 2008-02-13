From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add--interactive: handle initial commit better
Date: Wed, 13 Feb 2008 08:15:23 -0500
Message-ID: <20080213131523.GA3266@coredump.intra.peff.net>
References: <C50196C5-B0C5-4536-AD4A-0F9C553782EE@gmail.com> <20080213101649.GA18444@coredump.intra.peff.net> <20080213105051.GA26522@coredump.intra.peff.net> <20080213112504.GA26627@coredump.intra.peff.net> <alpine.LSU.1.00.0802131213270.30505@racer.site> <m3fxvxc87u.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Rhodes, Kate" <masukomi@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 14:16:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPHT0-0002Pl-RU
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 14:16:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbYBMNP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 08:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbYBMNP1
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 08:15:27 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2756 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbYBMNP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 08:15:27 -0500
Received: (qmail 15444 invoked by uid 111); 13 Feb 2008 13:15:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 13 Feb 2008 08:15:24 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Feb 2008 08:15:23 -0500
Content-Disposition: inline
In-Reply-To: <m3fxvxc87u.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73786>

On Wed, Feb 13, 2008 at 05:11:10AM -0800, Jakub Narebski wrote:

> > Heh.  This is cute.  But it is also a bit hard to reference, no?  I mean, 
> > you have to remember the SHA-1 of it...
> > 
> > Maybe {} ?
> 
> Or NULL? You can do this even without modifying git code, I think, by
> adding refs/NULL with appropriate sha-1...

You still need my patch, unless you want to create the empty tree object
in the databsae. The existence of the object and its name are separate.
If you want to add a magic ref or syntax that maps to the correct SHA-1,
then that makes sense to me.

-Peff
