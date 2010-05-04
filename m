From: Jeff King <peff@peff.net>
Subject: Re: While the awesome switch is always on, so is the confusion
 switch.
Date: Tue, 4 May 2010 17:08:19 -0400
Message-ID: <20100504210819.GB10716@coredump.intra.peff.net>
References: <28447763.post@talk.nabble.com>
 <z2m57518fd11005040924oa4e609d3g9e7cc57c6fb52992@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: xuinkrbin <nabble.20.xuinkrbin@spamgourmet.com>,
	git@vger.kernel.org
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Tue May 04 23:08:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9PLy-0004k3-CT
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 23:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933734Ab0EDVIX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 May 2010 17:08:23 -0400
Received: from peff.net ([208.65.91.99]:42442 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756563Ab0EDVIW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 17:08:22 -0400
Received: (qmail 14347 invoked by uid 107); 4 May 2010 21:08:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 04 May 2010 17:08:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 04 May 2010 17:08:19 -0400
Content-Disposition: inline
In-Reply-To: <z2m57518fd11005040924oa4e609d3g9e7cc57c6fb52992@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146344>

On Tue, May 04, 2010 at 05:24:34PM +0100, Jonathan del Strother wrote:

> > to head but no stashes. =C2=A0I run 'git stash list' to verify the =
lack of
> > stashes and receive the following message:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0fatal: bad object refs/stash
> I can't reproduce this - what does 'git --version' say?

Just a guess, but probably pre-v1.6.1:

  $ git show 0e32126
  commit 0e32126f04f6ad64826d4c145f2a1a9685e0910d
  Author: Junio C Hamano <gitster@pobox.com>
  Date:   Sun Dec 7 17:30:35 2008 -0800

      Revert "git-stash: use git rev-parse -q"

      This reverts commit 757c7f60a78004fc3d0ea62f44320d54ef430c10 as a=
n
      unnecessary error message to pop up when the last stash entry is
      dropped.

      It simply is not worth the aggravation.

  $ git describe --contains 0e32126
  v1.6.1-rc2~1

-Peff
