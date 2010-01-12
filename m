From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Display author and committer after "git commit"
Date: Tue, 12 Jan 2010 10:36:56 -0500
Message-ID: <20100112153656.GA24840@coredump.intra.peff.net>
References: <fabb9a1e1001041232h4e5827d1pb5c648b33ecfb5ce@mail.gmail.com>
 <xuu2zl4tfuij.fsf@nowhere.com>
 <20100106073806.6117@nanako3.lavabit.com>
 <7v4omz17xz.fsf@alter.siamese.dyndns.org>
 <xuu28wc9xd42.fsf@nowhere.com>
 <7vskagh9fg.fsf@alter.siamese.dyndns.org>
 <xuu2fx6d9rzb.fsf_-_@nowhere.com>
 <7vzl4lw160.fsf@alter.siamese.dyndns.org>
 <xuu2zl4kks3s.fsf@nowhere.com>
 <20100112142405.GA13369@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adam Megacz <adam@megacz.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 16:37:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUiny-0003PS-Rc
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 16:37:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089Ab0ALPhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 10:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694Ab0ALPhH
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 10:37:07 -0500
Received: from peff.net ([208.65.91.99]:51345 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929Ab0ALPhG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 10:37:06 -0500
Received: (qmail 7892 invoked by uid 107); 12 Jan 2010 15:41:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 12 Jan 2010 10:41:54 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jan 2010 10:36:56 -0500
Content-Disposition: inline
In-Reply-To: <20100112142405.GA13369@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136723>

On Tue, Jan 12, 2010 at 09:24:05AM -0500, Jeff King wrote:

> But I don't understand why the original patch needed to touch anything
> outside of builtin-commit.c:print_summary. Something like this should
> work (though see below for why it isn't ready for inclusion):

Well, I had originally meant to send this off and try to convince Adam
to fix it up for inclusion, but it seemed easy enough so I just went
ahead and did it.

  [1/3]: strbuf_expand: convert "%%" to "%"
  [2/3]: strbuf: add strbuf_percentquote_buf
  [3/3]: commit: show interesting ident information in summary

-Peff
