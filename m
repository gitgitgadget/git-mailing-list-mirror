From: Jeff King <peff@peff.net>
Subject: Re: Odd issue - The Diffs That WILL NOT DIE.
Date: Wed, 7 Dec 2011 18:06:25 -0500
Message-ID: <20111207230625.GC21852@sigill.intra.peff.net>
References: <CAJ8P3RBm=RhNf6LKLqprqX6Rqx0OgRnJR+=+-Qhg4PvpeqaUDg@mail.gmail.com>
 <20111206215102.GA3654@centaur.lab.cmartin.tk>
 <CAJ8P3RCPt9Kwi1F7_TEkZQhkm1mwR_TFKhYszS5LL50kXU8oNQ@mail.gmail.com>
 <20111207220345.GA21596@sigill.intra.peff.net>
 <CAJ8P3RB=Gj-QCe6meqXSZ7N8+PnfNxSD8omUxT6dDh00bUf0QQ@mail.gmail.com>
 <CAJ8P3RA48W7ZiABvjkn_KkU-JPnCnaF_X_WK0wPtToph3DGDvg@mail.gmail.com>
 <20111207225827.GB641@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Patti <cpatti@gmail.com>, git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Dec 08 00:06:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYQZM-0001Je-O7
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 00:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251Ab1LGXG2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Dec 2011 18:06:28 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42942
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757627Ab1LGXG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 18:06:27 -0500
Received: (qmail 21233 invoked by uid 107); 7 Dec 2011 23:13:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Dec 2011 18:13:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Dec 2011 18:06:25 -0500
Content-Disposition: inline
In-Reply-To: <20111207225827.GB641@centaur.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186519>

On Wed, Dec 07, 2011 at 11:58:27PM +0100, Carlos Mart=C3=ADn Nieto wrot=
e:

> If you want to use OSX to develop this project, you'll have to either
> rename one of those files or set your filesystem to be case-sensitive
> (and unset core.ignorecase afterwards). From what I've heard, the OS
> itself will work fine with a case-sensitive filesystem, but not all
> applications might. YMMV.

I've never done it, but my understanding is that for HFS+, going
case-sensitive is not a simple flip of a switch, but you have to
actually make a new filesystem. Given that complexity, and the fact tha=
t
some other apps might not like it, your best bet might be to create a
new case-sensitive filesystem in a loopback file, and then mount that
just for this project.

I'm not sure of the exact commands under OS X, but I'm sure some
googling could probably turn up a solution.

-Peff
