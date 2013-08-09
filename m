From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: gitk: "Can't parse git log output: { }"
Date: Fri, 9 Aug 2013 10:05:37 +0200
Message-ID: <87a9kr1e7i.fsf@linux-k42r.v.cablecom.net>
References: <alpine.DEB.2.00.1308090727340.3907@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Aug 09 10:05:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7hho-000082-1e
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 10:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030525Ab3HIIFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 04:05:43 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:15807 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030504Ab3HIIFj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 04:05:39 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 9 Aug
 2013 10:05:29 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.253) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Fri, 9 Aug 2013 10:05:37 +0200
In-Reply-To: <alpine.DEB.2.00.1308090727340.3907@ds9.cixit.se> (Peter
	Krefting's message of "Fri, 9 Aug 2013 07:31:53 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.253]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231962>

Peter Krefting <peter@softwolves.pp.se> writes:

> Hi!
>
> In my local clone of git.git, currently with the v1.8.4-rc2 tag
> checked out and built (and installed on the system), starting up gitk
> yields an empty window, with a dialog in front of it:
>
>   error
>
>   Can't parse git log output: { }
>
>   [ OK ]
>
> Has anyone else seen this, and know what might have happened? I do not
> get the behaviour in other repositories (including other clones of
> git.git), only this particular one.

Have you tried moving away .git/gitk.cache?

If that fixes it, perhaps you can share it for inspection.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
