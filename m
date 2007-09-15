From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH] git-svn: remove --first-parent, add --upstream
Date: Sat, 15 Sep 2007 17:49:35 +0200
Message-ID: <20070915154935.GC4957@xp.machine.xx>
References: <20070906210155.GA20938@soma> <20070906213556.GA21234@soma> <8c5c35580709061514n1de6f141v5e596074cfa9fb42@mail.gmail.com> <20070906235516.GC4538@xp.machine.xx> <8c5c35580709061723m7e01c9d4p1b1936dc1d590459@mail.gmail.com> <20070907084352.GD4538@xp.machine.xx> <8c5c35580709070313l4b815ddbg70be8fb0aef4eefd@mail.gmail.com> <8c5c35580709150708k5acdeabdh17fc7ef30ee3eb79@mail.gmail.com> <20070915143743.GB4957@xp.machine.xx> <8c5c35580709150824l6eb4fa40l7ef77db03a48af4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 17:50:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWZuQ-0001o4-FU
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 17:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbXIOPuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 11:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbXIOPuJ
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 11:50:09 -0400
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:36966 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751118AbXIOPuI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Sep 2007 11:50:08 -0400
Received: (qmail 28467 invoked by uid 0); 15 Sep 2007 15:50:06 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 15 Sep 2007 15:50:06 -0000
Content-Disposition: inline
In-Reply-To: <8c5c35580709150824l6eb4fa40l7ef77db03a48af4b@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 15, 2007 at 05:24:02PM +0200, Lars Hjemli wrote:
> On 9/15/07, Peter Baumann <waste.manager@gmx.de> wrote:
> > On Sat, Sep 15, 2007 at 04:08:31PM +0200, Lars Hjemli wrote:
> > > On 9/7/07, Lars Hjemli <hjemli@gmail.com> wrote:
> > > > On 9/7/07, Peter Baumann <waste.manager@gmx.de> wrote:
> > > > >    lets reset 'trunk' to its state before the merge and
> > > > >    'branch1' to the merge commit, before fixing the bug in 'branch1'.
> > > > >
> > > > >        a-b-c-d-e    trunk
> > > > >           \      \
> > > > >            \ -x-y m branch1
> > > >
> > > > Yeah, this would certainly not be handled correctly by dcommit using
> > > > --first-parent (but it could be handled by (a correct implementation
> > > > of) --upstream).
> > >
> > > Actually, I don't think there's any way to handle this correctly. The
> > > current git-svn will do the right thing except in cases like the one
> > > you described, and in these cases it can be _forced_ to do the right
> > > thing by editing the grafts file, so I'll drop the whole --upstream
> > > idea.
> > >
> >
> > What do you mean by editing the graft file? Remove (the wrong) parent
> > from the merge commit by a graft?
> 
> I imagined just changing the order of the parents.
> 

Doh. I missed the obvious.

-Peter
