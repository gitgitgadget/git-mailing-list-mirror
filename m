From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Makefile: create an install-symlinks target
Date: Wed, 18 Jul 2007 14:41:57 +0200
Message-ID: <86y7hdkhnu.fsf@lola.quinscape.zz>
References: <86bqe9lwy8.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 14:49:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB8xr-00053h-5p
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 14:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756555AbXGRMtI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 08:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755223AbXGRMtG
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 08:49:06 -0400
Received: from main.gmane.org ([80.91.229.2]:51131 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753594AbXGRMtF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 08:49:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IB8vp-0005IY-3k
	for git@vger.kernel.org; Wed, 18 Jul 2007 14:47:05 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 14:47:05 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 14:47:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:eqwlNXIMhReCrZmxRMgaOza5pfQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52859>

David Kastrup <dak@gnu.org> writes:

> Use this, for example, to do
> rm -rf /opt/git
> make prefix=/opt/git install
> make symlinkprefix=/usr/local prefix=/opt/git install-symlinks
> ---
>  Makefile |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)

Oh, by the way: I got _crazy_ when I first committed this, then found
a mistake and corrected it, and then repeatedly did
git add config/emacs/Makefile
git-commit --amend

and got the

>  Makefile |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)

message again and again, while nothing at all changed.  Of course,
this was because I added the wrong Makefile.

I am not sure how git could be more helpful here.  Just wanted to
report it.  Maybe it could have noticed that my "amendment" was empty?
On the other hand, I might have wanted to amend the commit message.
Sigh.

-- 
David Kastrup
