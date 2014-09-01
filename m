From: Cyrille Truchot <cyrille.truchot@pird.com>
Subject: git stash -u deletes directories containing ignored files
Date: Mon, 01 Sep 2014 16:08:49 +0200
Message-ID: <54047DF1.9020800@pird.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 01 16:09:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOSI0-0003DZ-4t
	for gcvg-git-2@plane.gmane.org; Mon, 01 Sep 2014 16:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753065AbaIAOI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2014 10:08:56 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:48125 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbaIAOIz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2014 10:08:55 -0400
Received: from mfilter30-d.gandi.net (mfilter30-d.gandi.net [217.70.178.161])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id D411DA82C7
	for <git@vger.kernel.org>; Mon,  1 Sep 2014 16:08:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter30-d.gandi.net
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by mfilter30-d.gandi.net (mfilter30-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id qDCy3mUW3ecH for <git@vger.kernel.org>;
	Mon,  1 Sep 2014 16:08:50 +0200 (CEST)
X-Originating-IP: 93.17.52.123
Received: from [192.168.0.139] (123.52.17.93.rev.sfr.net [93.17.52.123])
	(Authenticated sender: ct@pird.com)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 05155A8321
	for <git@vger.kernel.org>; Mon,  1 Sep 2014 16:08:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256306>

Hey there,

I'm sure you've already heard about this because this is referenced on 
the web, but I cannot find anything about it on GitHub in the open 
issues nor in the fixed ones.

I'm working with Git for Windows, version 1.8.3.
The .gitignorefile contains a line like this : 'mydirectory/*'.
A new file is added in 'mydirectory' (but it's not showing with git 
status as it is ignored).
Let's say I want to stash several other files (tracked and untracked) 
and I use git stash -u.
The directory 'mydirectory' is then purely deleted, and not stashed. So, 
unrecoverable.

This happens only if thhe start is present in the .gitignore, because 
'mydirectory/' behaves normally.

So is there an open issue about this, or better, maybe it's already 
fixed in the latest versions ?
Thanks in advance for your reply, and many apologies if it's not relevant.

Someone else has described the bug here:
http://blog.icefusion.co.uk/git-stash-can-delete-ignored-files-git-stash-u/

Regards,
Cyrille
