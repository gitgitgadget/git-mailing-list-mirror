From: Jeff King <peff@peff.net>
Subject: Re: clone
Date: Mon, 20 Jul 2009 11:24:07 -0400
Message-ID: <20090720152407.GC5347@coredump.intra.peff.net>
References: <D229D90E-0294-475D-B7AC-6C7B23CC169A@roalddevries.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Roald de Vries <rdv@roalddevries.nl>
X-From: git-owner@vger.kernel.org Mon Jul 20 17:24:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSuir-0001eI-Am
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 17:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbZGTPYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 11:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbZGTPYE
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 11:24:04 -0400
Received: from peff.net ([208.65.91.99]:43330 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751787AbZGTPYD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 11:24:03 -0400
Received: (qmail 26666 invoked by uid 107); 20 Jul 2009 15:26:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 20 Jul 2009 11:26:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jul 2009 11:24:07 -0400
Content-Disposition: inline
In-Reply-To: <D229D90E-0294-475D-B7AC-6C7B23CC169A@roalddevries.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123611>

On Mon, Jul 20, 2009 at 04:33:51PM +0200, Roald de Vries wrote:

> If I clone a repository with multiple branches to 'newdir', and then
> type 'git branch' in 'newdir', I see only 1 branch. 'git branch -r'
> gives me all branches. Is that correct behaviour? If so, why? And
> mainly: can I configure git to clone all original branches to non-
> remote branches?

Yes, it's correct. You really only need local branches of things you are
going to work on. And then that happens, you generally would just "git
checkout -b foo origin/foo" to make your own local "foo" branch that you
will be working on (or if you are using topic branches, something more
like "git checkout -b mytopic origin/master"). If you are just
inspecting branches (e.g., checking them out to try building, doing
diffs against them, using them as reference points for logging, etc),
then the remote versions are fine.

-Peff
