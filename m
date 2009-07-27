From: Tobi <listaccount@e-tobi.net>
Subject: Re: git-svn commit count vs- revision count
Date: Tue, 28 Jul 2009 00:13:48 +0200
Message-ID: <4A6E269C.5030605@e-tobi.net>
References: <4A6D6916.2040509@e-tobi.net> <4A6E1647.9090207@e-tobi.net> <4A6E20D2.70200@e-tobi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 00:13:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVYSE-0001E2-Ce
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 00:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676AbZG0WNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 18:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754631AbZG0WNu
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 18:13:50 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:65022 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754596AbZG0WNt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 18:13:49 -0400
Received: from [192.168.30.21] (pD9513A58.dip0.t-ipconnect.de [217.81.58.88])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MKsym-1MVYS42ypW-000YgZ; Tue, 28 Jul 2009 00:13:49 +0200
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
In-Reply-To: <4A6E20D2.70200@e-tobi.net>
X-Provags-ID: V01U2FsdGVkX1/cUSugFrtdIHUJ5DnwlejYZt7oXpLXsI2vnF3
 V3YroCN84uy/ZuGXykXhr9H+pAKmYipwYMGaTHh+T7oLNmMaha
 TvSXNZseGjb525lxyxvzQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124202>

Tobi wrote:

> PS: gitk shows something like "Branches: many (43)" for such commits -
> whatever this means...

PPS: Ok - 1 second of thinking - of course it means, that this commit
belongs to 43 branches and I forgot the "-r" in "git branch --contains".
So all commits belong to branch.

But there are still SVN-Revions with up to 4 commits.

I checked the SVN logs of such revisons and it indeed seems to be the
case, that these revisions update multiple branches. The number of touched
branches per SVN commit still doesn't match the number of git-commits for
this SVN revision, but it at least partially explains the high number of
git commits compared to the svn revision count.

Tobias
