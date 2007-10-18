From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Cloning an StGit repository
Date: Thu, 18 Oct 2007 14:51:32 +0200
Message-ID: <20071018125132.GA5403@diana.vm.bytemark.co.uk>
References: <64de5c8b0710180456x24031754od7062d504e72b215@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Rajkumar S <rajkumars@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 14:52:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiUr1-0002cS-MU
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 14:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756745AbXJRMvt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Oct 2007 08:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756842AbXJRMvs
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 08:51:48 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2244 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754255AbXJRMvr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 08:51:47 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IiUqb-0001TU-00; Thu, 18 Oct 2007 13:51:33 +0100
Content-Disposition: inline
In-Reply-To: <64de5c8b0710180456x24031754od7062d504e72b215@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61526>

On 2007-10-18 17:26:48 +0530, Rajkumar S wrote:

> git --bare fetch ../stg_branch my_branch02:my_branch02
> my_branch02:my_branch02 my_branch01:my_branch01  master:master
[...]
> It says
> * refs/heads/my_branch02: not updating to non-fast forward branch
> 'my_branch02' of ../stg_branch
>
> my_branch02 is the StGit managed branch from stg_branch, other
> normal branchs are getting merged. Since this is StGit managed, fast
> forward merge is not possible, I guess. So how can I pull in the
> StGit managed changes to web.git repository?

Either prefix each of the refspects with a + (as in
+my_branch01:my_branch01), or use the -f flag (which has the same
effect as using + on all the refspecs). This will allow the refs to be
overwritten even if it's not a fast-forward.

You have to do this with StGit-managed branches, since StGit is
essentially just a convenient way to rebase commits.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
