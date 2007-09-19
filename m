From: David Kastrup <dak@gnu.org>
Subject: Re: Side-by-side diff and patch visualization
Date: Wed, 19 Sep 2007 14:23:50 +0200
Message-ID: <86y7f22695.fsf@lola.quinscape.zz>
References: <A92611E8-1035-46A6-AFEF-9C8A6F93AFB1@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 19 14:39:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXypT-0005XI-3F
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 14:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756744AbXISMie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 08:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755104AbXISMie
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 08:38:34 -0400
Received: from main.gmane.org ([80.91.229.2]:36976 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754950AbXISMid (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 08:38:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IXydx-0005wi-Nx
	for git@vger.kernel.org; Wed, 19 Sep 2007 14:27:01 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 19 Sep 2007 14:27:01 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 19 Sep 2007 14:27:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:sSR06m+vEpWqEngnlpYQeu1uBSA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58708>

Wincent Colaiuta <win@wincent.com> writes:

> Does anybody know of any tools for doing side-by-side visualizations
> of diffs and patches which work well with Git?
>
> So, can anyone recommend a tool which can do this kind of side-by- 
> side visualization and plays nicely with Git?

I use M-x ediff-revision RET in Emacs for this.  There is also M-x
smerge-ediff RET for resolving a file with merge conflict markers, and
M-x ediff-merge-revisions-with-ancestor RET.

The side-by-side layout is chosen by typing | into the control window
for the merge.

Looking at a patch in respect of two versions can be done with M-x
ediff-patch-file RET.

-- 
David Kastrup
