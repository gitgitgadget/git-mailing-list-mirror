From: Nicolas Pitre <nico@cam.org>
Subject: Re: Rollback of git commands
Date: Wed, 28 Nov 2007 13:52:12 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711281349180.9605@xanadu.home>
References: <9e4733910711271523p3be94010jac9c79e6b95f010d@mail.gmail.com>
 <7vmyszb39s.fsf@gitster.siamese.dyndns.org>
 <9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com>
 <9e4733910711271749q1b96bfe9i60e43619c89234b9@mail.gmail.com>
 <ee77f5c20711271757h724d5fcep38f3c2354c54f20b@mail.gmail.com>
 <20071128165033.GA31218@elte.hu> <87lk8imcxv.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Ingo Molnar <mingo@elte.hu>, David Symonds <dsymonds@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 19:52:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxS1V-0003lB-5B
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 19:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577AbXK1SwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 13:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752891AbXK1SwO
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 13:52:14 -0500
Received: from relais.videotron.ca ([24.201.245.36]:15327 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210AbXK1SwN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 13:52:13 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JS800580CF07EM0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 28 Nov 2007 13:52:12 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <87lk8imcxv.fsf@osv.gnss.ru>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66405>

On Wed, 28 Nov 2007, Sergei Organov wrote:

> Ingo Molnar <mingo@elte.hu> writes:
> 
> > well, it would/could be the normal undo/redo semantics of editors: you 
> > can undo-redo in a linear history fashion, in an unlimited way, but the 
> > moment you modify any past point of history then the redo future is 
> > overriden. (but the 'past' up to that point is still recorded and 
> > available)
> 
> Or it could be Emacs-like: 'undo' is just another operation that is a
> subject for further undo's ;) Then there is no need for 'redo', and no
> need to override either the future or the past.

The reflog does just that in fact, when it records your 'git reset' 
operations.

> Besides this obvious technical superiority will help to maintain git's 
> reputation of being hard to grok ;)

Sure!  ;)


Nicolas
