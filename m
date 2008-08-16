From: =?UTF-8?B?0KHQtdGA0LPQtdC5INCo0LDRgNGL0LHQuNC9?= 
	<nazgul@school9.perm.ru>
Subject: Problem with --work-tree
Date: Sun, 17 Aug 2008 03:14:13 +0600
Message-ID: <48A74325.1040805@school9.perm.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 16 23:03:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUSvm-0001y9-Qe
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 23:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbYHPVCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 17:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbYHPVCW
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 17:02:22 -0400
Received: from school9.pstu.ru ([195.19.164.124]:60511 "EHLO school9.perm.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082AbYHPVCW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2008 17:02:22 -0400
Received: (qmail 24163 invoked by uid 1008); 17 Aug 2008 02:27:46 +0600
Received: from homeuser215-54.ccl.perm.ru (HELO ?192.168.1.127?) (nazgul@school9.perm.ru@89.148.215.54)
  by school9.perm.ru with SMTP; 17 Aug 2008 02:27:46 +0600
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92557>

Hi,

I've got the following problem. I've got a GIT repo at 
/home/nazgul/src/test-work-tree and I've got some changed files in this 
repo. I want to see this changes when a `git` runs outside this 
directory. I tried to run `git 
--git-dir=/home/nazgul/src/test-work-tree/.git 
--work-tree=/home/nazgul/src/test-work-tree diff-index --name-status 
HEAD` from my home directory. In such way diff-index tells me that all 
files from my repo has been deleted. I think it is because this command 
does not understand a --work-tree parameter. And I saw the same problem 
with a git diff command (something like that: git 
--git-dir=/home/nazgul/src/test-work-tree/.git 
--work-tree=/home/nazgul/src/test-work-tree diff).

I use git version debian.1.5.6.3.1

Is it my mistake or it is bugs in a GIT?

-- 
With best regards, Sergey I. Sharybin
