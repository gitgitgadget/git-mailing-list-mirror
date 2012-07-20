From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Feature request: fetch --prune by default
Date: Fri, 20 Jul 2012 09:11:44 +0200
Message-ID: <500904B0.9030309@viscovery.net>
References: <2C63E314-2EF5-4B8E-B96A-5306E317E045@gmail.com> <20120719115558.GC29774@sigill.intra.peff.net> <88300470-AB41-4317-8B97-81DC18FD5899@gmail.com> <20120719213438.1cc7ca77a9cb3367a3be0539@domain007.com> <E94B0D74-2BB8-4B3E-BFB9-A2CFE9C2A7BB@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Alexey Muranov <alexey.muranov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 09:12:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ss7Nj-0003eO-4R
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 09:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074Ab2GTHMA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jul 2012 03:12:00 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:17276 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752630Ab2GTHLt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jul 2012 03:11:49 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ss7NI-0006Yz-VV; Fri, 20 Jul 2012 09:11:45 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id AD1331660F;
	Fri, 20 Jul 2012 09:11:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <E94B0D74-2BB8-4B3E-BFB9-A2CFE9C2A7BB@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201760>

Am 7/19/2012 23:20, schrieb Alexey Muranov:
> On 19 Jul 2012, at 19:34, Konstantin Khomoutov wrote:
>=20
>> On Thu, 19 Jul 2012 18:21:21 +0200 Alexey Muranov
>> <alexey.muranov@gmail.com> wrote:
>>=20
>> [...]
>>> I do not still understand very well some aspects of Git, like the=20
>>> exact purpose of "remote tracking branches" (are they for pull or
>>> for push?), so i may be wrong.
>> This is wery well explained in the Pro Git book, for instance. And i=
n
>> numerous blog posts etc.
>=20
> I have read the Pro Gut book and numerous blog posts, but i keep
> forgetting the explanation because it does not make much sense to me:
>=20
> "Tracking branches are local branches that have a direct relationship
> to a remote branch.  If you=92re on a tracking branch and type git pu=
sh,
> Git automatically knows which server and branch to push to.  Also,
> running git pull while on one of these branches fetches all the remot=
e
> references and then automatically merges in the corresponding remote
> branch." etc.

Note the difference between "tracking branch" and "remote tracking
branch"! The "remote tracking branches" are the refs in the refs/remote=
s/
hierarchy. The "tracking branches" are your own local branches that you
have created with 'git branch topic thatremote/topic' (or perhaps 'git
checkout -b'). The paragraph talks about the latter.

-- Hannes
