From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH] rebase -p: seed first commit in case it's before the
 merge bases.
Date: Sat, 17 Jan 2009 22:02:26 -0600
Organization: Exigence
Message-ID: <20090117220226.8f0d1960.stephen@exigencecorp.com>
References: <496F6AC3.7050704@drmicha.warpmail.net>
	<cover.1232233454.git.stephen@exigencecorp.com>
	<ac1a4533de095f916dd68029793c8ee6eb02d200.1232233454.git.stephen@exigencecorp.com>
	<a524993b13ee586cf0e8fbd3b6459ccd6767c6d8.1232233454.git.stephen@exigencecorp.com>
	<alpine.DEB.1.00.0901180041540.3586@pacific.mpi-cbg.de>
	<alpine.DEB.1.00.0901180108480.3586@pacific.mpi-cbg.de>
	<20090117215751.60ade90a.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Stephan Beyer <s-beyer@gmx.net>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 18 05:03:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOOt8-0007JG-I8
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 05:03:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754343AbZARECb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 23:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754118AbZARECa
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 23:02:30 -0500
Received: from smtp122.sat.emailsrvr.com ([66.216.121.122]:39130 "EHLO
	smtp122.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063AbZAREC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 23:02:29 -0500
Received: from relay2.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay2.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id E1F38DD6C7;
	Sat, 17 Jan 2009 23:02:27 -0500 (EST)
Received: by relay2.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTPSA id 95085DD5E1;
	Sat, 17 Jan 2009 23:02:27 -0500 (EST)
In-Reply-To: <20090117215751.60ade90a.stephen@exigencecorp.com>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106139>


> Perhaps it is not "good", but the explanation a blank REWRITTEN/sha1 is
> used a marker during the probe phase that this commit will be rewritten.
> So when looking at any of its children commits, they should be rewritten
> if a REWRITTEN/parentSha1 exists.

Ugh, fixing several typos:

Perhaps it is not "good", but the explanation /is that/ a blank
REWRITTEN/sha1 is used /as/ a marker during the probe phase that this
commit will be rewritten. So when looking at any of its children
commits, /the children/ should be rewritten if a REWRITTEN/parentSha1
exists.

Sorry about that.

- Stephen
