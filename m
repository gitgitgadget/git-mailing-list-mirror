From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH] add --porcelain option to git-push
Date: Tue, 23 Jun 2009 20:26:51 -0400
Message-ID: <20090624002651.GA27460@cthulhu>
References: <20090622214032.GC19364@coredump.intra.peff.net> <20090623011001.GA15352@cthulhu> <85647ef50906231538m118120adnd2292b65ec953baa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 02:27:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJGKO-0007ir-QP
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 02:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbZFXA0y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Jun 2009 20:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbZFXA0x
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 20:26:53 -0400
Received: from cthulhu.elder-gods.org ([140.239.99.253]:55028 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbZFXA0w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 20:26:52 -0400
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 5632982207F; Tue, 23 Jun 2009 20:26:51 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <85647ef50906231538m118120adnd2292b65ec953baa@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122117>

* Constantine Plotnikov (constantine.plotnikov@gmail.com) [090623 18:38=
]:
> On Tue, Jun 23, 2009 at 5:10 AM, Larry D'Anna<larry@elder-gods.org> w=
rote:
> > If --porcelain is used git-push will produce machine-readable outpu=
t. =A0The
> > output status line for each ref will be tab-separated and sent to s=
tdout instead
> > of stderr. =A0The full symbolic names of the refs will be given. =A0=
=46or example
> >
> BTW is it possible to have --porcelain + -v together. A machine
> readable progress output would come very handy for IDEs and other GUI
> tools that use command line tools.

My patch makes --porcelain imply some of what -v does, but not all.
Specifically --porcelain will output a status line for each ref that's =
to be
updated, weather -v is selected or not.  However -v enables some other =
output
besides that.  There's nothing stopping you from selecting -v and --por=
celain.
Basically --porcelain only affects the per-ref status lines.  All other=
 aspects
of git-push are the same.


        --larry
