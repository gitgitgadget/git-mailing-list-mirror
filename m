From: Jeff King <peff@peff.net>
Subject: Re: Tracked files become untracked in some obscure scenario
Date: Tue, 9 Aug 2011 20:51:25 -0600
Message-ID: <20110810025125.GA8554@sigill.intra.peff.net>
References: <CAGR+nnFM+Pr29h4POarx5rQdrTuMvtwwZLwVPZuChSDKQjLg4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?U3TDqXBoYW5l?= Corlosquet <scorlosquet@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 10 04:52:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qqyuc-00050t-Rr
	for gcvg-git-2@lo.gmane.org; Wed, 10 Aug 2011 04:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096Ab1HJCv3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Aug 2011 22:51:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55196
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752019Ab1HJCv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2011 22:51:29 -0400
Received: (qmail 11492 invoked by uid 107); 10 Aug 2011 02:52:05 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 09 Aug 2011 22:52:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Aug 2011 20:51:25 -0600
Content-Disposition: inline
In-Reply-To: <CAGR+nnFM+Pr29h4POarx5rQdrTuMvtwwZLwVPZuChSDKQjLg4g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179055>

On Tue, Aug 09, 2011 at 03:59:08PM -0400, St=C3=A9phane Corlosquet wrot=
e:

> I'm encountering a very strange bug where some directory containing
> one file becomes untracked when it should be tracked. I originally
> found this bug in a bigger repository, but I isolated the culprit
> files into a small tarball which you can download from
> http://files.openspring.net/tmp/gitbug-20110809.tgz
>=20
> This bug occurs on the following three configs:
> Mac OS X Snow Leopard with git=C2=A01.7.4.1
> Mac OS X Snow Leopard with git=C2=A01.7.5
> Mac OS X Lion with git=C2=A01.7.4.4
> I could not reproduce on Ubuntu.

I suspect this may be another case of this bug:

  http://thread.gmane.org/gmane.comp.version-control.git/173612/focus=3D=
174634

Does the patch posted in that thread[1] make the problem go away?

-Peff

[1] The actual patch is in:

    http://article.gmane.org/gmane.comp.version-control.git/174636
