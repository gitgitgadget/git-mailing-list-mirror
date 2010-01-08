From: martinvz <martin.von.zweigbergk@gmail.com>
Subject: Re: Difference between pull --rebase and fetch+rebase
Date: Fri, 8 Jan 2010 11:41:16 -0800 (PST)
Message-ID: <1262979676402-4274470.post@n2.nabble.com>
References: <27059158.post@talk.nabble.com> <adf1fd3d1001070800k6fa501fej39b84f849b7e5b50@mail.gmail.com> <1262889864880-4268064.post@n2.nabble.com> <adf1fd3d1001071433j6cd36641sdd2dfd6a936d8483@mail.gmail.com> <1262907485376-4269422.post@n2.nabble.com> <adf1fd3d1001080305k138a2670k17a126cc0b8430b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 20:41:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTKi2-0005kT-O7
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 20:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925Ab0AHTlR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jan 2010 14:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753888Ab0AHTlR
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 14:41:17 -0500
Received: from kuber.nabble.com ([216.139.236.158]:39562 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823Ab0AHTlR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2010 14:41:17 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1NTKhw-0002Ba-DD
	for git@vger.kernel.org; Fri, 08 Jan 2010 11:41:16 -0800
In-Reply-To: <adf1fd3d1001080305k138a2670k17a126cc0b8430b8@mail.gmail.com>
X-Nabble-From: martinvz <martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136465>



Santi B=C3=A9jar-2 wrote:
>=20
> Yes, it is. The code expects that you always branch your topic
> branches from the upstream branch, so all the possible fork points ar=
e
> in the reflog. Your flow was to create the topic from a local commit
> and then push that commit.
>=20

Thanks, Santi! After thinking for a while about what you said, I think =
I
understand. That could definitely be what I did, although I can't remem=
ber
for sure.

Would it make sense to teach "git rebase" the same tricks as "git pull
--rebase"?


Santi B=C3=A9jar-2 wrote:
>=20
> By the way, when Git tries to apply these two commits it should detec=
t
> that they are already applied so it should do nothing, isn't it?
>=20

Almost - it fails, but the merge tool resolves it automatically.


Martin
--=20
View this message in context: http://n2.nabble.com/Difference-between-p=
ull-rebase-and-fetch-rebase-tp4266164p4274470.html
Sent from the git mailing list archive at Nabble.com.
