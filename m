From: Stephen Haberman <stephen@exigencecorp.com>
Subject: [announce] gc
Date: Mon, 22 Dec 2008 21:24:07 -0600
Organization: Exigence
Message-ID: <20081222212407.47c9ab1e.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 23 04:25:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LExti-00044O-Nr
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 04:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848AbYLWDYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 22:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754677AbYLWDYK
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 22:24:10 -0500
Received: from smtp122.iad.emailsrvr.com ([207.97.245.122]:38458 "EHLO
	smtp122.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483AbYLWDYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 22:24:09 -0500
X-Greylist: delayed 1426 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Dec 2008 22:24:09 EST
Received: from relay2.r2.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay2.r2.iad.emailsrvr.com (SMTP Server) with ESMTP id F23E644C096
	for <git@vger.kernel.org>; Mon, 22 Dec 2008 22:24:07 -0500 (EST)
Received: by relay2.r2.iad.emailsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTPSA id 7681844C050
	for <git@vger.kernel.org>; Mon, 22 Dec 2008 22:24:07 -0500 (EST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103799>

Hi,

This is just a small collections of hooks, scripts, and practices I
developed while working on a not-distributed/corporate project.

A quick list is: svn-like revision numbers (via tagging every commit)
(don't flame me, please), combined diff-enabled commit emails*, Hudson
hooks, trac hooks, branch locking, same-repo-separate-DAG git
server-side config storage and export-on-push, and developer-side
push/pull scripts that "just work".

http://github.com/stephenh/gc

Hopefully others find it as useful.

Thanks,
Stephen
