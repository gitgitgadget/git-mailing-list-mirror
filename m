From: Anirban Mitra <anirban.m@directi.com>
Subject: Git stash bug
Date: Fri, 09 Jul 2010 11:05:28 +0530
Message-ID: <4C36B520.70105@directi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 09 07:44:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX6NR-0000YI-BM
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 07:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241Ab0GIFnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 01:43:52 -0400
Received: from smtp.directi.com ([122.182.1.139]:57054 "EHLO smtp.directi.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990Ab0GIFnv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 01:43:51 -0400
X-Greylist: delayed 492 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Jul 2010 01:43:51 EDT
Received: from smtp.directi.com (localhost.localdomain [127.0.0.1])
	by smtp.directi.com (Postfix) with ESMTP id 60DBB46D8476
	for <git@vger.kernel.org>; Fri,  9 Jul 2010 11:05:31 +0530 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=directi.com; h=
	message-id:date:from:mime-version:to:subject:content-type
	:content-transfer-encoding; s=coopa; bh=Q+rIpAVt6VgyNEZhFjm3/api
	+2RCq0Zh1t2L3GL4qq0=; b=nF36kPfO5AyYyDU0L2TW8LpRPs86erT7f+7ovKFm
	lOIwt99eWfHjHqXd+6LzL9rvVEK+pxoe5kiPEjonA0EDUrgrsQsL8vRlsxlgb43O
	Z5eAReRT8djII0A66c6+vB3B6YaH0U992KazbMefL/fmNptMsT3eKtiyppEiy6T/
	QmA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=directi.com; h=message-id
	:date:from:mime-version:to:subject:content-type
	:content-transfer-encoding; q=dns; s=coopa; b=hJh23EqgGusYtjHJwr
	ms1CDaE327PfeC8CWEckww2g2COYwFmIaSqsXx6Fun97f75ErxkP5cia6j6/Rwk4
	mKKvQiK4CC61zLvwj1G0RFP7+DusKOdNa04WS93ZmVCX+NlJaM42Bh5xmi2hlHyJ
	b3P0AvAsO7Dv9t9dPc+Z10f/0=
Received: from [115.118.212.182] (unknown [115.118.212.182])
	by smtp.directi.com (Postfix) with ESMTPA id E9F3846D841B
	for <git@vger.kernel.org>; Fri,  9 Jul 2010 11:05:30 +0530 (IST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.10pre) Gecko/20100410 Shredder/3.0.5pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150643>

Hi,

I ran into a git stash bug. I added a new project config file used by 
the IDE in a commit and later reverted the commit. But the same file 
again created by the IDE and now when I use git stash that file changes 
are also stashed. When I try stash pop, it complains that the file will 
be overwritten and aborts.

I did not expect this because I have reverted the commit adding the 
file. Is it intended behaviour? Am I missing something or is this a 
known bug and will be fixed in later releases? I am using Git version 
1.7.0.4.

-- Anirban
