From: Jonathan Duncan <jonathan@memoryties.com>
Subject: Wrong code on master
Date: Fri, 23 Dec 2011 22:09:06 -0700
Message-ID: <36BFCDA4-8249-4965-877F-FFC9EA65C7EE@memoryties.com>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 24 06:09:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ReJrT-000490-68
	for gcvg-git-2@lo.gmane.org; Sat, 24 Dec 2011 06:09:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200Ab1LXFJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Dec 2011 00:09:13 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34792 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846Ab1LXFJM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Dec 2011 00:09:12 -0500
Received: by iaeh11 with SMTP id h11so16083430iae.19
        for <git@vger.kernel.org>; Fri, 23 Dec 2011 21:09:11 -0800 (PST)
Received: by 10.50.183.166 with SMTP id en6mr16529766igc.7.1324703351562;
        Fri, 23 Dec 2011 21:09:11 -0800 (PST)
Received: from [10.0.7.3] (c-76-27-42-247.hsd1.ut.comcast.net. [76.27.42.247])
        by mx.google.com with ESMTPS id i2sm14287329igq.6.2011.12.23.21.09.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Dec 2011 21:09:10 -0800 (PST)
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187653>

I have a developer that committed code that should have been on a branch.  I have created a branch now and locally my master branch is good to go.  However, when I try to push it conflicts, of course, because the repo still wants me to pull the changes and merge them to my master.

The new code from the other developer will eventually be used, but we were not ready for it to be on "master" yet.  I need to push my own code out before that other code gets used.

Will I really have to pull and merge the code to master and then revert?  I have been googling all day, trying to figure out the best way to do this and in the process I fear I have made a mess of my repo.  I have been using git long enough to be dangerous to myself.

Any thoughts?  Got a good article I can read?

Thanks,
Jonathan