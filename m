From: Jeff King <peff@peff.net>
Subject: Re: push race
Date: Mon, 15 Oct 2012 14:58:02 -0400
Message-ID: <20121015185802.GD31658@sigill.intra.peff.net>
References: <CAB9Jk9Be4gGaBXixWN7Xju7N6RGKH+FonhaTbZFJ6uYsJDk8dg@mail.gmail.com>
 <CACBZZX5keWVDZ-rvQfHFChKRC1YwXcUvfiqzgeMjVTydnQCdmg@mail.gmail.com>
 <507C1DB4.2010000@xiplink.com>
 <CAB9Jk9A8E57byg+1yzc22ByC_3VQd0j+HGu8Sj9121=LToopyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: marcnarc@xiplink.com,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 20:58:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNprm-0004fM-DJ
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 20:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754469Ab2JOS6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 14:58:07 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53129 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753157Ab2JOS6G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 14:58:06 -0400
Received: (qmail 5110 invoked by uid 107); 15 Oct 2012 18:58:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 15 Oct 2012 14:58:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Oct 2012 14:58:02 -0400
Content-Disposition: inline
In-Reply-To: <CAB9Jk9A8E57byg+1yzc22ByC_3VQd0j+HGu8Sj9121=LToopyg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207773>

On Mon, Oct 15, 2012 at 05:50:47PM +0200, Angelo Borsotti wrote:

> correct, there will be no file overwriting because no files are
> written on the work tree.
> I tried to follow the actions of the program, but did not quite catch
> the 6. you mention.

It is the "oldval" parameter to refs.c:update_ref. Or if you are using
the "git update-ref" plumbing, it is the "oldvalue" parameter.

-Peff
