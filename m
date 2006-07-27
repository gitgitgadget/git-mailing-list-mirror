From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] Per branch properties for pull and fetch
Date: Thu, 27 Jul 2006 22:26:43 +0200
Message-ID: <E1G6CRP-0007y4-Jd@moooo.ath.cx>
References: <87lkqfcvm2.fsf@gmail.com> <20060727085516.GC27593@admingilde.org> <8aa486160607270240h412b0dcek1d57eeb2b254fb2e@mail.gmail.com> <8aa486160607270306s3f49a01cq91ef61e2c9f005e@mail.gmail.com> <20060727120220.GD27593@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 27 22:27:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6CRY-0007SL-GE
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 22:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWG0U0r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 16:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWG0U0r
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 16:26:47 -0400
Received: from moooo.ath.cx ([85.116.203.178]:40350 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1750717AbWG0U0r (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 16:26:47 -0400
To: Martin Waitz <tali@admingilde.org>
Mail-Followup-To: Martin Waitz <tali@admingilde.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060727120220.GD27593@admingilde.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24338>

Martin Waitz <tali@admingilde.org> wrote:
> The current default is to always use the remote's master branch, right?
> What do others think: does it make sense to default to the same
> branchname on the remote side?
I like the separate-remote option too and having one simple command
that pulls the changes from the correct remote branch would be nice.
It should do something like
$ git pull ${1:-origin} $(git-symbolic-ref HEAD | cut -d / -f 3-)
