From: Andy Whitcroft <apw@shadowen.org>
Subject: git packing leaves unpacked files
Date: Tue, 26 Sep 2006 19:04:56 +0100
Message-ID: <45196BC8.8060608@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 26 20:05:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSHJ8-0002VF-5g
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 20:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWIZSFW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 14:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWIZSFV
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 14:05:21 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:38404 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S932366AbWIZSFT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 14:05:19 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GSHIY-0006aY-TN
	for git@vger.kernel.org; Tue, 26 Sep 2006 19:04:50 +0100
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
To: Git Mailing List <git@vger.kernel.org>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27804>

I was just looking at my kernel repository and noticed that even after a
git repack -a -d I have some loose files.  A quick look at repack
doesn't seem to explain why some are either not packed or are kept unpacked.

Is this something I should be expecting?

-apw
