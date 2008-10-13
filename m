From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Teach/Fix git-pull/git-merge --quiet and --verbose
Date: Mon, 13 Oct 2008 14:13:27 -0700
Message-ID: <20081013211327.GW4856@spearce.org>
References: <4ac8254d0810120954x2364054ahf2d49d6fbb7b0bb1@mail.gmail.com> <20081012200833.GC5255@spearce.org> <4ac8254d0810121431v1a67afc8ua92842b3d8c39328@mail.gmail.com> <4ac8254d0810121436x6285d17ew631f04e768a6fb62@mail.gmail.com> <4ac8254d0810131403i4c8c57d6r71531e34321e9b50@mail.gmail.com> <20081013210607.GV4856@spearce.org> <4ac8254d0810131412o34c01a4cla30eadc45e2e4e06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tuncer Ayaz <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 23:14:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpUkS-00038K-Ve
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 23:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754346AbYJMVN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 17:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753130AbYJMVN3
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 17:13:29 -0400
Received: from george.spearce.org ([209.20.77.23]:37044 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbYJMVN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 17:13:28 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 892D53835F; Mon, 13 Oct 2008 21:13:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4ac8254d0810131412o34c01a4cla30eadc45e2e4e06@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98157>

Tuncer Ayaz <tuncer.ayaz@gmail.com> wrote:
> On Mon, Oct 13, 2008 at 11:06 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > Tuncer Ayaz <tuncer.ayaz@gmail.com> wrote:
> >> Hi Shawn and list,
> >>
> >> I've updated the patch to current Junio master.
> >>
> >> Signed-off-by: Tuncer Ayaz <tuncer.ayaz@gmail.com>
> >
> > Looks good to me.
> 
> GMail borked it by inserting some linebreaks :(
> is that a problem for this single diff or should
> I first resend it properly via SMTP?

I would resend it.  For a one line diff its easy to hand apply,
but with multiple hunks like this you don't to waste Junio's time
by trying to fix up the patch by hand.

-- 
Shawn.
