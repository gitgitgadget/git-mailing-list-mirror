From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH QGit RFC] Fix "Save patch..." on a commit range
Date: Sat, 13 Jun 2009 13:33:57 +0200
Message-ID: <200906131333.57725.markus.heidelberg@web.de>
References: <1244849357-31166-1-git-send-email-markus.heidelberg@web.de> <200906131302.43091.markus.heidelberg@web.de> <e5bfff550906130412v6e223511tf0e20c685b21c490@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 13:36:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFRXA-000323-90
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 13:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbZFMLdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 07:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbZFMLdy
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 07:33:54 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:53917 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbZFMLdx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 07:33:53 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 6EBA0FFD5D18;
	Sat, 13 Jun 2009 13:33:55 +0200 (CEST)
Received: from [89.59.112.3] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MFRUh-0002rO-00; Sat, 13 Jun 2009 13:33:55 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <e5bfff550906130412v6e223511tf0e20c685b21c490@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/T9kpIoKjHSJ3/Gjv2GNTVL9nClFV6DCc7/BlO
	ha6hsn7VZqKIPZgx6ZT6x7wtEwRU5il1aimiTtxQ09Lma8KXE7
	fXFGzBkbCV52reO1Qgfg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121498>

Marco Costalba, 13.06.2009:
> On Sat, Jun 13, 2009 at 12:02, Markus
> Heidelberg<markus.heidelberg@web.de> wrote:
> >
> > OK, if I now disable "All branches" in "View->Select range...", I get
> > the 2 patches from above again.
> > But in my git repo with local branches, it's the other way round...
> >
> > Markus
> >
> 
> Ok. The point is that if I select 4 _consecutive_ revisions from any
> repo and do "Save as..." then I see the 4 patches created in reverse
> cronoligical order as it should be.

I did the same as you: selected the 4 consecutive revisions. But I
didn't get 4 patches. Dependent on the state of the "All branches"
checkbox of the "Range select", I get 2 or 0 patches. The QStringList
shaList is set wrong for me.

> If I select only two patches _non_ consecutives and I do "Save as..."
> I get the two patches + all the pacthes in between still in reverse
> cronological order.

Yes, I'm aware of that. It shouldn't make a difference if I only select
start end end revision or if I select all revisions including the
revisions between start and end.
And as I said earlier: the order of the patches is not my problem.

> This is with stock QGit 2.3, Windows version.

I tested with the latest qgit.git and with QGit 2.2 from my
distribution. All on Gentoo Linux.

I just built QGit 2.3, this has the same problems.

> Have you some problem to reproduce this behavior (that is intended to
> be the correct one BTW) ?

Yes, I have :)

Can you please try, if enabling/disabling the "All branches" checkbox
makes a difference for you?

I have few time this weekend to respond. Have to play a concert with my
band today and clean my bike for a triathlon tomorrow. I will try to
reproduce on Windows, probably after this weekend.

Thanks, Markus
