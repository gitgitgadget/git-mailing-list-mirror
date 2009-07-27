From: Tobi <listaccount@e-tobi.net>
Subject: Re: git-svn commit count vs- revision count
Date: Mon, 27 Jul 2009 23:04:07 +0200
Message-ID: <4A6E1647.9090207@e-tobi.net>
References: <4A6D6916.2040509@e-tobi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 27 23:04:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVXMr-0000Kz-5X
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 23:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780AbZG0VEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 17:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754709AbZG0VEJ
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 17:04:09 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:65479 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754718AbZG0VEI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 17:04:08 -0400
Received: from [192.168.30.21] (pD9513A58.dip0.t-ipconnect.de [217.81.58.88])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MKsym-1MVXMe02WT-000Z40; Mon, 27 Jul 2009 23:04:08 +0200
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
In-Reply-To: <4A6D6916.2040509@e-tobi.net>
X-Provags-ID: V01U2FsdGVkX1+Oy5WQ/sbNlAoe/7gvniCUCH0GosTVZWhNk+o
 9z3Ty+bYIPIjjT2Q1ki6jp7Cp+kf52OxKL/9ld5HKr/LiIoK/h
 7Ha85CB8pt8QNbnvkv4yQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124194>


> With svn, it is possible to commit to (or create) several branches or
> tags in one go (i.e. revision), whereas with git those would be
> individual commits.

I don't think this explains a difference of about 20000 commits.

> difference, although it is very large. Have you checked whether git-svn
> produced the (number of) branches and tags that you expect?

I can't exactly tell, if all the branches are correct, because a lot of
the branches already have been merged and deleted in the SVN repository.

I checked the "git log --all" output with a small script to see, where
multiple commits belong to the same SVN revision (according to the
git-svn-id. Some SVN revions have up to 4 commits.

If I check some of these commits with `git branch --contains` then it
seems only one of the commits belongs to branch.

Is it possible, that a commit doesn't belong to any branch?

Tobias
