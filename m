From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Removing things from a repo that shouldn't be there
Date: Sun, 10 Feb 2008 12:15:43 -0500
Message-ID: <9e4733910802100915t56d0f63fh90c303b35f6af921@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 18:16:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOFmx-0004Q9-C6
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 18:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbYBJRPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 12:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbYBJRPt
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 12:15:49 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:1970 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbYBJRPs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 12:15:48 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1660991wah.23
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 09:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=/QyZK3dDzRT4NY1PrTqKvTUHTLvgJoMjFXkSPF7JM34=;
        b=BOdCNMXIOZgY4AFsD/AYxTtECiBbTsn0g23offH/mM8ipFwB3ufvnyboD4cCsfWHVy1dVvM7AmmnyWfJUNgYPIzVZ3yKoZaBPaZuqGElFPx2pgj1F11nYtSPkfeLuEFovYkET/ZBM836rByKaHbHrznG96QV+tOv3lhIz3lzTOU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eT9SPViyU9CK9FbhVtPPtMKBE06KyYMMDkuAQ9IVrZ5Z51duNXpyYYFWDJdnGDyEEruir08uI+vHFk9fzECmrlM26acnAYZT9OzbMCeBbTe2oZ9us4L3CfKwY0JzHYiY3WR5myIWy5BpqqOqnI9pnT9KXOjw0gl9VKdmYOGIHuM=
Received: by 10.114.166.1 with SMTP id o1mr8654111wae.71.1202663744007;
        Sun, 10 Feb 2008 09:15:44 -0800 (PST)
Received: by 10.114.200.7 with HTTP; Sun, 10 Feb 2008 09:15:43 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73378>

In the lazy clone thread there is mention of a large, generated file
being checked into the tree. Let's say we have a tree like this and it
is ok to delete the generated file since it didn't really need to be
checked in. Is there a procedure to chase down all the revisions,
delete them, and then regenerate the commits to reflect the deletion?
I don't need this tool, I'm just wondering if there is a reasonable
solution to the problem.

-- 
Jon Smirl
jonsmirl@gmail.com
