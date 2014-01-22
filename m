From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 00/11] git p4 tests and a few bug fixes
Date: Wed, 22 Jan 2014 17:44:21 -0500
Message-ID: <20140122224421.GB4047@padd.com>
References: <1390346208-9207-1-git-send-email-pw@padd.com>
 <xmqqfvogsx0o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 22 23:44:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W66X7-0004Ak-Od
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 23:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130AbaAVWo0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jan 2014 17:44:26 -0500
Received: from honk.padd.com ([74.3.171.149]:43723 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752130AbaAVWoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 17:44:25 -0500
Received: from arf.padd.com (unknown [50.105.0.78])
	by honk.padd.com (Postfix) with ESMTPSA id 7299F712D;
	Wed, 22 Jan 2014 14:44:24 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id C827C200AB; Wed, 22 Jan 2014 17:44:21 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <xmqqfvogsx0o.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240871>

gitster@pobox.com wrote on Tue, 21 Jan 2014 16:03 -0800:
> Pete Wyckoff <pw@padd.com> writes:
[..]
> > Patch 03 is a regression fix, found and narrowed down thanks to
> > much work by Damien G=E9rard.  But it is obscure enough that I'm
> > not proposing it for a maintenance release.
>=20
> Thanks.
>=20
> I am inclined to say that we should queue this on a fork from
> 'maint, merge the result to 'master' before 1.9-rc1 and ship the
> result as part of the upcoming release, and then possibly merging
> the topic to 1.8.5.x maintenance release after that.
>=20
> This is primarily because I personally do not have p4 expertise to
> test or properly judge this (iow, you are the area maintainer, the
> authority), and I somehow have this feeling that parking in 'next'
> for extended period of time would not give meaningfully larger
> exposure to the code.
>=20
> What do you think?
>=20
> If you feel uneasy about such a fast-track, I wouldn't push it,
> though.

I think you're right that fast-track is the best choice, and low
risk.  The diffs came out identical, and it merges cleanly to
master, and passes all tests in both.

Thanks Eric for the commit message fixes too!

Here comes a v2 that is otherwise identical, but based on
origin/maint from a couple weeks ago.

		-- Pete
