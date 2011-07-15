From: Marlene Cote <Marlene_Cote@affirmednetworks.com>
Subject: RE: [PATCH] git-submodule: Remove duplicate entries during merge
 with conflict
Date: Fri, 15 Jul 2011 20:32:59 +0000
Message-ID: <1F026B57884A5841B330471696849DE9113122B5@MBX021-W4-CA-5.exch021.domain.local>
References: <4D81C1AA.5010008@morey-chaisemartin.com>
 <1310668419989-6584432.post@n2.nabble.com> <4E2094B4.3090009@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Jens.Lehmann@web.de" <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Jul 15 22:33:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qhp4d-0000q4-R0
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 22:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718Ab1GOUdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 16:33:03 -0400
Received: from hub021-ca-5.exch021.serverdata.net ([64.78.56.70]:17868 "EHLO
	hub021-ca-5.exch021.serverdata.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751471Ab1GOUdC convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 16:33:02 -0400
Received: from MBX021-W4-CA-5.exch021.domain.local ([10.254.4.87]) by
 HUB021-CA-5.exch021.domain.local ([10.254.4.89]) with mapi id 14.01.0289.001;
 Fri, 15 Jul 2011 13:33:00 -0700
Thread-Topic: [PATCH] git-submodule: Remove duplicate entries during merge
 with conflict
Thread-Index: AQHMQlSPzLshfnNQwE6aX5mIfLD4o5TuOz4A//+cx/A=
In-Reply-To: <4E2094B4.3090009@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [173.48.37.154]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177226>

How would you find an appropriate commit?

--------------------------
Regards,
Marlene Cote
Affirmed Networks
978-268-0821 


->-----Original Message-----
->From: Jens.Lehmann@web.de [mailto:Jens.Lehmann@web.de]
->Sent: Friday, July 15, 2011 3:28 PM
->To: Marlene Cote
->Cc: git@vger.kernel.org
->Subject: Re: [PATCH] git-submodule: Remove duplicate entries during merge with conflict
->
->Am 14.07.2011 20:33, schrieb funeeldy:
->> How can new users of git submodules learn about merge conflicts?  When and
->> why they occur, and how to resolve them in a way that doesn't lose commits?
->
->That is pretty similar to merge conflicts in regular files: They happen
->when you merge two branches where both sides changed the recorded submodule
->commit to another one (and those are not the same). The resolution can be
->done by finding a submodule commit that has both changes. In most cases that
->will be based on a merge (maybe even a fast forward) with both commits in
->its history.
->
->If git finds a fast forward from the merge base to commit1 and commit2
->(let's say they both are on master and newer than the merge base), the
->newer one is picked automatically. If git finds a single merge from which
->both commits are reachable, it proposes that as conflict resolution and
->tells you  how you can stage that. Only if it doesn't find any or more
->than two merges, you are on your own and have to resolve the conflict
->manually by finding an appropriate commit.
->
->> If I have to choose my version or their version, that isn't really a merge,
->> or is it?
->
->It would be if the merge strategy is "ours" or "theirs". But in most normal
->cases you would want to have both commits reachable from the merge result.
