From: rhlee <richard@webdezign.co.uk>
Subject: Re: Preserving branches after merging on ancestor
Date: Fri, 6 Nov 2009 07:21:17 -0800 (PST)
Message-ID: <1257520877359-3959325.post@n2.nabble.com>
References: <26217077.post@talk.nabble.com> <20091105223004.GA3224@progeny.tock> <20091105232848.GA1939@atjola.homenet> <20091106010947.GB4425@progeny.tock> <20091106021038.GA27206@atjola.homenet> <20091106050353.GA8824@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 16:21:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6Qct-0007GI-05
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 16:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757677AbZKFPVM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Nov 2009 10:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756217AbZKFPVM
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 10:21:12 -0500
Received: from kuber.nabble.com ([216.139.236.158]:38413 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbZKFPVM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Nov 2009 10:21:12 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1N6Qcn-0006NE-CS
	for git@vger.kernel.org; Fri, 06 Nov 2009 07:21:17 -0800
In-Reply-To: <20091106050353.GA8824@progeny.tock>
X-Nabble-From: rhlee <richard@webdezign.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132307>


Hi John, Bj=C3=B6rn and Eric,

Thank you very much for your replies from which I gained a lot insight =
about
git merging and different workflows.

Yes, I have tried out --no-ff and it does the job for me. (Incidentally=
,
doing that take it look neater in git gui as all the master nodes appea=
r on
top of each other. Using empty commits, the merged branches appear on t=
op
the master nodes in the graph.)


Jonathan Nieder-2 wrote:
>=20
> Then your response pushed me towards the question of whether --no-ff =
is a
> good idea in general
>=20

John, I get the feeling from what you say in general that fast forwards=
 are
default behaviour for merges for a reason and by using the --no-ff opti=
on I
am making my workflow and git history uncessesarily awkward and working
against best practices?


Jonathan Nieder-2 wrote:
>=20
>> I guess Richard took the "branch topic1, merge topic1, branch topic2=
,=20
>> merge topic2" thing just as an example because that ends up with two=
=20
>> fast-forwards.
>=20
> Hmm, I found Richard=E2=80=99s example pretty realistic.  I used to w=
ork like
> that, and I don=E2=80=99t think I am the only one.
>=20

I'm not saying there is any one "right" workflow. But is there a more
suitable workflow than than "branch topic1, merge topic1, branch topic2=
,
merge topic2"?

Thanks,
Richard
--=20
View this message in context: http://n2.nabble.com/Preserving-branches-=
after-merging-on-ancestor-tp3954131p3959325.html
Sent from the git mailing list archive at Nabble.com.
