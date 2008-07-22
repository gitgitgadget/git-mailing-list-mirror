From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Computing the number of patches in linux-next tree
Date: Tue, 22 Jul 2008 18:24:44 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807221816560.8986@racer>
References: <12c511ca0807220919q4db6ee1fr33dc70fe35c58efe@mail.gmail.com> <alpine.DEB.1.00.0807221727210.8986@racer> <7vabg9n93f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tony Luck <tony.luck@intel.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 19:25:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLLcQ-0007bd-4I
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 19:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350AbYGVRYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 13:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbYGVRYq
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 13:24:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:35394 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751802AbYGVRYp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 13:24:45 -0400
Received: (qmail invoked by alias); 22 Jul 2008 17:24:44 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp031) with SMTP; 22 Jul 2008 19:24:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/EuVlIa5bEDaYBAimUdkEy4WZcQANjcL4APxJWG0
	0xROyI61bPF8lE
X-X-Sender: gene099@racer
In-Reply-To: <7vabg9n93f.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89506>

Hi,

On Tue, 22 Jul 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Tue, 22 Jul 2008, Tony Luck wrote:
> >
> >> git tag | grep next- | sort | while read tag
> >
> > This should not be necessary... AFAICT "git tag" sorts its output already.
> >
> >> What does the "git-where-did-this-tag-branch-from-linus" command look like?
> >
> > git merge-base --all <branch1> <branch2>
> >
> > Be warned: there might be multiple merge bases.
> 
> I do not think that approach applies to linux-next, which is constantly
> rewound to the then-tip-of-linus and merge remaining bits.  The question
> is "where does this branch begin", which does not have an answer in git.

Oh.

Well, there is one thing that _could_ work most of the time, namely 
looking at the committer info of the first parent.

Dunno,
Dscho
