From: Matthias Fechner <idefix@fechner.net>
Subject: Re: Undo a commit that is already pushed to central server and merged
 to several branches
Date: Thu, 08 Dec 2011 10:46:26 +0100
Message-ID: <4EE08772.3070703@fechner.net>
References: <4EDF74EC.6090504@fechner.net> <CALkWK0k46HnWTHx3iYuWFUegTgZhAMShx9MT2E83QCmxrvZOxg@mail.gmail.com> <4EDF87A6.4000703@fechner.net> <CALKQrgcQ5jv+oDXxDoTGUhmP-Dg344-oSotb+q-4a3fnEBY1Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Dec 08 10:46:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYaYy-0001rX-Bh
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 10:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004Ab1LHJqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 04:46:44 -0500
Received: from anny.lostinspace.de ([80.190.182.2]:28763 "EHLO
	anny.lostinspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923Ab1LHJql (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 04:46:41 -0500
Received: from server.idefix.lan (ppp-93-104-88-159.dynamic.mnet-online.de [93.104.88.159])
	(authenticated bits=0)
	by anny.lostinspace.de (8.14.5/8.14.5) with ESMTP id pB89kS0Q090872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 8 Dec 2011 10:46:32 +0100 (CET)
	(envelope-from idefix@fechner.net)
Received: from server.idefix.lan (localhost [IPv6:::1])
	by server.idefix.lan (Postfix) with ESMTP id 179E96B3C4;
	Thu,  8 Dec 2011 10:46:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at fechner.net
Received: from server.idefix.lan ([127.0.0.1])
	by server.idefix.lan (server.idefix.lan [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id CFhr-qpPaE1z; Thu,  8 Dec 2011 10:46:27 +0100 (CET)
Received: from matthias-fechners-macbook.local (unknown [192.168.20.6])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by server.idefix.lan (Postfix) with ESMTPSA id 834AE6B3B7;
	Thu,  8 Dec 2011 10:46:27 +0100 (CET)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <CALKQrgcQ5jv+oDXxDoTGUhmP-Dg344-oSotb+q-4a3fnEBY1Zw@mail.gmail.com>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.7 (anny.lostinspace.de [80.190.182.2]); Thu, 08 Dec 2011 10:46:33 +0100 (CET)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
	autolearn=ham version=3.3.2
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on anny.lostinspace.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186545>

Dear Ramkumar and Johan,

Am 07.12.11 17:01, schrieb Johan Herland:
> Use "git revert $commit" to undo the effects of the given $commit.
> This must be applied to all affected branches (either by reverting in
> the master branch and remerging master to the other branches, or by
> using "git revert" in each individual branch).

thanks a lot for your help.
The steps I did now was at first undo everything i did locally with:
git reset --hard origin/master

Then undo the bad commit:
git revert commit-id
git commit

Now the bad commit was undone and I merged the master branch in all 
other branches.

I create a new branch and cherry-picked the bad commit into it so I can 
correct the problem there and later merge this branch in all the other ones.

Hopefully this short summary will help other users having the same problem.

Bye
Matthias

-- 
"Programming today is a race between software engineers striving to 
build bigger and better idiot-proof programs, and the universe trying to 
produce bigger and better idiots. So far, the universe is winning." -- 
Rich Cook
