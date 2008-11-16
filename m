From: Martin <html-kurs@gmx.de>
Subject: git svn problem with malformed svn revision
Date: Sun, 16 Nov 2008 15:18:15 +0100
Message-ID: <49202BA7.9060203@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 16 15:22:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1iWV-0007gL-VM
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 15:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbYKPOSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 09:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbYKPOSl
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 09:18:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:53736 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751274AbYKPOSl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 09:18:41 -0500
Received: (qmail invoked by alias); 16 Nov 2008 14:18:39 -0000
Received: from p54B20CD1.dip0.t-ipconnect.de (EHLO [192.168.0.106]) [84.178.12.209]
  by mail.gmx.net (mp053) with SMTP; 16 Nov 2008 15:18:39 +0100
X-Authenticated: #4107867
X-Provags-ID: V01U2FsdGVkX18m8xRM6lkm165HjxUTi6Kf4TDkYzfG7NGxHS+vwD
	xrkp/f2nPX3Uaf
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101132>

Hi,

I'm using git svn to access a subversion repository and committing to it.
Unfortunately this svn repository contains a malformed commit:
There's an empty file with svn-property svn:special *. It was created
using a windows client.

If you try to checkout this revision using svn on linux you get an
error. But using svn you have the possibility to checkout the next
revision which corrects the content of the file to "link foo/bar". So
the symlink is added to the working copy.

But with git svn I get an error when running git svn rebase. Is there
any way to skip this revision when running git svn rebase?

Thanks,
Martin
