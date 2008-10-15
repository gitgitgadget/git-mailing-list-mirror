From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH 3/3] git pull: Support --preserve-merges as a flag to
 rebase
Date: Wed, 15 Oct 2008 01:59:59 -0500
Organization: Exigence
Message-ID: <20081015015959.38fe9973.stephen@exigencecorp.com>
References: <48D9586C.4010102@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Oct 15 09:01:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq0Nf-0005Q2-Na
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 09:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbYJOHAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 03:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbYJOHAG
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 03:00:06 -0400
Received: from smtp152.sat.emailsrvr.com ([66.216.121.152]:53189 "EHLO
	smtp152.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbYJOHAF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 03:00:05 -0400
Received: from relay5.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay5.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 7CDFE2682C0;
	Wed, 15 Oct 2008 03:00:03 -0400 (EDT)
Received: by relay5.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id AB36A2682C8;
	Wed, 15 Oct 2008 03:00:02 -0400 (EDT)
In-Reply-To: <48D9586C.4010102@op5.se>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98240>


> Now that "git rebase" supports non-interactive rebases
> preserving merges, this patch is the next logical step
> for those who wish to use such a workflow.
> 
> Since this patch makes the last test marked as expecting
> failure in t3409-rebase-preserve-merges, we now alter it
> to expect success.

Does anyone know the current status of this?

The first 1/3 and 2/3 of this series is in next now (which grant
non-interactive merge-preserving rebasing), but this additional
--preserve-merges flag to git pull didn't seem to make it.

(Correct me if I'm wrong, I cannot pin point exactly where 1/2
and 2/3 got merged in, I'm just cheating and looking at the files
as they exist in next's tip.)

My grandeur plan is to have this 3/3 go in as well and then follow it
up with my patch to add a branch.name.preservemerges config variable.

This will make our internal workflow of "always rebase local
changes/always preserve local merges" just work with "git pull".

Does this seem reasonable?

Thanks,
Stephen
