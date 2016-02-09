From: Matt McCutchen <matt@mattmccutchen.net>
Subject: [PATCH] git.txt: encourage bug reporters to test recent versions
Date: Mon, 8 Feb 2016 19:34:25 -0500
Message-ID: <1455048415.2511.200.camel@mattmccutchen.net>
References: <20160208135607.GB27054@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 21:07:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTEYw-0004Pa-Ah
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 21:07:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbcBIUG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 15:06:59 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:57879 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932149AbcBIUG6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Feb 2016 15:06:58 -0500
Received: from homiemail-a1.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 1DFF6348070
	for <git@vger.kernel.org>; Tue,  9 Feb 2016 12:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
	in-reply-to:references:from:date:subject:to
	:content-transfer-encoding:message-id:mime-version; s=
	mattmccutchen.net; bh=jm+vML0MeNGeRL4ejVxW76bgE/k=; b=JtmJPYmaql
	MlejTmgiQoH7of2vE4M/2lw4/fUxmJFhea9O/OJqAGxFxRf/wpyiSY3nAs+DoffP
	ATWQ4lAdyZtwBLkepsLQ6f49ikfRwMsh+ScC8y+TUNIRcVPD6kpMyZ9n0QxtNTNN
	PUD0Q4KqbEzfPSPa3f6oPhJHg/2QpQS0o=
Received: from main (30-9-175.wireless.csail.mit.edu [128.30.9.175])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: matt@mattmccutchen.net)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTPSA id CD00B34806C
	for <git@vger.kernel.org>; Tue,  9 Feb 2016 12:06:57 -0800 (PST)
In-Reply-To: <20160208135607.GB27054@sigill.intra.peff.net>
X-Mailer: Evolution 3.18.4 (3.18.4-1.fc23) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285853>

Specifically, the latest released version or the "next" branch, as
reporters are willing.  This is based on:

  http://marc.info/?l=git&m=145496979420513&w=2

Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
---
 Documentation/git.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index d987ad2..1a148bc 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1226,7 +1226,11 @@ Reporting Bugs
 
 Report bugs to the Git mailing list <git@vger.kernel.org> where the
 development and maintenance is primarily done.  You do not have to be
-subscribed to the list to send a message there.
+subscribed to the list to send a message there.  You can help us out by
+attempting to reproduce the bug in the latest released version of git,
+or if you're willing to build git from source, the `next` branch.
+Sometimes an attempted fix may be pending in this branch, in which case
+your feedback as to whether the fix worked for you will be appreciated.
 
 SEE ALSO
 --------
-- 
2.5.0
