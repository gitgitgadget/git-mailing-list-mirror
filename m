From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] Make 'remote show' distinguish between merged and rebased
 remote branches
Date: Tue, 10 Feb 2009 17:05:12 -0500
Message-ID: <4991FA18.1040200@xiplink.com>
References: <20090210202046.8EBEC3360AC@rincewind> <7v3aemm1po.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 23:06:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX0kf-0001uu-3W
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 23:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755665AbZBJWFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 17:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755477AbZBJWFR
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 17:05:17 -0500
Received: from smtp152.iad.emailsrvr.com ([207.97.245.152]:52648 "EHLO
	smtp152.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754888AbZBJWFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 17:05:16 -0500
Received: from relay5.relay.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay5.relay.iad.emailsrvr.com (SMTP Server) with ESMTP id 52D59738949;
	Tue, 10 Feb 2009 17:05:15 -0500 (EST)
Received: by relay5.relay.iad.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 2F0B17388C7;
	Tue, 10 Feb 2009 17:05:15 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <7v3aemm1po.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109321>

Junio C Hamano wrote:
> 
> I sympathize with what you are trying to do but I do not think this is
> correct.  You will *never* rebase remote on top of your changes; rather
> you will replay your changes on top of what the updated remote has.
> 
> It is more like "if you start git pull while on branch rebaser, it will
> rebased on top of this branch from the remote".
> 

I'm happy to use more accurate phrasing -- I was just going for a minimal change.

How about the following, consistent for both cases:

'git pull' merges branch master with remote branch
  master
'git pull' rebases branch rebaser on top of remote branch
  side

?

I like the above because the keywords & branch names are in consistent locations, making it easier to parse the output.

		Marc
