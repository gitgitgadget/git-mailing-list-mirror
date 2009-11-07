From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH v2 0/4] Cygwin MSVC patches
Date: Sat, 07 Nov 2009 20:00:37 +0000
Message-ID: <4AF5D1E5.1010900@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 07 21:24:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6rq2-0000cT-9Y
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 21:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753056AbZKGUYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Nov 2009 15:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753047AbZKGUYe
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 15:24:34 -0500
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:44567 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753043AbZKGUYd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Nov 2009 15:24:33 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1N6rpu-0005mO-eP; Sat, 07 Nov 2009 20:24:39 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132373>

Hi Junio,

Sorry for the delay in sending these, something came up.

I will be sending:

[PATCH 1/4] Makefile: merge two Cygwin configuration sections into one
[PATCH 2/4] Makefile: keep MSVC and Cygwin configuration separate
[PATCH 3/4] MSVC: Add support for building with NO_MMAP
[PATCH 4/4] Add explicit Cygwin check to guard WIN32 header inclusion

Note that I didn't know if I should send patch #1, since it is already
in pu, but I'm sure it's easy for you to drop if you don't want it. ;-)

As requested, I've moved the old patch #1 to come after the old patch #3
(which is now patch #2). I also amended to commit subject and message.

Patch #4 has been cut down and the commit subject and message changed
to reflect the new scope of the patch.

I hope this covers all comments!

ATB,
Ramsay Jones
