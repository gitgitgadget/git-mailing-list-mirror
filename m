From: Jeff King <peff@peff.net>
Subject: Re: [PATCH next] branch.c: if remote is not config'd for branch,
 don't try delete push config
Date: Fri, 17 Jul 2009 18:04:04 -0400
Message-ID: <20090717220404.GA32214@coredump.intra.peff.net>
References: <W0GiRm9n1NEO0ox1puhqZPKGDpWW0rbH6Cp2gxr7ofSuhyo4HCl88lyU5dRIkYdZUK1rEnxQExw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>, bonzini@gnu.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Jul 18 00:04:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRvXQ-00031P-9x
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 00:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757911AbZGQWEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 18:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757905AbZGQWEK
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 18:04:10 -0400
Received: from peff.net ([208.65.91.99]:46899 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757904AbZGQWEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 18:04:09 -0400
Received: (qmail 29450 invoked by uid 107); 17 Jul 2009 22:06:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 17 Jul 2009 18:06:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Jul 2009 18:04:04 -0400
Content-Disposition: inline
In-Reply-To: <W0GiRm9n1NEO0ox1puhqZPKGDpWW0rbH6Cp2gxr7ofSuhyo4HCl88lyU5dRIkYdZUK1rEnxQExw@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123493>

On Thu, Jul 16, 2009 at 04:26:15PM -0500, Brandon Casey wrote:

> So check whether branch->remote_name is non-NULL before trying to use it.

Thanks, my Solaris autobuild detected this last night. I bisected it to
4f67cc0, and I can confirm that your patch fixes it.

-Peff
