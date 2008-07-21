From: SungHyun Nam <namsh@posdata.co.kr>
Subject: git-shell build error
Date: Mon, 21 Jul 2008 09:29:52 +0900
Message-ID: <g60la4$diu$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 02:31:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKjIx-0002i0-T2
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 02:31:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755517AbYGUAaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 20:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754656AbYGUAaI
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 20:30:08 -0400
Received: from main.gmane.org ([80.91.229.2]:41873 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753514AbYGUAaH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 20:30:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KKjHv-0002jq-NZ
	for git@vger.kernel.org; Mon, 21 Jul 2008 00:30:04 +0000
Received: from 203.238.196.197 ([203.238.196.197])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Jul 2008 00:30:03 +0000
Received: from namsh by 203.238.196.197 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Jul 2008 00:30:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 203.238.196.197
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
X-Stationery: 0.4.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89280>

Hello,

If NO_SETENV is defined, git-shell cannot be built.
Simply adding the 'compat/setenv.o' to the make rule fixes the problem.

Regards,

[master] ~/srcs/git[30]$ LANG= make
     LINK git-shell
Undefined                       first referenced
  symbol                             in file
gitsetenv                           exec_cmd.o
ld: fatal: Symbol referencing errors. No output written to git-shell
collect2: ld returned 1 exit status
make: *** [git-shell] Error 1
