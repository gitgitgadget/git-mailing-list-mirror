From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Rollback of git commands
Date: Thu, 29 Nov 2007 09:42:19 +0100
Message-ID: <20071129084219.GA2257@diana.vm.bytemark.co.uk>
References: <9e4733910711271523p3be94010jac9c79e6b95f010d@mail.gmail.com> <7vmyszb39s.fsf@gitster.siamese.dyndns.org> <9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com> <BAYC1-PASMTP02DBA3FB25E09FE45F0BF2AE770@CEZ.ICE> <9e4733910711272037r2ce3ed01y31ec8531f5803efe@mail.gmail.com> <alpine.LFD.0.99999.0711280951150.9605@xanadu.home> <9e4733910711280758x38ca3cdau4e62bfe8776e5c0d@mail.gmail.com> <alpine.LFD.0.99999.0711281125320.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Smirl <jonsmirl@gmail.com>, Sean <seanlkml@sympatico.ca>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Nov 29 09:43:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixezh-0006RY-KH
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 09:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754984AbXK2InS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Nov 2007 03:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754803AbXK2InS
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 03:43:18 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2178 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385AbXK2InS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 03:43:18 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IxeyS-0000na-00; Thu, 29 Nov 2007 08:42:20 +0000
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.99999.0711281125320.9605@xanadu.home>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66519>

On 2007-11-28 11:26:45 -0500, Nicolas Pitre wrote:

> On Wed, 28 Nov 2007, Jon Smirl wrote:
>
> > The state contained in the other config files in .git/* is not
> > getting check pointed. I can use reflog to move my branch heads
> > around. But doing that does not undo the changes to the state
> > recorded in .git/*. After the error I encountered I moved my
> > branch head back, but the state stgit had stored in .git/* was out
> > of sync with where the branch had been moved to.
>
> It's up to stgit to version control its state then. It may even use
> a reflog for it. All the machinery is there already.

I agree -- this is StGit's job.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
