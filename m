From: Matthias Fechner <idefix@fechner.net>
Subject: Git and svn as target
Date: Thu, 10 Jun 2010 07:45:15 +0200
Message-ID: <4C107BEB.6020209@fechner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 10 07:48:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMaci-0007Mw-Dy
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 07:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972Ab0FJFsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 01:48:08 -0400
Received: from anny.lostinspace.de ([80.190.182.2]:31239 "EHLO
	anny.lostinspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712Ab0FJFsH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 01:48:07 -0400
Received: from server.idefix.lan (ppp-88-217-54-73.dynamic.mnet-online.de [88.217.54.73])
	(authenticated bits=0)
	by anny.lostinspace.de (8.14.3/8.14.3) with ESMTP id o5A5lwi6083220
	for <git@vger.kernel.org>; Thu, 10 Jun 2010 07:48:02 +0200 (CEST)
	(envelope-from idefix@fechner.net)
Received: from server.idefix.lan (unknown [127.0.0.1])
	by server.idefix.lan (Postfix) with ESMTP id 24EBF79E7
	for <git@vger.kernel.org>; Thu, 10 Jun 2010 07:47:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at server.idefix.lan
Received: from server.idefix.lan ([127.0.0.1])
	by server.idefix.lan (server.idefix.lan [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tm6IUGTbpEpV for <git@vger.kernel.org>;
	Thu, 10 Jun 2010 07:47:48 +0200 (CEST)
Received: from matthias-fechners-macbook.local (tmo-100-229.customers.d1-online.com [80.187.100.229])
	by server.idefix.lan (Postfix) with ESMTPA id 3795079CF
	for <git@vger.kernel.org>; Thu, 10 Jun 2010 07:47:48 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.5 (anny.lostinspace.de [80.190.182.2]); Thu, 10 Jun 2010 07:48:02 +0200 (CEST)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
	autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on anny.lostinspace.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148830>

Hi,

i started now to work with git instead of svn. The main repository is a 
svn repo so i use git svn ...

But I have the problem now, commit comments are not transfered to svn, 
maybe I miss here a parameter.

What i did:
git svn fetch
git svn rebase
git branch test
git checkout test
several commits
git checkout master
git svn fetch
git svn rebase
git merge test
git svn dcommit

In the commit of svn I see only merged test...
Could I say git to put all the commit comments into the merge?

Gruss,
Matthias

-- 
"Programming today is a race between software engineers striving to build bigger and better idiot-proof programs, and the universe trying to produce bigger and better idiots. So far, the universe is winning." -- Rich Cook
