From: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>
Subject: Re: git rebase -i <first_commit_in_repository>
Date: Wed, 28 Oct 2009 20:24:49 +0100
Message-ID: <4AE89A81.9040407@dirk.my1.cc>
References: <2b05065b0910261014t4eb93952oc804bcd01b339a84@mail.gmail.com>	 <40aa078e0910261025l1ad7bf8ex27fd62072a317f9d@mail.gmail.com>	 <2b05065b0910261108g4a8448c8x295606a8d33612f5@mail.gmail.com>	 <4AE60669.9080402@dirk.my1.cc> <b2e43f8f0910261347m38ccb608nb5858ff1dc432b33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>,
	eschvoca <eschvoca@gmail.com>, kusmabite@gmail.com,
	git@vger.kernel.org
To: Allan Caffee <allan.caffee@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 20:25:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3E8h-0002S6-NN
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 20:25:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446AbZJ1TYt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Oct 2009 15:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752868AbZJ1TYt
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 15:24:49 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.28]:44670 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbZJ1TYt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 15:24:49 -0400
X-Greylist: delayed 168985 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Oct 2009 15:24:48 EDT
Received: from [84.176.117.197] (helo=[192.168.2.100])
	by smtprelay05.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1N3E8Y-0007p0-3c; Wed, 28 Oct 2009 20:24:50 +0100
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <b2e43f8f0910261347m38ccb608nb5858ff1dc432b33@mail.gmail.com>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131495>

Am 26.10.2009 21:47 schrieb Allan Caffee:
> 2009/10/26 Dirk S=C3=BCsserott <newsletter@dirk.my1.cc>:
>> Am 26.10.2009 19:08 schrieb eschvoca:
>> Hi,
>>
>> probably my approach could help you in the future: When I create a n=
ew repo
>> (git init) I firstly create an initial commit with nothing else than=
 an
>> initial commit, i.e.:
>>
>> $ git init
>> $ echo "initial" > initial.commit
>> $ git add initial.commit
>> $ git commit -m "Initial commit"
>=20
> I don't think this is actually necessary.  You should just be able to=
 do:
> $ git init
> $ git commit --allow-empty -m "Initial commit (empty)"
>=20

Allan,

that works great and is not as cumbersome as my solution.
Thank you!

Dirk
