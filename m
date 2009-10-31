From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 10/19] Allow helpers to request marks for fast-import
Date: Sat, 31 Oct 2009 13:04:05 +0100
Message-ID: <200910311304.05408.johan@herland.net>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
 <200910300921.00561.johan@herland.net>
 <fabb9a1e0910300526v5cbcf685l69f60c58b7e3732@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 13:04:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4Cgo-0007N8-SQ
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 13:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbZJaMEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2009 08:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbZJaMEE
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Oct 2009 08:04:04 -0400
Received: from smtp.getmail.no ([84.208.15.66]:59350 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932106AbZJaMED (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Oct 2009 08:04:03 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KSD00DVHO6UOA10@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 31 Oct 2009 13:04:06 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KSD00A5IO6TA630@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 31 Oct 2009 13:04:06 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.10.31.115121
User-Agent: KMail/1.12.2 (Linux/2.6.30-ARCH; KDE/4.3.2; x86_64; ; )
In-reply-to: <fabb9a1e0910300526v5cbcf685l69f60c58b7e3732@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131841>

On Friday 30 October 2009, Sverre Rabbelier wrote:
> Heya,
> 
> On Fri, Oct 30, 2009 at 01:21, Johan Herland <johan@herland.net> wrote:
> > Please drop this patch from the series. The functionality is not
> > needed, since we'll use the fast-import "option" command from the
> > sr/gfi-options series instead.
> 
> In that case I will rebase the series on top of sr/gfi-options then as
> soon as I reroll that one.

Good.

> Also, do you need to change anything else in git-remote-cvs to do that?

Yes, the sr/gfi-options series does cause some changes, both in git-remote-
cvs, and in the support libraries (adding a couple of methods to the 
GitFastImport class in git.py).

This conglomeration of patch series is becoming fairly complicated, and it's 
becoming hard to stay in sync. I suggest that you drop the CVS-specific 
parts from this series, and work on stabilizing the common infrastructure. 
Once that has settled, you can send a git-remote-hg series, and I can send a 
rebased and updated git-remote-cvs series.

Feel free to reorganize the patches so that the git_remote_helpers 
infrastructure is created in the correct location (instead of reorganizing 
git_remote_cvs).


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
