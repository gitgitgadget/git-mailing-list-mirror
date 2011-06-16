From: tumik <tumik@tuomisalo.com>
Subject: Re: [git-p4] Trouble importing all perforce branches into git
 repository
Date: Thu, 16 Jun 2011 01:28:26 -0700 (PDT)
Message-ID: <1308212906486-6482174.post@n2.nabble.com>
References: <5A927B4F-7242-48AD-BC1C-BCA490A251C4@gmail.com> <20110522114917.GA19927@arf.padd.com> <398FA881-E4A1-49AC-80F2-2D46E9F2ABB9@gmail.com> <BANLkTi=TCyyS7Q=3BnLcG=yhL_boH=w1XA@mail.gmail.com> <34E33A18-B9C4-4CA9-B96C-79B0E2BDCD44@gmail.com> <BANLkTik+Zp1Fvi_zABCtAZH0RKA68n5Svw@mail.gmail.com> <0AC6DD14-3042-4A18-91AC-1CE77D8B4CD2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 16 10:28:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QX7wH-0004rC-QT
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 10:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086Ab1FPI23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 04:28:29 -0400
Received: from sam.nabble.com ([216.139.236.26]:49558 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751822Ab1FPI21 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 04:28:27 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <tumik@tuomisalo.com>)
	id 1QX7wB-0002Za-33
	for git@vger.kernel.org; Thu, 16 Jun 2011 01:28:27 -0700
In-Reply-To: <0AC6DD14-3042-4A18-91AC-1CE77D8B4CD2@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175886>


Grant Limberg wrote:
> 
> I think I just figured out the problem.  The branch mapping between
> //project/MAIN/... and //project/Branch-foo/... was done backwards, thus
> git-p4 was expecting Branch-foo to be a parent of MAIN when the inverse
> was actually true.
> 

Did you get it working so that the branch integrates at Perforce show up as
merges in git? I have been trying to do this for tens of hours now and just
can't get it working.. I have tried making the branch mapping both ways, and
even both at the same time but with no success.

I have succesfully imported the two testing branches to git, but if I look
at it in gitk for example, the history is linear and there are no merges
from the other branch (it shows up as a normal commit, without the parent
from other branch, just adding all lines that the merging did). in p4v it
shows up as it should!

--
View this message in context: http://git.661346.n2.nabble.com/git-p4-Trouble-importing-all-perforce-branches-into-git-repository-tp6383422p6482174.html
Sent from the git mailing list archive at Nabble.com.
