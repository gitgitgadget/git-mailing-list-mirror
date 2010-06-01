From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: Recovering from commit --amend in rebase --interactive
Date: Tue, 1 Jun 2010 11:57:55 +0200
Message-ID: <20100601115755.04ff4a0d@jk.gs>
References: <alpine.DEB.2.00.1006011022030.2352@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Jun 01 11:58:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJOEX-0002r6-NA
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 11:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300Ab0FAJ57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 05:57:59 -0400
Received: from zoidberg.org ([88.198.6.61]:48372 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751783Ab0FAJ56 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 05:57:58 -0400
Received: from jk.gs (xdsl-78-35-142-177.netcologne.de [::ffff:78.35.142.177])
  (AUTH: LOGIN jast, SSL: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Tue, 01 Jun 2010 11:57:56 +0200
  id 004DC3BC.4C04D9A5.000053E7
In-Reply-To: <alpine.DEB.2.00.1006011022030.2352@ds9.cixit.se>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148106>

Peter Krefting <peter@softwolves.pp.se> wrote:

> Last time this happened to me, I *did* notice my mistake as I entered
> the editor, since it came up with the previous commit's message.
> However, as the commit message file was in a good shape, I found no
> way to break out of the amend.

It might be easy to miss, but it's there, right in the editor:

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and *an empty message aborts the commit*.
(Emphasis added)

In general, it might be helpful to warn very loudly upon doing a commit
--amend after fixing conflicts, but an implementation would probably be
ugly and for all I know, there might be people who frequently cause
conflicts while amending; those guys would probably be quite annoyed at
such a warning.

-Jan
