From: Alan Stern <stern@rowland.harvard.edu>
Subject: Reachability lists in git
Date: Tue, 18 Nov 2014 14:03:44 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1411181354320.4374-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 18 20:03:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqo47-0008MX-5x
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 20:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbaKRTDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 14:03:46 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:37990 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932079AbaKRTDq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 14:03:46 -0500
Received: (qmail 22500 invoked by uid 2102); 18 Nov 2014 14:03:44 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Nov 2014 14:03:44 -0500
X-X-Sender: stern@iolanthe.rowland.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "git rev-list A ^B" command lists all the commits that are
reachable from A but not from B.  Is there a comparable command for the
converse relation, that is, a command to list all the commits that A is
reachable from but B isn't?

And if there is such a command, can the output be limited to just the 
latest commits?  That is, list commit X if and only if A is reachable 
from X, B isn't reachable from X, and B is reachable from each of X's 
children?

Thanks,

Alan Stern
