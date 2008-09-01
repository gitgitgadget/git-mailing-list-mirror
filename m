From: =?UTF-8?B?0KHQtdGA0LPQtdC5INCo0LDRgNGL0LHQuNC9?= 
	<nazgul@school9.perm.ru>
Subject: Stranges with git-diff-index
Date: Mon, 01 Sep 2008 15:28:20 +0600
Message-ID: <48BBB5B4.9080805@school9.perm.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 01 11:16:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka5W6-0006XN-PL
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 11:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbYIAJPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 05:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbYIAJPA
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 05:15:00 -0400
Received: from school9.pstu.ru ([195.19.164.124]:49654 "EHLO school9.perm.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750840AbYIAJO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 05:14:59 -0400
Received: (qmail 26006 invoked by uid 1008); 1 Sep 2008 14:38:47 +0600
Received: from homeuser215-54.ccl.perm.ru (HELO ?192.168.1.127?) (nazgul@school9.perm.ru@89.148.215.54)
  by school9.perm.ru with SMTP; 1 Sep 2008 14:38:47 +0600
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94546>

Hi,

I've found this strange thing in git diff-index. I've got a clear work
tree (all changes are commited). Then I've changed some files. After
this I've run `git diff-index --name-status HEAD` and this command
showed me changed files. After this I've undid this changes (I did this
myself, not using git-reset or any stuff like this). But when I run this
command again it showed me that this files are still changed. After this
I've run git-status and it told me that there is nothing to commit. And
after this git-diff-index tells me that there is no changed files too.

I think it's not normal.

-- 
With best regards, Sergey I. Sharybin
