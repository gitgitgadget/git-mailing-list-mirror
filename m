From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] rationalize diffcore-rename options and their doc
Date: Wed, 10 Nov 2010 21:27:11 +0100
Message-ID: <1289420833-20602-1-git-send-email-ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 10 21:27:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGHGU-0001jm-Uq
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 21:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756460Ab0KJU1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 15:27:24 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:50230 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756223Ab0KJU1X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 15:27:23 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 679F8D4814F
	for <git@vger.kernel.org>; Wed, 10 Nov 2010 21:27:18 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PGHGH-0005N1-6r
	for git@vger.kernel.org; Wed, 10 Nov 2010 21:27:17 +0100
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161180>

I am ready to take the blame for being the first to introduce
--detect-* options in diff-opts, with the directory-rename stuff.
However, since --find-copies-harder predates everything and is the
only one to be part of a release today, I'd think it would be much
more consistent to use --find- as a common prefix.  And, last but not
least, shorter long options do not hurt.

At the same time, I noticed the manpage could benefit from a small
improvement.
