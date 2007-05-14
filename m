From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: git log and merge commits
Date: Mon, 14 May 2007 18:13:23 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0705141803590.11269@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 14 18:13:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HndAx-0002YF-ER
	for gcvg-git@gmane.org; Mon, 14 May 2007 18:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbXENQN0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 12:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752277AbXENQN0
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 12:13:26 -0400
Received: from vervifontaine.sonytel.be ([80.88.33.193]:46204 "EHLO
	vervifontaine.sonycom.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751793AbXENQNZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 May 2007 12:13:25 -0400
Received: from pademelon.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by vervifontaine.sonycom.com (Postfix) with ESMTP id 0319758AD0;
	Mon, 14 May 2007 18:13:24 +0200 (MEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47265>

	Hi,

I noticed `git log -p' doesn't show the changes introduced by merge commits.
This is true for plain `git log -p' and for `git log -p <filename>'.

Using `git show <commit-id>' does show the changes.

As I noticed the problem originally in a non-public repository, it was a bit
difficult to report. But I've just found an example in linux.git, too:

`git show 5cd47155155a32e5b944ac9fc3f3dc578e429aa0' shows the merge commit.
But `git log -p include/asm-arm/arch-ixp4xx/io.h' doesn't show it.

It happens in git 1.4.4.4 (what I'm using regularly), but also in 1.5.1.4.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
