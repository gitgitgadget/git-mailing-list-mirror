From: Seth Falcon <seth@userprimary.net>
Subject: Re: git-svn and migration
Date: Wed, 19 Dec 2007 13:14:46 -0800
Message-ID: <m28x3qv12x.fsf@userprimary.net>
References: <320075ff0712190849u2c40cc46pf01fa2a75f557482@mail.gmail.com>
	<320075ff0712190850r35263bcfv1d8f84e699208e15@mail.gmail.com>
	<20071219175447.GB15898@dervierte>
	<20071219202333.GD4390@genesis.frugalware.org>
	<320075ff0712191246r46cd76f7r1d8edc1adf35ae57@mail.gmail.com>
	<320075ff0712191247m132ecd95o46a7778d8bd4f42b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: "Nigel Magnay" <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 22:15:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J56G2-0007cS-Oe
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 22:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220AbXLSVOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 16:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753000AbXLSVOv
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 16:14:51 -0500
Received: from qmta06.emeryville.ca.mail.comcast.net ([76.96.30.56]:35159 "EHLO
	QMTA06.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751679AbXLSVOu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2007 16:14:50 -0500
Received: from OMTA10.emeryville.ca.mail.comcast.net ([76.96.30.28])
	by QMTA06.emeryville.ca.mail.comcast.net with comcast
	id SlDL1Y0010cQ2SL0A00E00; Wed, 19 Dec 2007 21:14:55 +0000
Received: from ziti.local ([69.17.40.82])
	by OMTA10.emeryville.ca.mail.comcast.net with comcast
	id SlEt1Y00H1mMH6D8W00000; Wed, 19 Dec 2007 21:14:55 +0000
X-Authority-Analysis: v=1.0 c=1 a=Z4mJgif-AAAA:8 a=OaBim6T8yWDOUFZ9tAYA:9 a=N3byJWunjKYbr4TcofEEZq8RUkEA:4 a=MSl-tDqOz04A:10 a=F-J2dRE9H3gA:10 a=5nwwK3GRrp0A:10
In-Reply-To: <320075ff0712191247m132ecd95o46a7778d8bd4f42b@mail.gmail.com> (Nigel Magnay's message of "Wed\, 19 Dec 2007 20\:47\:24 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68939>

"Nigel Magnay" <nigel.magnay@gmail.com> writes:

> I was prepared to put up with it not being a bare repository (asides
> the extra /.git/ in the URL it's pretty much the same).
>
> On the git host I'd set refs/heads/trunk to be
>  ref: refs/remotes/svn/trunk
>
> And I'm hoping that a cron of git svn fetch ; git-update-server-info
> will do the trick.  It appeared to keep it in sync when I fetch
> downstream. I don't know if I'm being naive though expecting that to
> work as I don't grok all that git-svn needs to work properly - but I'm
> working on it ;-)
>
> My current plan is for developers to push/pull to git to share amongst
> the git-devs, and to push to svn when wanting to share with everyone
> else..
>
> [svn user] ---(ci/co)--->[svn] --pull--> [git]
>                             ^               ^
>                            |               |
>                           push          push/pull
>                             |               |
>                            ---[git user]----

I suspect having the git users push/fetch only from svn
would be more reliable.  Won't there be problems if git users
do merges and push to the git repo?

Also, seems like it makes the transition more complicateds for git
users since they have to figure out git-svn _and_ the git push/pull.

Perhaps avoid the central git repo until everyone is on git.  Then
people have to learn not to use git-svn and to use push/pull instead.

My $0.02

+ seth

-- 
Seth Falcon | seth@userprimary.net | blog: http://userprimary.net/user/
