From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: How do I qualify paths in the .gitignore file w.r.t. the repo
  root directory?
Date: Wed, 25 Feb 2009 04:01:58 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngq9glm.l8b.sitaramc@sitaramc.homelinux.net>
References: <e38bce640902232247t63a37f63x9f403fbda0744cfd@mail.gmail.com>
 <7v1vtomhz1.fsf@gitster.siamese.dyndns.org>
 <e38bce640902241714s720a4e23v49e0a4ab22da9bde@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 05:03:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcAzv-0002Uq-LV
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 05:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512AbZBYECL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 23:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753453AbZBYECL
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 23:02:11 -0500
Received: from main.gmane.org ([80.91.229.2]:35751 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753449AbZBYECK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 23:02:10 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LcAyF-0007EP-Rl
	for git@vger.kernel.org; Wed, 25 Feb 2009 04:02:07 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 04:02:07 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 04:02:07 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111370>

On 2009-02-25, Brent Goodrick <bgoodr@gmail.com> wrote:
> apparently such is not the case with git (and I conclude from this
> that it is actually not possible to store fully qualified paths
> _unless_ the $GIT_DIR is right under the root filesystem).  This isn't
> a problem for me, and probably not for most folks, but it was

I suspect it's not _useful_ also, because it would prevent
you from relocating your git work tree to some other path
while getting predictable results.  I'm unable to think of a
use-case where that would be desirable, but I admit I
haven't thought about it too much.

> confusing to me the way it was written in the man page.

If you could look at either of my two submissions in this
thread, and comment on whether they would have helped you in
this regard, I'd appreciate it very much.

I prefer the second one that I sent, but don't let that
prejudice you ;-)
