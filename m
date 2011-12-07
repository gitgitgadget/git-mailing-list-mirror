From: Matthias Fechner <idefix@fechner.net>
Subject: Re: Undo a commit that is already pushed to central server and merged
 to several branches
Date: Wed, 07 Dec 2011 16:35:02 +0100
Message-ID: <4EDF87A6.4000703@fechner.net>
References: <4EDF74EC.6090504@fechner.net> <CALkWK0k46HnWTHx3iYuWFUegTgZhAMShx9MT2E83QCmxrvZOxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 16:35:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYJWl-0004wj-GV
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 16:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756503Ab1LGPfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 10:35:16 -0500
Received: from anny.lostinspace.de ([80.190.182.2]:20936 "EHLO
	anny.lostinspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755564Ab1LGPfP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 10:35:15 -0500
Received: from server.idefix.lan (ppp-93-104-88-159.dynamic.mnet-online.de [93.104.88.159])
	(authenticated bits=0)
	by anny.lostinspace.de (8.14.5/8.14.5) with ESMTP id pB7FZ42Z065925
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Wed, 7 Dec 2011 16:35:08 +0100 (CET)
	(envelope-from idefix@fechner.net)
Received: from server.idefix.lan (localhost [IPv6:::1])
	by server.idefix.lan (Postfix) with ESMTP id 3C4076B817;
	Wed,  7 Dec 2011 16:35:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at fechner.net
Received: from server.idefix.lan ([127.0.0.1])
	by server.idefix.lan (server.idefix.lan [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id bV7zvFHvBRDF; Wed,  7 Dec 2011 16:35:03 +0100 (CET)
Received: from matthias-fechners-macbook.local (unknown [192.168.20.6])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by server.idefix.lan (Postfix) with ESMTPSA id B9F506B810;
	Wed,  7 Dec 2011 16:35:03 +0100 (CET)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <CALkWK0k46HnWTHx3iYuWFUegTgZhAMShx9MT2E83QCmxrvZOxg@mail.gmail.com>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.7 (anny.lostinspace.de [80.190.182.2]); Wed, 07 Dec 2011 16:35:08 +0100 (CET)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
	autolearn=ham version=3.3.2
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on anny.lostinspace.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186463>

Am 07.12.11 15:42, schrieb Ramkumar Ramachandra:
> Assuming that you actually want to rewrite the history, the situation
> calls for a git-reset(1).  Just "git reset --hard HEAD~1" on each of
> your branches (Caution: first understand what it does!) and you'll

that will not work, because in the master branch I already have around 
15 commits after the bogus commit and I want to keep these commits.

And in some other branches there are tons of commits (over 100) after 
the bogus commit with the merge and I only want to remove that bogus 
commit but keep all other commits after the bogus commit (all commits 
are not related to the bogus one, they are all in different files).

It is even fine if I could remove the bogus commit from all branches.

Bye
Matthias

-- 
"Programming today is a race between software engineers striving to 
build bigger and better idiot-proof programs, and the universe trying to 
produce bigger and better idiots. So far, the universe is winning." -- 
Rich Cook
