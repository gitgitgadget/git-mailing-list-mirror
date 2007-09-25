From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: My stash wants to delete all my files
Date: Tue, 25 Sep 2007 11:41:50 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709251139480.28395@racer.site>
References: <5A9D6E3B-7B0E-4414-9AFB-C1C8B2EE6A9D@steelskies.com>
 <7vabrb8rin.fsf@gitster.siamese.dyndns.org> <DCBF8566-9B43-4EFA-A8B2-2EAB516C273F@steelskies.com>
 <Pine.LNX.4.64.0709251054440.28395@racer.site> <0F9BDBCD-06AA-4AB1-9DDA-9C98E8796AA1@steelskies.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 12:43:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ia7sd-0004Cz-4l
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 12:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbXIYKm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 06:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbXIYKm5
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 06:42:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:36919 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751755AbXIYKm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 06:42:56 -0400
Received: (qmail invoked by alias); 25 Sep 2007 10:42:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp014) with SMTP; 25 Sep 2007 12:42:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19+Gg47Za5+Am0ar2SU8PoVUlLt0p2aA15T95ECS2
	QB2rrZNoEcfNX4
X-X-Sender: gene099@racer.site
In-Reply-To: <0F9BDBCD-06AA-4AB1-9DDA-9C98E8796AA1@steelskies.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59112>

Hi,

On Tue, 25 Sep 2007, Jonathan del Strother wrote:

> On 25 Sep 2007, at 10:56, Johannes Schindelin wrote:
> 
> > On Tue, 25 Sep 2007, Jonathan del Strother wrote:
> > 
> > > I don't think I git-added anything - just made changes to the 
> > > working copy. (It *does* stash those, right??)
> > 
> > Stash does not care about things that are not tracked, so no, it does 
> > not stash those.  Imagine a stash saving all those .o, .a and .so 
> > files... Insanity!
> 
> 
> Mm, ok - fair point.  I was actually thinking of files that are already 
> tracked, but haven't been added to the staging area with git add.

Ah.  I read your statement as "I don't think I git-added anything, ever".

So this is what stash is supposed to do:

- save the differences between the HEAD and the index

- save the differences between the HEAD and the working tree

- reset the index and the working tree to the state of the HEAD

So indeed, I am as puzzled as you are.  Maybe it was your initial commit?

Ciao,
Dscho
