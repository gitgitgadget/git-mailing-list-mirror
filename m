From: Ilya Dogolazky <ilya.dogolazky@nokia.com>
Subject: git-p4: commits are visible in history after 'git p4 clone', but
 not a single file present
Date: Mon, 11 Jun 2012 13:03:15 +0300
Message-ID: <4FD5C263.9010307@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 12:03:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se1T0-0005iK-6N
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 12:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118Ab2FKKDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 06:03:18 -0400
Received: from smtp.nokia.com ([147.243.128.26]:27863 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795Ab2FKKDR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 06:03:17 -0400
Received: from [172.21.81.167] (esdhcp09nok081167.ntc.nokia.com [172.21.81.167])
	by mgw-da02.nokia.com (Sentrion-MTA-4.2.2/Sentrion-MTA-4.2.2) with ESMTP id q5BA3F0H030913
	for <git@vger.kernel.org>; Mon, 11 Jun 2012 13:03:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
X-Nokia-AV: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199637>

Hi !

I hope this is the right mailing list for question regarding the usage 
of git-p4, sorry if I'm wrong.

Here is my problem: I'm issuing the command
'git p4 clone //kalma/xxx/yyy@all'. (the depot //kalma/xxx/yyy/ exists 
on my machine and is full of files). After this command the directory 
'yyy' is created and the history of commits is visible there by 'git log 
-p'.

Every commit contains author name, a title (related to the project I'm 
working on, so obviously coming from perforce depot) and a single line 
looking like this:

[git-p4: depot-paths = "//kalma/xxx/yyy/": change = 17473]

Beside of that, the commit is empty: not a single line of code is 
changed/added. And the directory 'yyy' contains only the '.git' 
subdirectory, so not a single file of the project is visible.

Please help me to understand what could be going on there, and what 
could I have done wrong.

Thanks a lot!

-- Ilya Dogolazky
