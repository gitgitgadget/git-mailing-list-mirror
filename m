From: Michael Gebetsroither <gebi@sbox.tugraz.at>
Subject: Re: Getting correct tree layout when importing svn repo into git
Date: Wed, 17 Sep 2008 12:42:08 +0200
Organization: www.grml.org
Message-ID: <gaqmu0$4cf$1@ger.gmane.org>
References: <cfd18e0f0809161505g4c04bd88vaf4fd7c40f67b243@mail.gmail.com> <37fcd2780809161620v38d9ade0sc1a2715f79501c6f@mail.gmail.com> <c49095e30809161640o21cb89b7x17a9ac1b5b18054f@mail.gmail.com> <20080917011816.GL28210@dpotapov.dyndns.org> <c49095e30809162216m5c7885dbibbb022e65f43231c@mail.gmail.com> <48D0AA1A.5060209@op5.se> <cfd18e0f0809170328pb039331m1c4dc42fd398a4d@mail.gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 17 12:43:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfuVP-0005Ad-G9
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 12:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbYIQKmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 06:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752319AbYIQKmW
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 06:42:22 -0400
Received: from main.gmane.org ([80.91.229.2]:41514 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752266AbYIQKmW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 06:42:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KfuUD-0008BG-Bu
	for git@vger.kernel.org; Wed, 17 Sep 2008 10:42:17 +0000
Received: from 84-119-24-190.dynamic.xdsl-line.inode.at ([84.119.24.190])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 10:42:17 +0000
Received: from gebi by 84-119-24-190.dynamic.xdsl-line.inode.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 10:42:17 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 84-119-24-190.dynamic.xdsl-line.inode.at
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96085>

* Michael Kerrisk <mtk.manpages@googlemail.com> wrote:

> But, is it going to make this much difference to the run time?  By
> now, the import using
>
> $ git svn init file:///home/mtk/man-pages-rep/ -t tags -T
> trunk/man-pages -b branches
>
> has been running for over 2 days (and I still don't know if it will
> give the layout I want), and seems to be slowing down exponentially as
> it gets further along in the import process, so at this rate it looks
> like it would take several more days to complete, whereas

git-svn conversions are _much_ faster here if done on tmpfs with
occasional git gc runs (in parallel).

May be the fault of the xfs.

cu,
michael
-- 
It's already too late!
