From: Jeff King <peff@peff.net>
Subject: Re: git smart-http do not authent to allow git ls-remote to be
 called anonymously
Date: Sun, 14 Oct 2012 02:30:22 -0400
Message-ID: <20121014063022.GA14812@sigill.intra.peff.net>
References: <CAHtLG6Q+XO=LhnKw4hhwtOe2ROeDN1Kg=JN5GTQqdvYjk-Sv4g@mail.gmail.com>
 <20121001010935.GA18987@sigill.intra.peff.net>
 <CAHtLG6QFu1rOfUeWREwVG540WvXtM1SnH6aHEJ9dKLzwNxbkVg@mail.gmail.com>
 <CAHtLG6T=hFsSy=ScRK2cYBoUcmAG_tsg12FiFMTvzpHGmPTzfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 08:30:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNHid-00026s-Hw
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 08:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422Ab2JNGaZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2012 02:30:25 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51975 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359Ab2JNGaY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 02:30:24 -0400
Received: (qmail 18608 invoked by uid 107); 14 Oct 2012 06:30:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 14 Oct 2012 02:30:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Oct 2012 02:30:22 -0400
Content-Disposition: inline
In-Reply-To: <CAHtLG6T=hFsSy=ScRK2cYBoUcmAG_tsg12FiFMTvzpHGmPTzfg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207643>

[re-adding git@vger; please keep discussion on-list]

On Sun, Oct 14, 2012 at 01:29:13PM +0800, =E4=B9=99=E9=85=B8=E9=8B=B0 w=
rote:

> Sorry, it does not serve the request. It returns http 401.
> But if I add the username and password as a part of the URL, it succe=
eds.

In that case, then you probably need to upgrade your client version of
git, as I mentioned here:

> >> Or is it that the server tells git that it needs authorization, bu=
t git
> >> does not prompt, and instead just fails with "Authentication faile=
d". In
> >> that case, the issue is that you need a newer git client. Traditio=
nally
> >> the client expected to handle authentication during the initial
> >> "info/refs" request. I added support for handling authentication d=
uring
> >> later requests in commit b81401c, which is in git v1.7.11.7 and
> >> v1.7.12.1.

-Peff
