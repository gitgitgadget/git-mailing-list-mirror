From: Sam Vilain <sam@vilain.net>
Subject: Re: GIT vs Other: Need argument
Date: Wed, 18 Apr 2007 15:09:32 +1200
Message-ID: <46258BEC.7050603@vilain.net>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>	 <20070417104520.GB4946@moonlight.home> <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Tomash Brechko <tomash.brechko@gmail.com>, git@vger.kernel.org,
	Pietro Mascagni <pietromas@gmail.com>
To: Guilhem Bonnefille <guilhem.bonnefille@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 05:09:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He0YA-0006Py-1q
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 05:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030880AbXDRDJj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 23:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031025AbXDRDJj
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 23:09:39 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:54307 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030880AbXDRDJi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 23:09:38 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 54AB813A400; Wed, 18 Apr 2007 15:09:36 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id B7CD313A382;
	Wed, 18 Apr 2007 15:09:32 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44858>

Guilhem Bonnefille wrote:
> I'm new to Git, but completly crazy of it.
>
> In my point of view, in corporate team, lot of people does not
> want/need the power offered by Git.
> So, my conclusion is the better model in a corporate is a centralyzed
> repo with some users using Git as "frontend". Other people will simply
> use the native tools for accessing the repo.
>
> I didn't try Git with CVS repo but seems less usable in day to day
> work than a SVN repo with git-svn FANTASTIC tool.
>
> So the problem is simply now: how to convince people to migrate from
> CVS to SVN. This will be really less difficult as CVS and SVN are
> quite similar.
>   

Once git-svnserver is available, it should be possible to work the other
way, too - use git as the repository format and support Subversion users
through a subversion interface flavour.  Then you don't lose the merge
tracking and fast checkout performance for those who can use the native
protocol.

Sam.
