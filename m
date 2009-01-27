From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: Heads up: major rebase -i -p rework coming up
Date: Wed, 28 Jan 2009 07:10:54 +0900
Message-ID: <20090128071054.6117@nanako3.lavabit.com>
References: <alpine.DEB.1.00.0901242056070.14855@racer>
 <20090127092117.d13f24e7.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, spearce@spearce.org,
	Thomas Rast <trast@student.ethz.ch>,
	Bjrn Steinbrink <B.Steinbrink@gmx.de>
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 23:12:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRwAu-0003i6-PW
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 23:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbZA0WL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 17:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbZA0WL0
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 17:11:26 -0500
Received: from karen.lavabit.com ([72.249.41.33]:37540 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751445AbZA0WLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 17:11:25 -0500
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id C0264C8889;
	Tue, 27 Jan 2009 16:11:24 -0600 (CST)
Received: from 2774.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id WH697K44455V; Tue, 27 Jan 2009 16:11:24 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=nT4byFKIhfLZ34/mRhZAkGUnzSWpoulHS373ole+kSTFuHR+eSjSuQGEgEfOg6VAQcLCAs1kE1CQ1XRgZCNAn7texPeR+tGBywsfLgKSEm8wsQNW3ls/qhW6Ekq8wblBFPw+OxcCmLW6CJMdNYkKSj9zVG2bsYHqO5OaUhh8Bb8=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <20090127092117.d13f24e7.stephen@exigencecorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107396>

Quoting Stephen Haberman <stephen@exigencecorp.com>:

> My primary pain point with rebase-i-p has been rebasing a branch that
> has merged in another branch that has a lot of commits on it. E.g.:
>
>     a -- b -- c  origin/feature
>       \
>        d -- e    feature
>            /
>       ... g      origin/master
>
> Where e is merging in, say, a latest release that had a few hundred
> commits in the master branch. After resolving conflicts/etc. in e, I
> want to rebase d..e from a to be on c.

Sorry for asking a basic question, but if "feature" is a topic branch for advance the feature, why are you merging origin/master into it? Doesn't it blur the theme of the branch by including "development of the feature and all the random things that happened while it was being developed in other places"?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
