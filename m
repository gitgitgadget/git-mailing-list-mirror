From: Michael J Gruber <drmicha@warpmail.net>
Subject: Re: What are branches?
Date: Mon, 20 Apr 2009 16:27:20 +0200
Message-ID: <49EC8648.6000608@warpmail.net>
References: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de> <20090420132414.GD25059@dpotapov.dyndns.org> <49EC7E3B.9050909@drmicha.warpmail.net> <200904201614.07735.fge@one2team.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Francis Galiegue <fge@one2team.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 16:29:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvuUu-0005oX-Bw
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 16:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756077AbZDTO1a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Apr 2009 10:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756058AbZDTO13
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 10:27:29 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56780 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755878AbZDTO12 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 10:27:28 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 18B5731E4BA;
	Mon, 20 Apr 2009 10:27:28 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 20 Apr 2009 10:27:28 -0400
X-Sasl-enc: gZuXtlbguuMNl9DgiDEuKKil0VzMe/EqnW74A/CmwuxB 1240237647
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 299BA3E1BA;
	Mon, 20 Apr 2009 10:27:27 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090420 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <200904201614.07735.fge@one2team.com>
X-Enigmail-Version: 0.96a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116993>

=46rancis Galiegue venit, vidit, dixit 20.04.2009 16:14:
> Le lundi 20 avril 2009, vous avez =E9crit :
>> Dmitry Potapov venit, vidit, dixit 20.04.2009 15:24:
>>
>> There is nothing in a git commit that ties it to a specific branch; =
in
>> that sense, it does not "belong" to any.
>>
>=20
> Yes there is: the branch you are currently on (shown by, among others=
, "git=20
> branch").

No, there is not.

Proof: Delete that branch and the commit will still be there. QED

>=20
>> A git branch is a pointer to a commit. That commit and its predecess=
ors
>> are contained in the branch. A commit may be contained in multiple
>> branches, on equal footing: there is no "prime branch".
>>
>=20
> No. A commit's SHA1 depends on all other commits.

=2E..on all predecessors' SHA1s, to be exact.

Now, what does this have to do with the existence of a "prime branch",
which you claim?

>=20
> Why do you think the rebase command exists at all?
>=20

In order to change the DAG. It rewrites commits.

On the other hand: If I want to change what branch a commit "is on", I
use git branch -m to rename the branch or git reset etc. to change some
*descendant* commits of the commit in question. All of this does not
rewrite the commit in question, but changes the names resp. the number
of branches the commit is on. Which exactly proves my point.

git branches are different. Luckily they are!

Michael

P.S.: Please don't cull cc:
P.P.S.: I'll stop here with this thread. I assume you'll believe at
least Dscho if you don't believe me ;)
