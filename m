From: =?UTF-8?B?0KHQtdGA0LPQtdC5INCo0LDRgNGL0LHQuNC9?= 
	<nazgul@school9.perm.ru>
Subject: pre-commit hook, non-zero exit status and dangling objects
Date: Sun, 24 Aug 2008 16:57:52 +0600
Message-ID: <48B13EB0.8050704@school9.perm.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 24 12:48:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXD96-0006Cr-ER
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 12:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928AbYHXKqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 06:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752786AbYHXKqf
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 06:46:35 -0400
Received: from school9.pstu.ru ([195.19.164.124]:34482 "EHLO school9.perm.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752722AbYHXKqe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 06:46:34 -0400
Received: (qmail 24513 invoked by uid 1008); 24 Aug 2008 16:11:13 +0600
Received: from homeuser215-54.ccl.perm.ru (HELO ?192.168.1.127?) (nazgul@school9.perm.ru@89.148.215.54)
  by school9.perm.ru with SMTP; 24 Aug 2008 16:11:13 +0600
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93527>

Hi,

After pre-commit returned non-zero status, I could see new dangling 
objects in my repo. I think it's not normal, because pre-commit is often 
used for checking formation of source files and after changing this 
files, hash of object will be also changed and even after successfull 
commit dangling object will be still alive.

--
With best regards, Sergey I. Sharybin
