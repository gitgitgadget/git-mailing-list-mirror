From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Usability of git stash
Date: Sun, 19 Oct 2008 14:49:53 -0700
Message-ID: <20081019214953.GI14786@spearce.org>
References: <87wsg9acfv.fsf@cup.kalibalik.dk> <nKimSsYZj6xfGNCQS3i5cRwnWQfbHrtUrwdGB2zGWVfMOcfZMwJDKg@cipher.nrlssc.navy.mil> <86vdvsg4up.fsf@lola.quinscape.zz> <vCcONcOJu3QKQyRgPdT5Dws3F2P25RNAFOgM5GX6FWWKJe40papCRw@cipher.nrlssc.navy.mil> <87prly5k5r.fsf@cup.kalibalik.dk> <20081019184029.GF14786@spearce.org> <ee2a733e0810191408m2cbe1ba5n540ad0fb99b49708@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Anders Melchiorsen <mail@cup.kalibalik.dk>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	David Kastrup <dak@gnu.org>
To: Leo Razoumov <slonik.az@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 11:12:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrgB1-0003eo-8L
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 23:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbYJSVtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 17:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbYJSVty
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 17:49:54 -0400
Received: from george.spearce.org ([209.20.77.23]:57291 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842AbYJSVty (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 17:49:54 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A4DBD3835F; Sun, 19 Oct 2008 21:49:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <ee2a733e0810191408m2cbe1ba5n540ad0fb99b49708@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98632>

Leo Razoumov <slonik.az@gmail.com> wrote:
> On 10/19/08, Shawn O. Pearce <spearce@spearce.org> wrote:
> > [..snip..]
> > Indeed, that's an advantage of the wip commit approach, you can shove
> >  the untracked files quickly into the wip commit, especially with 1.6:
> >
> >         git commit -A -m wip
> >
> > [..snip..]
> 
> What version of git are you using?
> I am using git-1.6.0.2 on Linux and "-A" is illegal option for "git commit"

Oh.  Sorry.  I thought I saw a patch for that go by.  I guess I mean:

	git add -A && git commit

-- 
Shawn.
