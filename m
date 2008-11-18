From: "Burt Culver" <burt@fishpond.co.nz>
Subject: git tree browsing in redmine
Date: Tue, 18 Nov 2008 15:34:25 +1100
Message-ID: <b8f2e1780811172034w6828ddc8n62cf85b5fa366e22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 18 05:36:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2IJq-0006lp-2i
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 05:36:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbYKREe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 23:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbYKREe2
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 23:34:28 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:10743 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbYKREe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 23:34:28 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1331810nfc.21
        for <git@vger.kernel.org>; Mon, 17 Nov 2008 20:34:26 -0800 (PST)
Received: by 10.103.1.5 with SMTP id d5mr1554729mui.29.1226982865961;
        Mon, 17 Nov 2008 20:34:25 -0800 (PST)
Received: by 10.103.219.14 with HTTP; Mon, 17 Nov 2008 20:34:25 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101260>

Hi,

I'm trying to find some ideas for a better way to implement browsing
of a git repository within the redmine application.

My top level directory in my git repository has 300 files. Redmine
wants to display each file name, its most recent revision, and the
comment for that revision. Currently it does a git log -1 on each file
to find the latest revision.  Is there a quicker way of doing this for
a whole directory?  git log runs from .2 seconds to 3 seconds
depending on the file on my server.

Here is the open issue at redmine.org which has more details:
http://www.redmine.org/issues/show/1435

A fix for this would help a whole bunch of redmine / git users including myself.

-- 
Regards,

Burt Culver
Fishpond.co.nz & Fishpond.com.au
New Zealand & Australias Biggest Bookstore
