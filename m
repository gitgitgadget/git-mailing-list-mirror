From: Kumar Gala <kumar.gala@freescale.com>
Subject: cg-help question
Date: Thu, 18 Aug 2005 09:48:58 -0500
Message-ID: <31C299E0-1EE6-47C8-AE99-E7BEBCC5F01F@freescale.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 18 16:50:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5lhO-000263-78
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 16:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbVHROsv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 10:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVHROsv
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 10:48:51 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:8087 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S932240AbVHROsv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 10:48:51 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id j7IEvR91012924
	for <git@vger.kernel.org>; Thu, 18 Aug 2005 07:57:27 -0700 (MST)
Received: from [192.168.123.110] ([10.214.72.177])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id j7IErOop004386
	for <git@vger.kernel.org>; Thu, 18 Aug 2005 09:53:55 -0500 (CDT)
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.734)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

cg-help has the following in it

print_command_listing()
{
         for command in "$@"; do
                 [ -f "$command" -a ! -L "$command" ] || continue
                 cmdname=$(basename $command)
...
}

I was wondering what the  [ -f "$command" -o ! -L "$command" ] is  
trying to test for.  In my install the cg-commands are actually  
symlinks.  And this test breaks cg-help from reporting the command  
list properly.

thanks

- kumar
