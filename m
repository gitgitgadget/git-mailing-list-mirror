From: "David Tweed" <david.tweed@gmail.com>
Subject: [PATCH] add to gitk documentation
Date: Fri, 17 Aug 2007 11:29:05 +0100
Message-ID: <e1dab3980708170329s33ba4937xf9586b296cc4858b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: paulus@samba.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 12:29:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILz4z-0003fV-S9
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 12:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbXHQK3K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 06:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752366AbXHQK3I
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 06:29:08 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:45330 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbXHQK3H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 06:29:07 -0400
Received: by wx-out-0506.google.com with SMTP id h31so446649wxd
        for <git@vger.kernel.org>; Fri, 17 Aug 2007 03:29:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Cx03AIyJ0kF0VG/DXuux2CRCentifd7/O7M5HICi83tfp45C+IlwU2aK86XArBg5a8+xSFSc8wP4imDDbkt1Zdqrdvdn6G8QVl5UM+S9qx0yEmMHgZGfCK4McgmHb4LGkf0y283OYdSNS8lgwF1QWpDE10E6RHj3U1qs8RCCCZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=s310vaEqgsNRgjgRC8slghyiJK6SPufidcc+uuGST2kWOjmAFx557vXF1fO8CcfVyiTbFVDLv5CgZuXYrhVdMc/Sa9qPDn3uPmS6ZhiupCVILeziFMmf0vZtSwFO/tY+QYteOWcvXrYb6/UVMlbVhryYSvn+m9+IiT6xRbHY66o=
Received: by 10.70.19.20 with SMTP id 20mr4600611wxs.1187346546038;
        Fri, 17 Aug 2007 03:29:06 -0700 (PDT)
Received: by 10.70.26.12 with HTTP; Fri, 17 Aug 2007 03:29:05 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56058>

A very brief couple of sentences on the basic "click" usage of gitk
which I can't find explicitly documented anywhere else.

Signed-off-by: David Tweed <david.tweed@gmail.com>
-- 
 Documentation/gitk.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index e9f82b9..d9fb0a7 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -15,6 +15,13 @@ Displays changes in a repository or a selected set
of commits. This includes
 visualizing the commit graph, showing information related to each commit, and
 the files in the trees of each revision.

+The basic idea in gitk is that clicking on an element related to a commit
+(either the nodes in the commit graph or the commit brief message)
+provides both metadata and either a diff with the immediate parent or
+the tree contents of the commit (depending whether the patch or tree view
+is chosen). Clicking on a yellow tag marker provides the object id of the
+commit it references.
+
 Historically, gitk was the first repository browser. It's written in tcl/tk
 and started off in a separate repository but was later merged into the main
 git repository.
