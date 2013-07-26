From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] branch: make sure the upstream remote is configured
Date: Fri, 26 Jul 2013 14:48:15 -0400
Message-ID: <20130726184815.GB29799@sigill.intra.peff.net>
References: <1374860377-17652-1-git-send-email-cmn@elego.de>
 <20130726184311.GA29799@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Jul 26 20:48:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2n3u-0005Dq-3V
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 20:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612Ab3GZSsS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jul 2013 14:48:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:59758 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751094Ab3GZSsR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 14:48:17 -0400
Received: (qmail 1607 invoked by uid 102); 26 Jul 2013 18:48:18 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 26 Jul 2013 13:48:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jul 2013 14:48:15 -0400
Content-Disposition: inline
In-Reply-To: <20130726184311.GA29799@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231195>

On Fri, Jul 26, 2013 at 02:43:11PM -0400, Jeff King wrote:

> On Fri, Jul 26, 2013 at 07:39:37PM +0200, Carlos Mart=C3=ADn Nieto wr=
ote:
>=20
> > A command of e.g.
> >=20
> >     git push --set-upstream /tmp/t master
> >=20
> > will call install_branch_config() with a remote name of "/tmp/t". T=
his
> > function will set the 'branch.master.remote' key to, which is
> > nonsensical as there is no remote by that name.
>=20
> Is it nonsensical? It does not make sense for the @{upstream} magic
> token, because we will not have a branch in tracking branch refs/remo=
tes

Eh, I am incapable of typing (and proofreading). That should be "not
have a tracking branch in refs/remotes".

-Peff
