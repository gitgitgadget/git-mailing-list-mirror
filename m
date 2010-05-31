From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Merging with git-svn - how about this?
Date: Mon, 31 May 2010 16:34:12 +0100
Message-ID: <4C03D6F4.2010204@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 31 17:34:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJ70Q-0007iX-Nj
	for gcvg-git-2@lo.gmane.org; Mon, 31 May 2010 17:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756650Ab0EaPeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 May 2010 11:34:17 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:6484 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754478Ab0EaPeQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 May 2010 11:34:16 -0400
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20100531153414.WIOL3192.mtaout02-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>
          for <git@vger.kernel.org>; Mon, 31 May 2010 16:34:14 +0100
Received: from [192.168.1.5] (really [80.6.134.127])
          by aamtaout03-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20100531153414.SCJ1598.aamtaout03-winn.ispmail.ntl.com@[192.168.1.5]>
          for <git@vger.kernel.org>; Mon, 31 May 2010 16:34:14 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
X-Cloudmark-Analysis: v=1.1 cv=W3tOLUehizD4qj6VhtReFuw5MKb8d+XqjIxlDsIazEA= c=1 sm=0 a=4JhjQmVe9PUA:10 a=ADBQPqJMlbwA:10 a=8nJEP1OIZ-IA:10 a=4mm48ULQZSUDmQl1OWQA:9 a=qbk5w0G-U9Oxn35Uv2YA:7 a=lb3jzou9F2L6y1hBh2bFEVZ_XlQA:4 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148046>

I'm writing up a wiki page based on the "best way to make my company
migrate to Git" thread from earlier this month, and I'd like to
recommend something for merging (beyond the standard "don't do it").
Here's what I'm planning to write - I'd appreciate any suggestions or
advice people have:

To merge from $from_branch to $to_branch with git-svn, do:

git checkout $to_branch@{0}
git merge --no-ff $from_branch
# Fix any merge conflicts, `git add`, `git commit` etc.
git checkout $to_branch
git cherry-pick -m 1 HEAD@{1}

	- Andrew
