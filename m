From: Marko Vukovic <amasniko@yahoo.com>
Subject: Re: Core dump on commit
Date: Mon, 15 Aug 2011 16:09:11 +0000 (UTC)
Message-ID: <loom.20110815T180732-236@post.gmane.org>
References: <loom.20110815T162144-798@post.gmane.org> <CACsJy8AL5D938HA-sQkFkn_d9xuT2Vw8BKfD-h+V=iEkNrS1eA@mail.gmail.com> <loom.20110815T172423-956@post.gmane.org> <CACsJy8BBvgJauL4a9MxWAXGN-_qiAKprt15hizyBp0O9knwKrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 18:09:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QszjI-0002us-VU
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 18:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005Ab1HOQJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Aug 2011 12:09:28 -0400
Received: from lo.gmane.org ([80.91.229.12]:54545 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817Ab1HOQJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 12:09:27 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QszjC-0002p8-9y
	for git@vger.kernel.org; Mon, 15 Aug 2011 18:09:26 +0200
Received: from CPE30469afe6059-CM001ceab6184c.cpe.net.cable.rogers.com ([174.112.73.117])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Aug 2011 18:09:26 +0200
Received: from amasniko by CPE30469afe6059-CM001ceab6184c.cpe.net.cable.rogers.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Aug 2011 18:09:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 174.112.73.117 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110621 Fedora/3.6.18-1.fc14 Firefox/3.6.18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179379>

Nguyen Thai Ngoc Duy <pclouds <at> gmail.com> writes:

> I should have written "git reset --soft 1b9a976133", which resets HEAD
> ref back to (assuming) good commit. See [1] for more information. I
> think for some reason, eGit put a tag object to HEAD, while it should
> be a commit object. By resetting it back to the commit that the tag
> points to, you may be able to commit again.
> 
> No history would be lost. Also if you use --soft, index should be
> untouched. As always, back up your repository (copy the whole
> directory, including .git) before doing anything.
> 
> [1] http://www.kernel.org/pub/software/scm/git/docs/git-reset.html

Thank you very much, I was able to commit after the reset.

I shall remember never to use eGit for tagging in the future!
