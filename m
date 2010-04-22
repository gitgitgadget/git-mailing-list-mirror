From: Jeff King <peff@peff.net>
Subject: Re: git push in --tracked branches.
Date: Wed, 21 Apr 2010 20:44:33 -0400
Message-ID: <20100422004433.GC14249@coredump.intra.peff.net>
References: <y2w3abd05a91004211702qf4cd42bau20ac52a4d35a6bf1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 02:45:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4kXa-0005j4-1i
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 02:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605Ab0DVApH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 20:45:07 -0400
Received: from peff.net ([208.65.91.99]:46132 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753512Ab0DVApG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 20:45:06 -0400
Received: (qmail 24058 invoked by uid 107); 22 Apr 2010 00:45:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 21 Apr 2010 20:45:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Apr 2010 20:44:33 -0400
Content-Disposition: inline
In-Reply-To: <y2w3abd05a91004211702qf4cd42bau20ac52a4d35a6bf1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145487>

On Wed, Apr 21, 2010 at 08:02:49PM -0400, Aghiles wrote:

> So I created a branch that tracks 'origin' which is remote:
> 
>   git checkout -b small_fixes origin
> 
> I can do a 'git pull' and everything works as expected. I did some
> commits in this branch and I issue a 'git push'. To my surprise
> the 'git push' is still operating on the master and not the current
> 'small_fixes' branch! What is the rationale behind this ? I would
> expect to push from my current branch to origin (especially that
> I am --tracking origin).

"git push" will by default push matching refs. This has been the
behavior since day one. See the description of push.default in "git help
config" for other options (I think you want "tracking").

-Peff
