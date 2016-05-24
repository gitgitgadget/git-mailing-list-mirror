From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Please add a git config option to make --show-signature the
 default
Date: Tue, 24 May 2016 13:20:27 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605241313440.4449@virtualbox>
References: <57438568.60707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Austin English <austinenglish@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 24 13:29:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5AWP-00059l-QS
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 13:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832AbcEXL3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 07:29:09 -0400
Received: from mout.gmx.net ([212.227.15.18]:52013 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751581AbcEXL3H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 07:29:07 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M7pDs-1bRM6B0RMG-00vQx2; Tue, 24 May 2016 13:29:03
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <57438568.60707@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Z7PUe8rLQHP37Xt7pevMpRnOeFS7azpLsr0j18dnl//QBo5TteN
 r+3dA8Fd6eWU2BIGiDK/mgiMNPVAsOoL2Vtdrv1PYGMKPYut6cfRqLzGa57q2ISU1PBbGhc
 hkG9WxAZ+cNpNZZAOawvNNype8lqz7ZeoL4E0rJmt10CM8lBJtr2lmXLvbpODAGfLEkVYVU
 6Nps+EkwrrrIWfz+yYLUw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IpVuFJFRoRo=:MtUbqniR9KfKFDO1P944dG
 3DRLpqSpIUtREnnKHbwIDCfiP40pErVCbxR27QPSvfltdnsCkcVmvNJOkv7pVNMpjpkmuyE2E
 MZ9x2LHI6RJoCPnHd0v7L/VUgNDPRf/1ahdMyzamxiLNoYCrnS9ZkHEtf9sR50yRnvVEAtQNG
 ITDEjB+xiaEcxBAs2ZbQ3kA/OfOZosNNDWordLe3jiz6nQOYrbpeOnvSubTvOWdtGyBwWvNxI
 wPsZEXxSgXtZ0fAUfG3MK3/JRz4IcCBtqUDzBkG49OOG5nomOaaVYUhyVzHB5oELMS1OlUJP/
 khmpR6U12tNNYTHRslyNgjT9kQYbW42MJREpvsqmeNVKpAsZSDAwXpSZkIIVNWcKYehWLTW/Q
 nhZnvaSLSNiQOQGTdRuWlqyFN44oLpD/bgwCgjo3JVb/sDz9l9tNHNFj++9J2j6xzMmbwQJK0
 ElJydJFvhTMGuYgrcPYhFB8uc+aLqHUR9nszZJrpqtuadaa9K0rTJXDAdbqJ9YL4EpiRABUT3
 JA9/tYVvSSUKEW+Jx14ya+j7Ju5ixGI6AOYhUbkCK6Fvx2OywF4YO58Qda0h5+peL+N8fp9J5
 j+sAYQIc3UlpOxigj7wQqWvKN2pJlvAgUC94Vxgz4/5+EtN1aDzpAhIR0ioXx1Qlp5Y5Lnwrv
 pTMn4JEVSOUxW14x3EJLX13VmKSqz1j5d8Jn+34aJPKhPhjaTpaV9sA/x3rGwSE7aaJhJEIue
 3K1/RRmpEBrJst5q6az1USe8+EH647JUl8ENpru3eSTD+eNTyLekcRerU69shZU/gETxw2+V 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295487>

Hi Austin,

On Mon, 23 May 2016, Austin English wrote:

> As stated in title, I'd like to see an option to enable GPG signature
> by default.

I see an option was mentioned in the mail's subject line, but no
indication which command you want to assume implicitly that this option
was passed.

Care to elaborate?

> I find this feature very useful and would like to enable it by default
> on my machine, without having to resort to an alias in my ~/.bash_rc.

You probably meant $HOME/.bashrc.

> I asked in #git and checked the git repo, but I didn't see an option
> listed for this.

Since you are already a Git user, why not just use Git itself to
investigate further? It is easy:

1. clone https://github.com/git/git
2. run `git grep show-signature` to figure out where this option is handled
3. open the corresponding file and find out where the flag is stored
4. use `git grep` again to determine whether there is another way to set
   that flag

If there is no other way, why not go the whole nine yards and just come up
with a patch? That is how many, many other improvements were made: users
wanted a certain feature and then just went ahead and made it all happen.

You will find it a rewarding experience, and you will also find that you
will receive excellent help on this mailing list when you demonstrate your
willingness to invest some of your own time into that project.

Ciao,
Johannes
