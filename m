From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Blaming diffs
Date: Mon, 17 Sep 2007 00:57:04 -0400
Message-ID: <20070917045704.GH3099@spearce.org>
References: <20070916163829.GA6679@glandium.org> <200709170659.15655.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 06:57:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX8ff-0008Cq-1k
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 06:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbXIQE5P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Sep 2007 00:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbXIQE5P
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 00:57:15 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51380 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbXIQE5O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Sep 2007 00:57:14 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IX8fV-0002LW-Nh; Mon, 17 Sep 2007 00:57:09 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7421420FBAE; Mon, 17 Sep 2007 00:57:05 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200709170659.15655.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58387>

Christian Couder <chriscool@tuxfamily.org> wrote:
> Le dimanche 16 septembre 2007, Mike Hommey a =C3=A9crit :
> >
> > It seems to me there is no tool to "blame diffs", i.e. something to=
 know
> > what commit(s) is(are) responsible for a set of changes.
>=20
> I don't know if that's what you are looking for but perhaps you could=
=20
> use "git bisect run". You just need to pass it a script that returns =
1 when=20
> it finds the changes and 0 otherwise. (See git-bisect man page.)

That's very inefficient to search for something...
=20
> Sometimes ago I sent a patch that would allow "!" after "git bisect r=
un",=20
> but it seems to have been forgotten. This patch makes it possible to =
use:
>=20
> git bisect run ! grep some_stuff file1 file2...
>=20
> This would give you the commit where some_stuff was introduced in fil=
e1 or=20
> file2...

Is `git log -Ssome_stuff -- file1 file2` somehow not working for you?

--=20
Shawn.
