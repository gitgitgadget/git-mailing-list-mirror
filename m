From: Dale Rowley <ddrowley3@juno.com>
Subject: Re: unexpected git-merge result
Date: Mon, 22 Feb 2010 17:24:33 +0000 (UTC)
Message-ID: <loom.20100222T173851-763@post.gmane.org>
References: <loom.20100219T202452-35@post.gmane.org> <7vaav4amjj.fsf@alter.siamese.dyndns.org> <loom.20100220T031401-572@post.gmane.org> <20100222054425.GC10191@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 18:24:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njc1c-0004DL-Tj
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 18:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365Ab0BVRYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 12:24:48 -0500
Received: from lo.gmane.org ([80.91.229.12]:42958 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752020Ab0BVRYr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 12:24:47 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Njc1U-0004AY-Ju
	for git@vger.kernel.org; Mon, 22 Feb 2010 18:24:44 +0100
Received: from proxy2b.external.lmco.com ([192.91.147.35])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 18:24:44 +0100
Received: from ddrowley3 by proxy2b.external.lmco.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 18:24:44 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 192.91.147.35 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.11) Gecko/2009060200 SUSE/3.0.11-5.2 Firefox/3.0.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140697>

Dmitry Potapov <dpotapov <at> gmail.com> writes:

> > 
> > G only removed a few of the lines that were brought over in the cherry-pick
> > (D'), so it was surprising when they re-appeared in H. 
> 
> git merge does 3-way merge, which means that it does not look at whole
> history but only on the current state and the merge base.

Yes, but my point is that this is the wrong thing to do in the case that I
described above. If you explicitly remove some content in your branch, then it's
bad when a merge causes it to re-appear without even any conflicts. The opposite
is also possible (you add content to your branch and it silently disappears
during a merge), so shouldn't this be a big concern?
