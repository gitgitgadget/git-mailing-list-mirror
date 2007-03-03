From: Nick Williams <njw@jarb.freeserve.co.uk>
Subject: bug in git-archive?
Date: Sat, 03 Mar 2007 16:07:49 +0000
Message-ID: <esc64d$d2u$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 17:01:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNWg6-00028J-3V
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 17:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030667AbXCCQBn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 11:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030672AbXCCQBn
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 11:01:43 -0500
Received: from main.gmane.org ([80.91.229.2]:49449 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030667AbXCCQBm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 11:01:42 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HNWfq-0005ee-JM
	for git@vger.kernel.org; Sat, 03 Mar 2007 17:01:30 +0100
Received: from modem-2535.elephant.dialup.pol.co.uk ([217.134.249.231])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Mar 2007 17:01:30 +0100
Received: from njw by modem-2535.elephant.dialup.pol.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Mar 2007 17:01:30 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: modem-2535.elephant.dialup.pol.co.uk
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41300>

Hello everyone

git-archive only archives the current working dir (and sub dirs) even 
when no paths are specified. For example, if I do

git archive --format=tar --prefix=git-1.5.0.2/ HEAD > ~/test/test.tar

from with in the Documentation dir, then I only get part of the tree.

Is this the intended behavior?

The reason I ask is that from my (mis)reading of the man page I expect 
to get all of the tree unless paths are specified.

thanks

NJW
