From: Jeff King <peff@peff.net>
Subject: Re: git pull behavior changed?
Date: Wed, 21 Apr 2010 22:10:15 -0400
Message-ID: <20100422021015.GB25093@coredump.intra.peff.net>
References: <v2hfabb9a1e1004211422ybbf47ef0gd5dfd1791eb03c16@mail.gmail.com>
 <y2p3abd05a91004211455r30d13932t92dfbedff581b9a1@mail.gmail.com>
 <vpqsk6omppf.fsf@bauges.imag.fr>
 <h2o3abd05a91004211504pfc2de8b7sa37c9c0a4dd14f57@mail.gmail.com>
 <vpq8w8gjvhn.fsf@bauges.imag.fr>
 <z2t3abd05a91004211541y1c2c5467k5731819da7fe625@mail.gmail.com>
 <20100422000131.GB14249@coredump.intra.peff.net>
 <k2t3abd05a91004211713u24ff93f3of758e5e09c7b8059@mail.gmail.com>
 <20100422004136.GA18570@coredump.intra.peff.net>
 <v2z3abd05a91004211827ua3955912w676d8a3e001ed461@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	git list <git@vger.kernel.org>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 04:10:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4lsT-0006xz-L7
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 04:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985Ab0DVCKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 22:10:47 -0400
Received: from peff.net ([208.65.91.99]:53345 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752658Ab0DVCKq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 22:10:46 -0400
Received: (qmail 25586 invoked by uid 107); 22 Apr 2010 02:10:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 21 Apr 2010 22:10:53 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Apr 2010 22:10:15 -0400
Content-Disposition: inline
In-Reply-To: <v2z3abd05a91004211827ua3955912w676d8a3e001ed461@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145493>

On Wed, Apr 21, 2010 at 09:27:31PM -0400, Aghiles wrote:

> > You may also be interested to know that "git checkout foo" these days
> > when you have no "foo" branch will do the equivalent of "git checkout -b
> > --track foo origin/foo", which would also do what you want.
> 
> Wouldn't that create/track a remote 'foo' branch ? I have no remote branches
> but only local ones so I am always tracking origin/master.

Yes, it would, so I guess it doesn't help you. You should do "git
checkout -b foo origin/master", then.

-Peff
