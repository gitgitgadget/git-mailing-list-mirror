From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: Heads up: major rebase -i -p rework coming up
Date: Tue, 27 Jan 2009 16:36:50 -0600
Organization: Exigence
Message-ID: <20090127163650.34581368.stephen@exigencecorp.com>
References: <alpine.DEB.1.00.0901242056070.14855@racer>
	<20090127092117.d13f24e7.stephen@exigencecorp.com>
	<20090128071054.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, spearce@spearce.org,
	Thomas Rast <trast@student.ethz.ch>,
	Bjrn Steinbrink <B.Steinbrink@gmx.de>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 23:38:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRwZe-0003e1-SQ
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 23:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391AbZA0WhA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 17:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbZA0WhA
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 17:37:00 -0500
Received: from smtp182.sat.emailsrvr.com ([66.216.121.182]:49239 "EHLO
	smtp182.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbZA0Wg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 17:36:59 -0500
Received: from relay18.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay18.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id EB6721B8055;
	Tue, 27 Jan 2009 17:36:58 -0500 (EST)
Received: by relay18.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTPSA id 682D11B7FDC;
	Tue, 27 Jan 2009 17:36:58 -0500 (EST)
In-Reply-To: <20090128071054.6117@nanako3.lavabit.com>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107406>


> >     a -- b -- c  origin/feature
> >       \
> >        d -- e    feature
> >            /
> >       ... g      origin/master

> Sorry for asking a basic question, but if "feature" is a topic branch
> for advance the feature, why are you merging origin/master into it?
> Doesn't it blur the theme of the branch by including "development of
> the feature and all the random things that happened while it was being
> developed in other places"?

We merged origin/master because a release had just happened (e.g. master
moved from 1.0 -> 1.1), and when QA looks at origin/feature, they wanted
to see it integrated with the latest release (e.g. 1.1).

Now, granted, if feature was a private/unpublished branch, we would
rebase the entire thing (a/b/c) on top of master (g), but a/b/c has
already been published to our bug tracker, email lists, and other
developers who are collaborating on origin/feature, so between polluting
feature with a merge from master and changing the published hashes, we
chose the merge.

- Stephen
