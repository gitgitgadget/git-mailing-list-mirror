From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn performance
Date: Sat, 25 Oct 2014 06:01:16 +0000
Message-ID: <20141025060116.GA5629@dcvr.yhbt.net>
References: <1414216069.95531.BPMail_high_carrier@web172304.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: Hin-Tak Leung <htl10@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Oct 25 21:00:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xi6aA-0006LE-Px
	for gcvg-git-2@plane.gmane.org; Sat, 25 Oct 2014 21:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbaJYTAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2014 15:00:54 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47682 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751737AbaJYTAy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2014 15:00:54 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DD611FB0E;
	Sat, 25 Oct 2014 06:01:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1414216069.95531.BPMail_high_carrier@web172304.mail.ir2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hin-Tak Leung <htl10@users.sourceforge.net> wrote:
> btw, git svn seems to disallow single word commit messages (or is it a
> svn config?). i found that i could not do git svn dcommit, when i had
> merely did git commit -m 'typos', for example, for an svn repo i have
> write access to. (I don't have them many such things, so it is
> difficult to tell whether it is a repo config, or a git svn
> strangeness). i just do rebase and do 'typo correction' or something
> before re-dcommit in the past.

Probably an SVN hook preventing it.  git-svn test cases such as
t/t9118-git-svn-funky-branch-names.sh do single word commits.
