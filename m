From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: read-cache-v5.c: compiler warnings
Date: Sun, 19 Aug 2012 20:13:48 +0100
Message-ID: <50313AEC.1060700@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: t.gummerer@gmail.com
X-From: git-owner@vger.kernel.org Sun Aug 19 21:17:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3B01-0008A0-Gc
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 21:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601Ab2HSTRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 15:17:20 -0400
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:40745 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754572Ab2HSTQo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 15:16:44 -0400
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id E4493A0C07F;
	Sun, 19 Aug 2012 20:16:43 +0100 (BST)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 6D002A0C084;	Sun, 19 Aug 2012 20:16:43 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;	Sun, 19 Aug 2012 20:16:42 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203729>

Hi Thomas,

Just an FYI; two out of the three gcc compilers I use (Linux, cygwin
but not MingW), issue the following warnings:

        CC read-cache-v5.o
    read-cache-v5.c: In function `write_index_v5':
    read-cache-v5.c:1011: warning: 'dir' might be used uninitialized in this function
    read-cache-v5.c:1012: warning: 'search' might be used uninitialized in this function
    read-cache-v5.c:1012: warning: 'found' might be used uninitialized in this function

[commit d2537158 ("Write index-v5", 16-08-2012)]

Normally I would take a look and offer a patch, but I haven't found time
to do so in the last 10 days. So, I'm just giving you a heads up ... ;-P

HTH

ATB,
Ramsay Jones
