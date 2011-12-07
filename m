From: Matthias Fechner <idefix@fechner.net>
Subject: Undo a commit that is already pushed to central server and merged
 to several branches
Date: Wed, 07 Dec 2011 15:15:08 +0100
Message-ID: <4EDF74EC.6090504@fechner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 07 15:15:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYIHP-0002ZY-IG
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 15:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755955Ab1LGOPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 09:15:22 -0500
Received: from anny.lostinspace.de ([80.190.182.2]:29207 "EHLO
	anny.lostinspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755902Ab1LGOPV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 09:15:21 -0500
Received: from server.idefix.lan (ppp-93-104-88-159.dynamic.mnet-online.de [93.104.88.159])
	(authenticated bits=0)
	by anny.lostinspace.de (8.14.5/8.14.5) with ESMTP id pB7EFAwU049956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 7 Dec 2011 15:15:15 +0100 (CET)
	(envelope-from idefix@fechner.net)
Received: from server.idefix.lan (localhost [IPv6:::1])
	by server.idefix.lan (Postfix) with ESMTP id EE5C16BF41
	for <git@vger.kernel.org>; Wed,  7 Dec 2011 15:15:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at fechner.net
Received: from server.idefix.lan ([127.0.0.1])
	by server.idefix.lan (server.idefix.lan [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Tj6J5njfE7Nv for <git@vger.kernel.org>;
	Wed,  7 Dec 2011 15:15:09 +0100 (CET)
Received: from matthias-fechners-macbook.local (unknown [192.168.20.6])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by server.idefix.lan (Postfix) with ESMTPSA id 7ED4D6BF3A
	for <git@vger.kernel.org>; Wed,  7 Dec 2011 15:15:09 +0100 (CET)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:8.0) Gecko/20111105 Thunderbird/8.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.7 (anny.lostinspace.de [80.190.182.2]); Wed, 07 Dec 2011 15:15:15 +0100 (CET)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
	autolearn=ham version=3.3.2
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on anny.lostinspace.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186455>

Dear git list,

I commited two files into the master branch (later I figured out that 
the files included a lot bugs).

I continued to work then on different branches and merged the bad master 
branch to all my other branches.

I pushed the master branch then to the server including the bogus commit.

What I would like to do is move this bogus commit into a different 
branch and remove all changes from this bogus commit from every branch.

Is this possible and how?

Bye
Matthias

-- 
"Programming today is a race between software engineers striving to 
build bigger and better idiot-proof programs, and the universe trying to 
produce bigger and better idiots. So far, the universe is winning." -- 
Rich Cook
