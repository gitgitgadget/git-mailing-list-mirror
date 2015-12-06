From: Andreas Krey <a.krey@gmx.de>
Subject: Re: best practices against long git rebase times?
Date: Sun, 6 Dec 2015 17:40:11 +0100
Message-ID: <20151206164011.GG22288@inner.h.apk.li>
References: <20151204150546.GA17210@inner.h.apk.li> <CANgJU+Ums-zg1kDiW4mm_X_zxreb=wBVc1gpHUOFN=44x1TyRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 06 17:40:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5cMI-0003Pp-F0
	for gcvg-git-2@plane.gmane.org; Sun, 06 Dec 2015 17:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbbLFQkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2015 11:40:17 -0500
Received: from continuum.iocl.org ([217.140.74.2]:33030 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263AbbLFQkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2015 11:40:16 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id tB6GeBI15567;
	Sun, 6 Dec 2015 17:40:11 +0100
Content-Disposition: inline
In-Reply-To: <CANgJU+Ums-zg1kDiW4mm_X_zxreb=wBVc1gpHUOFN=44x1TyRQ@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282056>

On Fri, 04 Dec 2015 18:09:33 +0000, demerphq wrote:
...
> I bet you have a lot of refs; tags, or branches.

We do, but removing them doesn't noticably change the times
(12k refs vs. 120, mostly tags). I'm just running the
second series, the first (with many refs) ended
with rebasing over 3000 commits, for which git log -p
outputs 64 MByte, and the rebase takes 12 minutes.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
