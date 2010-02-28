From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] Add commit log message spell checking feature.
Date: Sun, 28 Feb 2010 11:33:39 -0500
Message-ID: <20100228163339.GA9399@coredump.intra.peff.net>
References: <alpine.LNX.2.00.1002281258340.15334@vqena.qenxr.bet.am>
 <7e21d6cd64aa088763c3ff11d6cbe78899ae7f10.1267314986.git.sdrake@xnet.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Steven Drake <sdrake@xnet.co.nz>
X-From: git-owner@vger.kernel.org Sun Feb 28 17:33:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nlm5V-0002ik-T2
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 17:33:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030369Ab0B1Qdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 11:33:45 -0500
Received: from peff.net ([208.65.91.99]:55106 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030247Ab0B1Qdo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 11:33:44 -0500
Received: (qmail 30071 invoked by uid 107); 28 Feb 2010 16:34:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 28 Feb 2010 11:34:02 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Feb 2010 11:33:39 -0500
Content-Disposition: inline
In-Reply-To: <7e21d6cd64aa088763c3ff11d6cbe78899ae7f10.1267314986.git.sdrake@xnet.co.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141256>

On Sun, Feb 28, 2010 at 01:03:00PM +1300, Steven Drake wrote:

> Add 'git commit --spell' to run a spell checker on commit log message.
> The `commit.spell` configuration variable can be used to enable the spell
> checker by default and can be turned off by '--no-spell'.

Isn't this exactly the sort of thing the commit-msg hook is for? Though
personally I would probably just invoke interactive spell-checking from
the editor.

-Peff
