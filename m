From: Stefan <bugs@innuce.ch>
Subject: Possible Bug in git-http-push
Date: Fri, 10 Apr 2015 13:15:34 +0200
Message-ID: <5527B0D6.3010608@innuce.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 10 13:24:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YgX2L-00033K-RI
	for gcvg-git-2@plane.gmane.org; Fri, 10 Apr 2015 13:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753710AbbDJLXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2015 07:23:45 -0400
Received: from mail.innuce.ch ([80.254.167.118]:45262 "EHLO mail.innuce.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609AbbDJLXo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2015 07:23:44 -0400
X-Greylist: delayed 485 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Apr 2015 07:23:44 EDT
Received: from [10.13.0.8] ([10.13.0.8]:15215)
	by mail.innuce.ch ([10.13.0.2]:465) with [XMail 1.27 SSLtag 0.2 ESMTP Server]
	id <SA4E69> for <git@vger.kernel.org> from <bugs@innuce.ch>;
	Fri, 10 Apr 2015 13:15:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267008>

Hello List

I possibly found a bug in git-http-push:

When I push my local repo via http secured with basic authorization,
then i get:

error: Cannot access URL https://example.ch/example_repo/, return code 22
fatal: git-http-push failed
Pushing to https://example.ch/example_repo/

My server log gives PROPPFIND 401, so i seems that the PROPPFIND-sent
by git-http-push does not use supplied username/pw via prompt

Pulling works without problems.

When I change remote URL to
https://user:password@example.ch/example_repo, pushing works.

I'm using git version 1.9.5.msysgit.1

Thanks
Stefan
