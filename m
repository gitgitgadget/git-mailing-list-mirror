From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git push (mis ?)behavior
Date: Wed, 3 Oct 2007 17:44:39 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710031742400.28395@racer.site>
References: <20070927130447.GH10289@artemis.corp> <7v3awzvrpr.fsf@gitster.siamese.dyndns.org>
 <buoprzwn5qm.fsf@dhapc248.dev.necel.com> <20071003073554.GA8110@artemis.corp>
 <buobqbgmv6z.fsf@dhapc248.dev.necel.com> <83C5420A-528A-43F0-AF8C-699B85B7AD95@wincent.com>
 <20071003104943.GA3017@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0710031550490.28395@racer.site>
 <20071003160731.GA7113@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0710031718110.28395@racer.site>
 <20071003162816.GA17403@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	Wincent Colaiuta <win@wincent.com>,
	Miles Bader <miles@gnu.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 18:46:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id7ML-0002Up-AJ
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 18:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbXJCQp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 12:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbXJCQp5
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 12:45:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:56103 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751227AbXJCQp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 12:45:56 -0400
Received: (qmail invoked by alias); 03 Oct 2007 16:45:55 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp001) with SMTP; 03 Oct 2007 18:45:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+8tkJCPj68bn4l16DSGCCE6LyKdZq2HVC904yeJT
	f3Zu9ya1AJyvlT
X-X-Sender: gene099@racer.site
In-Reply-To: <20071003162816.GA17403@artemis.corp>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59857>

Hi,

On Wed, 3 Oct 2007, Pierre Habouzit wrote:

> On Wed, Oct 03, 2007 at 04:18:56PM +0000, Johannes Schindelin wrote:
> > This thread is getting painful.  Lot's of "I want"s, but nobody to date 
> > came up with a solution that makes both oldtimers and newtimers happy.
> 
> I think I made a proposal that tries to reach some kind of consensus:
> 
> `git push`::
>     no arguments given just pushes the current branch you're on, into
>     origin, if a refspec matches.

I use that sometimes, and I do not want only the current branch to be 
pushed.

> `git push <remote>`::
>     works like now (aka pushes all branches that match a remote branch
>     in the given remote).

That would make things inconsistent, and inconsistent things are always 
hard to explain.

> This way, you can have current "git push" using "git push origin", but 
> you also have a convenient way to push only the current branch into your 
> default remote repository without needing to spell out:
> 
>   $ git push origin `git symbolic-ref HEAD`

I wonder how hard it would be to teach _everybody_ to specify _exactly_ 
what they want.

Of course, we'd need an "--existing" option to git-push to trigger the 
behaviour that we have right now.

Ciao,
Dscho
