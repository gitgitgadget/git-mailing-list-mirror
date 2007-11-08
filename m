From: Jeff King <peff@peff.net>
Subject: Re: [PATCH amend] git-mailsplit: with maildirs not only process
	cur/, but also new/
Date: Wed, 7 Nov 2007 21:31:10 -0500
Message-ID: <20071108023109.GA3564@sigill.intra.peff.net>
References: <20071026141539.29928.qmail@d3691352d65cf2.315fe32.mid.smarden.org> <20071026160118.GA5076@ferdyx.org> <20071105124920.17726.qmail@746e9cce42b49f.315fe32.mid.smarden.org> <20071105225258.GC4208@steel.home> <20071106085418.14211.qmail@54d7c9212e25c5.315fe32.mid.smarden.org> <7vfxzh7ajt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, Gerrit Pape <pape@smarden.org>,
	"Fernando J. Pereda" <ferdy@gentoo.org>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 03:31:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpxBA-00015G-1T
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 03:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754954AbXKHCbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 21:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754412AbXKHCbU
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 21:31:20 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1824 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754096AbXKHCbU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 21:31:20 -0500
Received: (qmail 10819 invoked by uid 111); 8 Nov 2007 02:31:15 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 07 Nov 2007 21:31:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Nov 2007 21:31:10 -0500
Content-Disposition: inline
In-Reply-To: <7vfxzh7ajt.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63925>

On Wed, Nov 07, 2007 at 06:09:26PM -0800, Junio C Hamano wrote:

> > When saving patches to a maildir with e.g. mutt, the files are put into
> > the new/ subdirectory of the maildir, not cur/.  This makes git-am state
> > "Nothing to do.".  This patch lets git-mailsplit additional check new/
> > after reading cur/.
> 
> Looks good to me.  Final acks please?

Fixed my concerns.

Acked-by: Jeff King <peff@peff.net>

-Peff
