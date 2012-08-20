From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 0/4] GSOC: prepare svndump for branch detection
Date: Mon, 20 Aug 2012 23:57:53 +0200
Message-ID: <1345499877-16024-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 23:58:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3ZzI-0003Al-BP
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 23:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755792Ab2HTV6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 17:58:13 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:44474 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755477Ab2HTV6M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 17:58:12 -0400
Received: by weyx8 with SMTP id x8so4179693wey.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 14:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=YL+2LxCMYbujfqS2sp/Eyw0M1L0LqZTjEo8rL0FNNWg=;
        b=0HMlpTkSspbVENDwT9j7Z5xvzNiOyj6J3EBWedkymx51IxQTgpZi1oE6rKcJU/DagT
         nH9VA96k+joRgFHOAZpwB2uty/JJFPm+tbs4bX2yZbS/bsWqJYKrpFglabtsFj9PWD2V
         KfMrbmRCEgpC79qudMsRMsjLpKjjrhp+DbizMrklu2CQ6NWaTwe9Q6NVinp+kT0RBMz8
         qCSjDhYak6jHreDW1oQXF4JzHW0uYfZgxXyGpG5L8CB1zk5vcuY+sR1FzgTFCNfXCocK
         fm1vqa1p0Mfb/ATgxwIxm5H0RmmXTkVhmr79Owg0w7/3hwMfzUHN85k9q5/QPEoM4wdu
         cfBw==
Received: by 10.180.97.135 with SMTP id ea7mr30877941wib.11.1345499891287;
        Mon, 20 Aug 2012 14:58:11 -0700 (PDT)
Received: from flomedio.lan (91-115-90-54.adsl.highway.telekom.at. [91.115.90.54])
        by mx.google.com with ESMTPS id o2sm44859731wiz.11.2012.08.20.14.58.09
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 14:58:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203893>

New Version with the following changes:
- remove sha1 calculation from vcs-svn.
- instead use marks to reference the blobs. 
- Distinguish the marks by setting the MSB for blobs.
- fixups by Junio from fa/vcs-svn

 [RFC 1/4] svndump: move struct definitions to .h
 [RFC 2/4] vcs-svn/svndump: restructure node_ctx, rev_ctx handling
 [RFC 3/4] vcs-svn/svndump: rewrite handle_node(),
 [RFC 4/4] vcs-svn: remove repo_tree
