From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: RFD: tables in documentation
Date: Sat, 01 May 2010 20:37:39 +0200
Message-ID: <4BDC74F3.2020206@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 01 20:37:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8HZS-0001PG-9h
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 20:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756763Ab0EAShm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 14:37:42 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58572 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750981Ab0EAShl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 May 2010 14:37:41 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id ACE70F1ED7
	for <git@vger.kernel.org>; Sat,  1 May 2010 14:37:40 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Sat, 01 May 2010 14:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:subject:content-type:content-transfer-encoding; s=smtpout; bh=5qOiMukutIEHhJn36RHj2bEyJG4=; b=K125h8JqKAYjRggrBjyMzAfIY0Q/6dOajfKiM9wNZymAzL7g97c7ovW4BlXvd/MJYbNyn07rjc3n0Vdm7eSrbFIO9pcgoIAXwgiKFzvEwwfK+eQyg3QD7uAi5YVNEBdZ2yxNWr1Vv/7F0WimFBrwnc62kleqTRY6STYkc6nNw2o=
X-Sasl-enc: YtF49LW6Lv6a8BKRhRGUsqn5Om4JvG8kFnwgB88wc3OK 1272739059
Received: from localhost.localdomain (p5DCC08EA.dip0.t-ipconnect.de [93.204.8.234])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5CD4B1A375
	for <git@vger.kernel.org>; Sat,  1 May 2010 14:37:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100429 Lightning/1.0b2pre Lanikai/3.1b2pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146109>

Currently, all tables are formatted using indentation by spaces. This
breaks whenever AsciiDoc's parsing changes.

Instead, I suggest to use AsciiDoc's table syntax which also produces
proper tables in the HTML and man output. I formatted the first part of
the first table in git-read-tree(1) like that so that you can compare
easily.

I put it up at http://repo.or.cz/w/git/mjg.git/commit/table-example for
your viewing pleasure. I'd say it looks great even in links (but not in
lynx). It also shows a problem of xmlto with multiple rowspans (the xml
is correct, .1 apparently not), which could be circumvented easily by
repeating those cells.

HTML:
http://repo.or.cz/w/git/mjg.git/blob_plain/table-example:/Documentation/git-read-tree.html

MAN:
http://repo.or.cz/w/git/mjg.git/blob_plain/table-example:/Documentation/git-read-tree.1

MAN converted to txt by man:
http://repo.or.cz/w/git/mjg.git/blob_plain/table-example:/Documentation/git-read-tree.1.txt

MAN converted to HTML by man2html:
http://repo.or.cz/w/git/mjg.git/blob_plain/table-example:/Documentation/git-read-tree.1.html

Cheers,
Michael
