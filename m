From: walt <wa1ter@myrealbox.com>
Subject: Re: My first git success [not quite]
Date: Sat, 14 Jan 2006 09:18:01 -0800
Organization: none
Message-ID: <dqbbo9$s49$1@sea.gmane.org>
References: <dq8epd$k28$1@sea.gmane.org>	<Pine.LNX.4.64.0601130909290.3535@g5.osdl.org>	<dqb5vg$a09$1@sea.gmane.org> <BAYC1-PASMTP10B423DC1B2FC1F8C9992BAE190@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jan 14 18:18:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Exp2k-0003dj-J4
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 18:18:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWANRST (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jan 2006 12:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbWANRST
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jan 2006 12:18:19 -0500
Received: from main.gmane.org ([80.91.229.2]:58777 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750703AbWANRST (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jan 2006 12:18:19 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Exp2V-0003aq-3a
	for git@vger.kernel.org; Sat, 14 Jan 2006 18:18:07 +0100
Received: from adsl-69-234-229-41.dsl.irvnca.pacbell.net ([69.234.229.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jan 2006 18:18:07 +0100
Received: from wa1ter by adsl-69-234-229-41.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jan 2006 18:18:07 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-229-41.dsl.irvnca.pacbell.net
User-Agent: Mail/News 1.6a1 (X11/20060114)
In-Reply-To: <BAYC1-PASMTP10B423DC1B2FC1F8C9992BAE190@CEZ.ICE>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14669>

sean wrote:
> > On Sat, 14 Jan 2006 07:39:28 -0800
> > walt <wa1ter@myrealbox.com> wrote:
[...]
>> >> So, I clearly don't understand what git-checkout does.  It
>> >> doesn't seem to touch the already-checked-out sources at
>> >> all, which is what I would expect it to do.

> > Hi Walt,
> >
> > When you switch branches _uncommitted_ changes will stay in
> > your working directory.   This lets you change to a different
> > branch before committing something you're working on for
> > instance.

Ah!  The underlying reason is what I was missing.

> >   So likely, even though you had switched to your
> > test branch to apply the patch, you didn't actually commit
> > it into that branch before switching back to master.

Right.  And *my* reasoning (FWIW) is that I was intending
to throw the entire branch away so I didn't see any need to
commit.  (But men always have that problem ;o)

I suppose the underlying problem is that I don't think like
a developer.  My wish for a future improvement for git would
be a bonehead<-->expert switch that would turn on some basic
warning messages.  In this particular example, I would have
welcomed a warning message that said:  "You have uncommitted
changes!  Hit 'D' to discard them or <Enter> to keep them without
committing".  An experienced git user would want to turn that off,
most likely.

Thanks for the clue-stick, and I very much appreciate your
patience.
