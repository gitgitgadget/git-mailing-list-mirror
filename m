From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] builtin-commit: avoid always using reduce_heads()
Date: Fri, 3 Oct 2008 07:59:15 -0700
Message-ID: <20081003145915.GB3291@spearce.org>
References: <20081003023518.GA3291@spearce.org> <1223035487-2576-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: SZEDER Gabor <szeder@ira.uka.de>, jnareb@gmail.com,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Oct 03 17:01:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Klm8w-0005Ug-Ar
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 17:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbYJCO7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 10:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbYJCO7R
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 10:59:17 -0400
Received: from george.spearce.org ([209.20.77.23]:56100 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbYJCO7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 10:59:16 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9E2E83835F; Fri,  3 Oct 2008 14:59:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1223035487-2576-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97430>

Miklos Vajna <vmiklos@frugalware.org> wrote:
> In case git merge --no-ff is used with --no-commit or we have a
> conflict, write info about if fast forwards are allowed or not to
> $GIT_DIR/MERGE_MODE.

*sigh*

$ git co -b mv/merge-noff master && git am -s <this
$ make test
...
*** t0004-unwritable.sh ***
* FAIL 1: setup
...

$ cd t && ./t0004-unwritable.sh -i -v
...
./test-lib.sh: line 237:   362 Segmentation fault      git commit -m initial
* FAIL 1: setup


I leave the debugging to you.  ;-)
 
-- 
Shawn.
