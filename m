From: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
Subject: Re: Strange push/clone errors
Date: Wed, 4 Mar 2009 15:39:38 +0100
Message-ID: <20090304143938.GB12901@vidovic>
References: <c115fd3c0903040601xbfce200q78c53aeee0b44f2c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 15:41:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LesHd-0001BU-O7
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 15:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbZCDOjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 09:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbZCDOjs
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 09:39:48 -0500
Received: from out6.laposte.net ([193.251.214.123]:62172 "EHLO
	out5.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751448AbZCDOjr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 09:39:47 -0500
Received: from meplus.info (localhost [127.0.0.1])
	by mwinf8402.laposte.net (SMTP Server) with ESMTP id B112D7000089;
	Wed,  4 Mar 2009 15:39:39 +0100 (CET)
Received: from ? (91-164-130-252.rev.libertysurf.net [91.164.130.252])
	by mwinf8402.laposte.net (SMTP Server) with ESMTP id 58D5F7000087;
	Wed,  4 Mar 2009 15:39:39 +0100 (CET)
X-ME-UUID: 20090304143939363.58D5F7000087@mwinf8402.laposte.net
Content-Disposition: inline
In-Reply-To: <c115fd3c0903040601xbfce200q78c53aeee0b44f2c@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-me-spamlevel: not-spam
X-me-spamrating: 40.000000
X-me-spamcause: OK, (-200)(0000)gggruggvucftvghtrhhoucdtuddrvdekuddrudejucetggdotefuucfrrhhofhhilhgvmecuoehnohhnvgeqnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112217>


On Wed, Mar 04, 2009 at 09:01:51AM -0500, Tim Visher wrote:

> As you can see, v1.6.2 and v1.6.2-rc2 are missing from the repo that
> I'm pushing to on my thumb drive, despite it claiming it's up to date.
> 
> What am I doing wrong?

You need to push the tags using the --tags option of git-push (when
pushing to your sandbox repository).

-- 
Nicolas Sebrecht
