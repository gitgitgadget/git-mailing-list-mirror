From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] t/Makefile: remove smoke test targets
Date: Sat, 27 Apr 2013 13:16:00 +0200
Message-ID: <8738ucgr67.fsf@hexa.v.cablecom.net>
References: <dd20490a6d7911e0e0814fbe2eee0cfea1faa4e5.1366999104.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Thomas Rast <trast@student.ethz.ch>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Apr 27 13:16:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW37A-0005Tf-KY
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 13:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755385Ab3D0LQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 07:16:07 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:5060 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754985Ab3D0LQF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 07:16:05 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 27 Apr
 2013 13:15:58 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 27 Apr
 2013 13:16:02 +0200
In-Reply-To: <dd20490a6d7911e0e0814fbe2eee0cfea1faa4e5.1366999104.git.john@keeping.me.uk>
	(John Keeping's message of "Fri, 26 Apr 2013 18:58:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222637>

John Keeping <john@keeping.me.uk> writes:

> Commit d24fbca (Remove Git's support for smoke testing - 2011-12-23)
> removed the smoke test support from the test suite but it was re-added
> by commit 342e9ef (Introduce a performance testing framework -
> 2012-02-17).  This appears to be the result of a mis-merge, since
> re-adding the smoke testing infrastructure does not relate to the
> subject of that commit.
>
> The current 'smoke' target is broken since the 'harness' script it
> uses no longer exists, so just reapply this section of commit d24fbca
> and remove all of the smoke testing section in the makefile.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>

Indeed.  I must have mis-rebased this commit or some such.

Acked-by: Thomas Rast <trast@inf.ethz.ch>

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
