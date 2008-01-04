From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH] Document git-reset defaults to HEAD if no commit is given
Date: Fri, 4 Jan 2008 10:53:32 +0100
Message-ID: <e5bfff550801040153m433d9880g4a7a6d4168d5365f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 10:54:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAjFZ-0003Jm-9D
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 10:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408AbYADJxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 04:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752821AbYADJxd
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 04:53:33 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:17872 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211AbYADJxc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 04:53:32 -0500
Received: by rv-out-0910.google.com with SMTP id k20so6067416rvb.1
        for <git@vger.kernel.org>; Fri, 04 Jan 2008 01:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=9T8b+dO4f2DW81H1CSxBY2phAjRNXnUwHXQe13Sfb/s=;
        b=aZqpthcchX+DEftqBFRvREayRPGPT7zLzde2lC3njLa9P/XY7CUtIHlNNBqHfPM+BEXGsMiK1Cj1QDeE/h7GJQxVYaIJNvOJatfrwcRtcYVx3IaMBTPWnDg2cbQ7pX17NQ6VwvY/YRG6nsXoSEjfPqMRrVfYSS3gZ4KkpR+wMJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eDh7r0DGvM2cGFD88SMsdHJ4uCgK90YLrV/xTDrq47PM9Qq750uEHZmFZl/U2FAkaI3Yt1bLH0lnkyJROhsU9An4DfpKz83nwuRh3RsREkP1VXBVuv8vHJv2unJLoHPS8fps+ejg5twIb1s40Js8CAYMrRDPhWAtC3DA8LK0fGs=
Received: by 10.141.153.16 with SMTP id f16mr8687009rvo.287.1199440412310;
        Fri, 04 Jan 2008 01:53:32 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Fri, 4 Jan 2008 01:53:32 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69575>

Signed-off by: Marco Costalba <mcostalba@gmail.com>
---
 Documentation/git-reset.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 050e4ea..69722d1 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git-reset' [--mixed | --soft | --hard] [-q] [<commit>]
-'git-reset' [--mixed] [-q] <commit> [--] <paths>...
+'git-reset' [--mixed] [-q] [<commit>] [--] <paths>...

 DESCRIPTION
 -----------
@@ -49,7 +49,7 @@ OPTIONS
 	Be quiet, only report errors.

 <commit>::
-	Commit to make the current HEAD.
+	Commit to make the current HEAD. If not given defaults to HEAD.

 Examples
 --------
-- 
1.5.4.rc2.20.gab44
