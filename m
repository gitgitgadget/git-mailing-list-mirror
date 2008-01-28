From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: git merge with tkdiff fails (extra operand)
Date: Mon, 28 Jan 2008 10:58:53 +0100
Message-ID: <fnk90t$gkq$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 28 11:01:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJQmF-00080Q-DK
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 10:59:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbYA1J7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 04:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753242AbYA1J7H
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 04:59:07 -0500
Received: from main.gmane.org ([80.91.229.2]:56830 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753383AbYA1J7G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 04:59:06 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JJQlY-0006t1-Ph
	for git@vger.kernel.org; Mon, 28 Jan 2008 09:59:00 +0000
Received: from port-83-236-129-242.static.qsc.de ([83.236.129.242])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Jan 2008 09:59:00 +0000
Received: from sschuberth by port-83-236-129-242.static.qsc.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Jan 2008 09:59:00 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: port-83-236-129-242.static.qsc.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.9) Gecko/20071031 Thunderbird/2.0.0.9 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71871>

Hi,

I'm running Git 1.5.3.7 under SuSE 10.0. After pulling and getting a 
merge conflict, "git mergetool" by default is configured to run tkdiff. 
Unfortunately, tkdiff starts with an error:

diff failed:
diff: extra operand
`Amira/QxViewer.cpp.REMOTE.28414`
diff: Try diff --help for more information.

I'm not sure whether the error is with the tkdiff integration into Git, 
or with tkdiff itself (as it refers to the help for "diff").

Any insights?

-- 
Sebastian Schuberth
