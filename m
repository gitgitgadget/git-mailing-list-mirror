From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Port git-tag.sh to C.
Date: Sun, 10 Jun 2007 18:13:06 -0400
Message-ID: <20070610221306.GF27340@coredump.intra.peff.net>
References: <11813427591137-git-send-email-krh@redhat.com> <7v7iqdf0gn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 00:13:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxVep-0003Eq-KY
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 00:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755112AbXFJWNJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 10 Jun 2007 18:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758102AbXFJWNJ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 18:13:09 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2879 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755112AbXFJWNI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 18:13:08 -0400
Received: (qmail 23692 invoked from network); 10 Jun 2007 22:13:19 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 10 Jun 2007 22:13:19 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Jun 2007 18:13:06 -0400
Content-Disposition: inline
In-Reply-To: <7v7iqdf0gn.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49780>

On Sat, Jun 09, 2007 at 11:26:48AM -0700, Junio C Hamano wrote:

> > Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
> I think your name in your commit message is in UTF-8 but munged your
> mail was mismarked as iso-8859-1.

This is the same git-send-email bug that we fixed recently (missing
MIME-Version header). Just look for the vger "we munged your message"
headers in the version you received.

-Peff
