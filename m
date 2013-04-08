From: Aaron Schrab <aaron@schrab.com>
Subject: [PATCH v2 0/2] Using gitfile repository with clone --reference
Date: Mon,  8 Apr 2013 18:46:38 -0400
Message-ID: <1365461200-13509-1-git-send-email-aaron@schrab.com>
References: <20130408185957.GM27178@pug.qqx.org>
Cc: gitster@pobox.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 09 00:47:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPKq6-0007Ct-NV
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 00:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936301Ab3DHWq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 18:46:57 -0400
Received: from pug.qqx.org ([50.116.43.67]:36534 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935227Ab3DHWq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 18:46:57 -0400
Received: from zim.qqx.org (cpe-107-015-024-243.nc.res.rr.com [107.15.24.243])
	by pug.qqx.org (Postfix) with ESMTPSA id 9152757E07
	for <git@vger.kernel.org>; Mon,  8 Apr 2013 18:46:54 -0400 (EDT)
Received: from ats (uid 1000)
	(envelope-from aaron@schrab.com)
	id 40e5c
	by zim.qqx.org (DragonFly Mail Agent);
	Mon, 08 Apr 2013 18:46:53 -0400
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <20130408185957.GM27178@pug.qqx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220535>

Here's the promised second version of this series.

The diff in the first patch is unchanged, but I have made significant
changes to the commit message to hopefully to a better job of describing
why I think the old error message is bad.

For the second patch I've eliminated the need to do a cast.

Although I'm sending these as a series, the changes are independent both
textually and semantically.
