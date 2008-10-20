From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rebase-i-p: only list commits that require rewriting
	in todo
Date: Mon, 20 Oct 2008 07:50:04 -0400
Message-ID: <20081020115003.GA11309@coredump.intra.peff.net>
References: <cover.1224055978.git.stephen@exigencecorp.com> <0977b23f6c709d4aea76de7a88e9fe17272b31ea.1224055978.git.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 18:40:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrtIC-00058I-0z
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 13:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbYJTLuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 07:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbYJTLuI
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 07:50:08 -0400
Received: from peff.net ([208.65.91.99]:3942 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952AbYJTLuH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 07:50:07 -0400
Received: (qmail 12464 invoked by uid 111); 20 Oct 2008 11:50:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 20 Oct 2008 07:50:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Oct 2008 07:50:04 -0400
Content-Disposition: inline
In-Reply-To: <0977b23f6c709d4aea76de7a88e9fe17272b31ea.1224055978.git.stephen@exigencecorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98678>

On Wed, Oct 15, 2008 at 02:44:38AM -0500, Stephen Haberman wrote:

> +					cat "$TODO" | grep -v "${rev:0:7}" > "${TODO}2" ; mv "${TODO}2" "$TODO"

Substring expansion (like ${rev:0:7}) is not portable. At least it
doesn't work on FreeBSD /bin/sh, and "it's not even in POSIX", I
believe.

-Peff
