From: Jean-Luc Herren <jlh@gmx.ch>
Subject: How to make gitk not overwrite my selection?
Date: Tue, 04 Mar 2008 16:39:08 +0100
Message-ID: <47CD6D1C.1080202@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 16:40:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWZFG-00059z-BR
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 16:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759460AbYCDPjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 10:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755998AbYCDPjR
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 10:39:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:48986 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751120AbYCDPjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 10:39:16 -0500
Received: (qmail invoked by alias); 04 Mar 2008 15:39:14 -0000
Received: from 74-20.78-83.cust.bluewin.ch (EHLO [192.168.123.202]) [83.78.20.74]
  by mail.gmx.net (mp056) with SMTP; 04 Mar 2008 16:39:14 +0100
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX18BIUlA6UgBkWqQGKxjS/tenfAbhis+yTixx5QZCO
	5pp4b0KTQuJ7PK
User-Agent: Thunderbird 2.0.0.12 (X11/20080229)
X-Enigmail-Version: 0.95.6
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76102>

Hi list!

In gitk, whenever I select a commit in the tree, the SHA1 field
gets automatically selected, putting its hash into the current
selection for easy pasting into other applications.  I wonder if I
can disable this, because I find it rather annoying; if I do
happen to want to paste the hash somewhere, I can easily double
click the SHA1 field.

This is specially annoying when I select a hash in xterm and then
start gitk to paste it in the SHA1 field.  But immediately after
gitk opens, it preselects the current HEAD, overwriting my
previous selection from xterm.

Generally I think an application should not replace the selection
unless the user explicitely marks something.  Although I can
understand that it can be useful sometimes with gitk.  Therefore
it should maybe be optional.

Thanks,
jlh
