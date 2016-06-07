From: Eric Wong <e@80x24.org>
Subject: Re: feature request: git svn dommit --preserve-timestamps
Date: Tue, 7 Jun 2016 00:09:02 +0000
Message-ID: <20160607000902.GA4445@dcvr.yhbt.net>
References: <87a8iy6s4e.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter =?utf-8?Q?M=C3=BCnster?= <pmlists@free.fr>
X-From: git-owner@vger.kernel.org Tue Jun 07 02:09:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA4Zy-00083N-0r
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 02:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbcFGAJF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2016 20:09:05 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55646 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbcFGAJE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 20:09:04 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12E621FEAB;
	Tue,  7 Jun 2016 00:09:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <87a8iy6s4e.fsf@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296579>

Peter M=C3=BCnster <pmlists@free.fr> wrote:
> It would be nice, if timestamps could be preserved when rewriting the
> git-log.

Unfortunately, last I checked (a long time ago!), explicitly
setting revprops might require SVN administrators to enable the
feature for the repo.

It's been a while and I'm not up-to-date with the latest SVN.
Maybe there's a newer/easier way you could give us details about :)

> Use case: I often make a dcommit after several days of development
> (20 or 30 commits), because
> - the users of the svn-server don't need it more often;
> - and for the dcommit I need a VPN-connection to a server, that is no=
t
>   always available.
>=20
> Today, after a dcommit, it's no more possible to match a special comm=
it
> by time and date (for example the time of some email exchange).

=46or now, I suggest including the date in the message body itself
to record when it was written (perhaps using git-interpret-trailers
to enforce, although I'm not familiar with that, either).
