From: Soham Mehta <soham@box.net>
Subject: Finding a commit
Date: Wed, 21 Oct 2009 04:29:25 -0700
Message-ID: <4ADEF095.3020406@box.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 13:54:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Zlr-0000CG-90
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 13:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399AbZJULyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 07:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753397AbZJULyI
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 07:54:08 -0400
Received: from mailrelay.ve.box.net ([209.249.140.142]:59178 "EHLO
	corpmail.ve.box.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753376AbZJULyH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 07:54:07 -0400
X-Greylist: delayed 1471 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Oct 2009 07:54:07 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by corpmail.ve.box.net (Postfix) with ESMTP id AB4653B19C8
	for <git@vger.kernel.org>; Wed, 21 Oct 2009 04:29:32 -0700 (PDT)
Received: from corpmail.ve.box.net ([127.0.0.1])
	by localhost (mail.box.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id mZHoltyrDnCo for <git@vger.kernel.org>;
	Wed, 21 Oct 2009 04:29:32 -0700 (PDT)
Received: from [192.168.1.102] (c-24-23-197-167.hsd1.ca.comcast.net [24.23.197.167])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by corpmail.ve.box.net (Postfix) with ESMTP id 63B573B19C0
	for <git@vger.kernel.org>; Wed, 21 Oct 2009 04:29:32 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130904>

Given a SHA1 of a commit from one repository (say x), wondering what is 
a proper way to find out if that commit (change) also exists in a 
different repository (say y).

Because SHA1 can change if a commit is cherry-picked around, I cannot 
just grep for that SHA1 from git-rev-list or git-log on 'y'. I need a 
way to know if a commit with identical changes (as in 'x') is also 
present in 'y'.

I realize that Author and Timestamp do not change when the commit is 
moved (fetched, pushed, pulled, rebased, cherry-picked etc). So my 
current solution relies on grepping for the pair of Author-Timestamp 
from git-log on 'y'.

Wondering if there is more appropriate way of doing this?

Thanks.
-Soham
