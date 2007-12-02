From: Michael Gebetsroither <gebi@sbox.tugraz.at>
Subject: Re: Corrupted (?) commit 6e6db85e confusing gitk
Date: Sun, 2 Dec 2007 23:59:22 +0100
Organization: www.grml.org
Message-ID: <fivdfu$smr$1@ger.gmane.org>
References: <5F1A20CC-7427-4E7A-AB95-E89C9FA17951@zib.de> <7vir3hx70y.fsf@gitster.siamese.dyndns.org> <20071202193918.GQ6212@lavos.net> <7vmyssvn55.fsf@gitster.siamese.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 03 00:02:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iyxpj-0004sD-7e
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 00:02:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbXLBXCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 18:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbXLBXCW
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 18:02:22 -0500
Received: from main.gmane.org ([80.91.229.2]:60927 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751355AbXLBXCV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 18:02:21 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Iyxon-0006ka-SF
	for git@vger.kernel.org; Sun, 02 Dec 2007 23:01:45 +0000
Received: from 84.119.5.147 ([84.119.5.147])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Dec 2007 23:01:45 +0000
Received: from gebi by 84.119.5.147 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Dec 2007 23:01:45 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 84.119.5.147
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66832>

* Junio C Hamano <gitster@pobox.com> wrote:

> Yeah, that change does look like a hack now we look at it again.  It
> would have been much cleaner to make the caller accept the default
> behaviour of fmt_ident() and strip out the part it does not want from
> the result.  That way, the damage would have been much contained.

Last hg2git from repo.or.cz does it (it uses git-fast-import).

Just tried to convert lastes mercurial repos to git and the resulting
git repos can't be displayed with gitk.

git fsck --full gives many "bad commit date in xxxx"

% git cat-file commit f7900d59930d796c4739452cf68ca9c08a921b5d | sed
% '/^$/,//d'
tree 4fb3636148433dcd368fc2dfa20247cb281e2ff8
parent 6ea0491f4ebb13003d15c6fc478d92cbe1201902
author Mathieu Clabaut <mathieu.clabaut@gmail.com> <"Mathieu Clabaut
<mathieu.clabaut@gmail.com>"> 1153937514 +0200
committer Mathieu Clabaut <mathieu.clabaut@gmail.com> <"Mathieu Clabaut
<mathieu.clabaut@gmail.com>"> 1153937514 +0200

But the new hg2git is _amazingly_ fast, converts the whole mercurial
repos got git in just 1min :).

cu,
michael
-- 
It's already too late!
