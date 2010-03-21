From: Benjamin Meyer <ben@meyerhome.net>
Subject: Re: [PATCH 2/4] pull: use --quiet rather than 2>/dev/null
Date: Sun, 21 Mar 2010 13:34:10 -0400
Message-ID: <E2F911AD-19C6-43BF-BBBD-735D30885F21@meyerhome.net>
References: <1269051518-25099-1-git-send-email-bmeyer@rim.com> <1269051518-25099-2-git-send-email-bmeyer@rim.com> <20100320123520.GA29041@progeny.tock> <818FE4EC-5AE9-4F05-B9AD-E1753F7ED9E6@meyerhome.net> <20100321043330.GA9803@progeny.tock>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 18:34:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtP2Y-0004zE-2Y
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 18:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787Ab0CUReN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Mar 2010 13:34:13 -0400
Received: from qmta14.westchester.pa.mail.comcast.net ([76.96.59.212]:34478
	"EHLO qmta14.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752269Ab0CUReM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 13:34:12 -0400
Received: from omta01.westchester.pa.mail.comcast.net ([76.96.62.11])
	by qmta14.westchester.pa.mail.comcast.net with comcast
	id vtNG1d00G0EZKEL5EtaC2Q; Sun, 21 Mar 2010 17:34:12 +0000
Received: from [192.168.3.101] ([71.192.50.29])
	by omta01.westchester.pa.mail.comcast.net with comcast
	id vtaB1d00D0dnthT3MtaC7w; Sun, 21 Mar 2010 17:34:12 +0000
In-Reply-To: <20100321043330.GA9803@progeny.tock>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142845>


On Mar 21, 2010, at 12:33 AM, Jonathan Nieder wrote:

> Hi again,
>=20
> Benjamin Meyer wrote:
>=20
>> re-checking the other patches I think they are correct in their
>> usage.
>=20
> Thanks for checking.
>=20
>> I ran the matching tests, the rebase ones passed,
>> 3903-stash.sh is already failing before my patch and
>> t3904-stash-patch.sh continues passing with the patch.  Other then
>> running the tests in t/ is there anything I should do to verify
>> patches?
>=20
> Regarding testing: the best thing to do IMHO is to explain in the com=
mit
> message what effect the patch will have.  Then reviewers (including y=
ou)
> can read it and try it out to make sure what you say is true.
>=20
> The test suite is not very good for checking that a patch does what
> it=92s meant to do, but that=92s okay, since it has a different purpo=
se [1].
>=20
> As an example of what I mean, here is your patch 1/4 again (untested,
> though).  I didn=92t add any tests since it would be kind of hard to
> provoke address space exhaustion at just the right moment.

[snip]

Thanks for the example.  I will try to include a more full explanation =
for my changes in the future so it can be more easily reviewed.

-Benjamin Meyer