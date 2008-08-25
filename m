From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] "git shell" won't work, need "git-shell"
Date: Mon, 25 Aug 2008 22:40:23 +0200
Organization: glandium.org
Message-ID: <20080825204023.GA10280@glandium.org>
References: <20080824202325.GA14930@eagain.net> <7vfxoukv56.fsf@gitster.siamese.dyndns.org> <20080824203825.GB14930@eagain.net> <7vbpzikt4b.fsf@gitster.siamese.dyndns.org> <20080825170816.GQ10544@machine.or.cz> <37fcd2780808251020j1ef51b38h7c6d6e8f050a92ce@mail.gmail.com> <alpine.DEB.1.00.0808252015080.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Tommi Virtanen <tv@eagain.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 25 22:41:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXisk-0006ZU-M9
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 22:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbYHYUkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 16:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752528AbYHYUkm
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 16:40:42 -0400
Received: from vuizook.err.no ([194.24.252.247]:44398 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751598AbYHYUkl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 16:40:41 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KXirQ-0005ws-Bs; Mon, 25 Aug 2008 22:40:30 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KXirP-0002hI-CB; Mon, 25 Aug 2008 22:40:23 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808252015080.24820@pacific.mpi-cbg.de.mpi-cbg.de>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93671>

On Mon, Aug 25, 2008 at 08:17:12PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 25 Aug 2008, Dmitry Potapov wrote:
> 
> > On Mon, Aug 25, 2008 at 9:08 PM, Petr Baudis <pasky@suse.cz> wrote:
> > >
> > > Can we agree that direct calls of libexec stuff should never be part 
> > > of the "official" interface (i.e. not workarounds for deprecated 
> > > usage)?
> > 
> > Agreed. It looks somewhat strange to type the libexec path in 
> > /etc/passwd.
> 
> FWIW I do not agree.  IMNHO libexec/ is just a way to organize executable 
> parts of any software package that are usually not called from the command 
> line.  And a login shell qualifies for that.
> 
> > > Considering that calling the git-shell executable directly is the 
> > > _only_ sensible way of using this interface, it should follow that it 
> > > has to be in /usr/bin, no matter if users type this command or not.
> > 
> > Perhaps, /usr/sbin would be a better place, as it is intended only for 
> > system administration binaries.
> 
> Does it not strike you as odd, then, that "sh" -- by far the most common 
> login shell -- does not live in /usr/sbin/?

But nologin is in /usr/sbin.

Mike
