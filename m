From: Yuchen Deng <loaden@gmail.com>
Subject: i18n.commitencoding=gbk or --encoding=gbk not work with
 --pretty=format
Date: Sun, 18 Dec 2011 05:26:02 -0800 (PST)
Message-ID: <1324214762135-7105845.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 18 14:26:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcGkp-0000a9-AZ
	for gcvg-git-2@lo.gmane.org; Sun, 18 Dec 2011 14:26:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716Ab1LRN0D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Dec 2011 08:26:03 -0500
Received: from sam.nabble.com ([216.139.236.26]:55158 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694Ab1LRN0C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Dec 2011 08:26:02 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <loaden@gmail.com>)
	id 1RcGkc-0006dq-4g
	for git@vger.kernel.org; Sun, 18 Dec 2011 05:26:02 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187420>

Hi, all!
When set the option i18n.commitencoding value to gbk. I found the 'git log'
ouput encoding always is the default : utf8

    git log -n10 --pretty=format:"%h %d %an %s %ci" --topo-order --graph
or
    git log -n10 --encoding=utf8 --pretty=format:"%h %d %an %s %ci"
--topo-order --graph

But:
    git log --oneline

works well.
I am from China, and the GFW thing, I can't visit git-scm.com.
So, Somebody can help me to report this bug?
I am sure it's don't work for Windows (msys-git) or Linux (Chakra).
Thanks!

--
View this message in context: http://git.661346.n2.nabble.com/i18n-commitencoding-gbk-or-encoding-gbk-not-work-with-pretty-format-tp7105845p7105845.html
Sent from the git mailing list archive at Nabble.com.
