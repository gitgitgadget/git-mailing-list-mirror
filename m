From: Jeff King <peff@peff.net>
Subject: Re: git hooks to run something
Date: Wed, 25 Mar 2009 07:25:08 -0400
Message-ID: <20090325112507.GA4437@coredump.intra.peff.net>
References: <556d90580903240356q3a72fd0bwa5ebe335914bc469@mail.gmail.com> <20090324111524.GA6291@coredump.intra.peff.net> <556d90580903250333l496520ao5fde64fb08faf9ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alf Clement <alf.clement@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 12:27:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmRG1-0000yQ-IB
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 12:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277AbZCYLZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 07:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753229AbZCYLZV
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 07:25:21 -0400
Received: from peff.net ([208.65.91.99]:34765 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751591AbZCYLZT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 07:25:19 -0400
Received: (qmail 6250 invoked by uid 107); 25 Mar 2009 11:25:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 25 Mar 2009 07:25:30 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Mar 2009 07:25:08 -0400
Content-Disposition: inline
In-Reply-To: <556d90580903250333l496520ao5fde64fb08faf9ae@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114588>

[re-adding git@vger to cc; please keep questions on-list so that others
can also help to answer]

On Wed, Mar 25, 2009 at 11:33:39AM +0100, Alf Clement wrote:

> is there a way to push a modified hook script with the repository when
> I push it to a server?
> And how to get it with pull?

No; for security reasons, no code (including hooks) from remote
repositories is automatically run. The usual method is to include the
hook in your repository and copy it into place after cloning.

-Peff
