From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [egit] Git repository with multiple eclipse projects ?
Date: Wed, 25 Nov 2009 22:27:39 +0100
Message-ID: <200911252227.40235.robin.rosenberg@dewire.com>
References: <20091125164734.GF21347@linagora.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, egit-dev@eclipse.org
To: Yann Dirson <ydirson@linagora.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 22:27:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDPP0-0006Ph-3c
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 22:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758897AbZKYV1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 16:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758842AbZKYV1g
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 16:27:36 -0500
Received: from mail.dewire.com ([83.140.172.130]:18464 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754553AbZKYV1g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 16:27:36 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 5C8F480038C;
	Wed, 25 Nov 2009 22:27:41 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SqlgvL3dfEh2; Wed, 25 Nov 2009 22:27:41 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id ED6C5800388;
	Wed, 25 Nov 2009 22:27:40 +0100 (CET)
User-Agent: KMail/1.11.4 (Linux/2.6.28-11-generic; KDE/4.2.4; i686; ; )
In-Reply-To: <20091125164734.GF21347@linagora.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133676>

onsdag 25 november 2009 17:47:34 skrev  Yann Dirson:
> I am investigating whether it is possible at all to have several
> eclipse projects in a single git repo, and have those projects
> correctly seen as managed by git.
>
> When importing a git repo into eclipse, we get a list of projects to
> import, but that list is empty.  What is expected by egit to get this
> list filled ?

Both Egit and Jgit themselves have multiple projects in the same repo. 
All projects must be located in the same directory structure.

repo/.git
    |`--project1/.git
    |`--project2

etc
Other variations are possible.

>
> It also does not look like it would be possible to use the "share"
> functionnality to setup such a repository from multiple projects (or
> from a project set), right ?

Share only tells Eclipse to attach EGit as the team provider, provided
it is located in a git repo, or lets you create a repo if none exists.

-- robin
