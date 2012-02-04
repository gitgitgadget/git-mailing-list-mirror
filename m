From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] t: mailmap: add simple name translation test
Date: Sat, 4 Feb 2012 18:42:37 -0500
Message-ID: <20120204234237.GB1366@sigill.intra.peff.net>
References: <1328385024-6955-1-git-send-email-felipe.contreras@gmail.com>
 <1328385024-6955-4-git-send-email-felipe.contreras@gmail.com>
 <20120204201218.GF22928@burratino>
 <CAMP44s1ZPQJzHzYj7e4Kj3Cu+qq0Q3uKrwsE=xS7BmmSqd3gSw@mail.gmail.com>
 <20120204211544.GC3278@burratino>
 <CAMP44s0Z=k6VBfv0HOGHyMBLRcPauK7K5RNvuRDbfq5=5aKVpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Jim Meyering <jim@meyering.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 05 00:42:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtpFk-0007lH-Kk
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 00:42:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495Ab2BDXmk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Feb 2012 18:42:40 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57882
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753829Ab2BDXmk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 18:42:40 -0500
Received: (qmail 13450 invoked by uid 107); 4 Feb 2012 23:49:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 04 Feb 2012 18:49:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Feb 2012 18:42:37 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s0Z=k6VBfv0HOGHyMBLRcPauK7K5RNvuRDbfq5=5aKVpg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189923>

On Sun, Feb 05, 2012 at 12:19:53AM +0200, Felipe Contreras wrote:

> > Thanks. =C2=A0I guess you think I'm stupid. =C2=A0I have no idea ho=
w I can
> > correct that assumption and help you to actually work with me to ma=
ke
> > the code better. :/
>=20
> You mean the commit message, you haven't made any comment about the c=
ode.
>=20
> If you want to know why I had to modify those test assertions, you
> really need to look at the code. In essence; all of them use the same
> repo, and obviously adding a new commit message changes the output of
> the commands.

Then say that in the commit message.

Looking at this series, I wonder if the tests should simply be squashed
into the bugfix patch, which might make what is going on more obvious.
Keep in mind that as reviewers now, we read the whole series. But in a
year, as "git log" users, we may see the commits in isolation.

-Peff
