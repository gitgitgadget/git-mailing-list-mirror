From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Use of tac in git-rebase--interactive
Date: Sun, 27 Apr 2008 02:24:18 -0400
Message-ID: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 08:25:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq0Jv-0003fu-UD
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 08:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406AbYD0GYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 02:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbYD0GYV
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 02:24:21 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:59867 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbYD0GYU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 02:24:20 -0400
Received: from [192.168.1.7] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 89B741FFC39B
	for <git@vger.kernel.org>; Sun, 27 Apr 2008 06:24:07 +0000 (UTC)
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80420>

Commit d481bcc9: "Do rebase with preserve merges with advanced TODO  
list" uses the command tac, apparently to reverse the TODO command  
list.  (I don't use rebase -i much, if you can't tell.)

The problem is that tac doesn't exist on my OS X system.  I do appear  
to have a rev command which does the same thing.  Simply posting a  
patch that does 472s/tac/rev/ would fix the problem on my system, but  
the fact that this is an issue raises the question of the relative  
portability of the two commands.  I don't think we have a declared  
dependancy on GNU's coreutils, which is where Debian lists tac as  
coming from.

~~ Brian
