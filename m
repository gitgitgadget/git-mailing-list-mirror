From: Andreas Krey <a.krey@gmx.de>
Subject: [BUG] "git rebase": fatal: Not a valid object name: ''
Date: Thu, 9 Jan 2014 16:36:18 +0100
Message-ID: <20140109153618.GA18975@inner.h.apk.li>
References: <CAOBEgJjmoXEDVa4L5LbAGMYR7_+NCf2tDSveieZxtU4bfWyzDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 09 16:36:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1Heo-0005Fi-G5
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 16:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754293AbaAIPg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 10:36:26 -0500
Received: from continuum.iocl.org ([217.140.74.2]:51399 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753706AbaAIPgX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jan 2014 10:36:23 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id s09FaIR19521;
	Thu, 9 Jan 2014 16:36:18 +0100
Content-Disposition: inline
In-Reply-To: <CAOBEgJjmoXEDVa4L5LbAGMYR7_+NCf2tDSveieZxtU4bfWyzDw@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240257>

Hi, everyone,

since ad8261d (rebase: use reflog to find common base with upstream)
a rebase without arguments says "fatal: Not a valid object name: ''",
caused by trying to determine the fork point with an empty $switch_to.

I don't really see what the appropriate fix would be. :-(

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
