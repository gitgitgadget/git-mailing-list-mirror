From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Oct 2009, #02; Sun, 11)
Date: Mon, 12 Oct 2009 01:14:42 -0400
Message-ID: <20091012051442.GB23007@coredump.intra.peff.net>
References: <7vfx9pmhae.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 07:18:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxDIM-0005lU-7C
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 07:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbZJLFPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 01:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbZJLFPT
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 01:15:19 -0400
Received: from peff.net ([208.65.91.99]:38476 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751648AbZJLFPS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 01:15:18 -0400
Received: (qmail 1226 invoked by uid 107); 12 Oct 2009 05:18:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 12 Oct 2009 01:18:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Oct 2009 01:14:42 -0400
Content-Disposition: inline
In-Reply-To: <7vfx9pmhae.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129978>

On Sun, Oct 11, 2009 at 08:18:17PM -0700, Junio C Hamano wrote:

> * jk/1.7.0-status (2009-09-05) 5 commits.
>  - docs: note that status configuration affects only long format
>   (merged to 'next' on 2009-10-11 at 65c8513)
>  + commit: support alternate status formats
>  + status: add --porcelain output format
>  + status: refactor format option parsing
>  + status: refactor short-mode printing to its own function
>  (this branch uses jc/1.7.0-status.)
> 
> Gives the --short output format to post 1.7.0 "git commit --dry-run" that
> is similar to that of post 1.7.0 "git status".
> 
> * jc/1.7.0-status (2009-09-05) 4 commits.
>   (merged to 'next' on 2009-10-11 at 9558627)
>  + status: typo fix in usage
>  + git status: not "commit --dry-run" anymore
>  + git stat -s: short status output
>  + git stat: the beginning of "status that is not a dry-run of commit"
>  (this branch is used by jk/1.7.0-status.)
> 
> With this, "git status" is no longer "git commit --dry-run".

Hmm. I thought you wanted to re-order some of these for to put the
porcelain and short formats into v1.6.6, but leave the status switchover
for v1.7.0.

We can always revert selectively, but I though the post-v1.6.5 rewind
would be a good time to re-order.

-Peff
