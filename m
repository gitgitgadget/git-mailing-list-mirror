From: Mike Hommey <mh@glandium.org>
Subject: Re: Confusion about diffing branches
Date: Mon, 27 Aug 2007 15:33:14 +0200
Organization: glandium.org
Message-ID: <20070827133314.GA9131@glandium.org>
References: <20070826233555.GA7422@mediacenter.austin.rr.com> <7v6431omn8.fsf@gitster.siamese.dyndns.org> <20070827014056.GB7422@mediacenter.austin.rr.com> <7vlkbxmp50.fsf@gitster.siamese.dyndns.org> <20070827075009.GA31438@glandium.org> <38b2ab8a0708270621l63f3da56j4667014e62a5de92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 15:34:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPek5-0005j5-1n
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 15:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860AbXH0Ney (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 09:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753880AbXH0Ney
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 09:34:54 -0400
Received: from vawad.err.no ([85.19.200.177]:57380 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752971AbXH0Nex (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 09:34:53 -0400
Received: from aputeaux-153-1-29-74.w82-124.abo.wanadoo.fr ([82.124.191.74] helo=vaio.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IPejt-0002Qu-DD; Mon, 27 Aug 2007 15:34:49 +0200
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1IPeiQ-0002Ob-9L; Mon, 27 Aug 2007 15:33:14 +0200
Content-Disposition: inline
In-Reply-To: <38b2ab8a0708270621l63f3da56j4667014e62a5de92@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56833>

On Mon, Aug 27, 2007 at 03:21:32PM +0200, Francis Moreau <francis.moro@gmail.com> wrote:
> Hi !
> 
> On 8/27/07, Mike Hommey <mh@glandium.org> wrote:
> > On Mon, Aug 27, 2007 at 12:07:39AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> > > Both semantics of two-dot form and three-dot form are useful,
> > > and choice between the two depends on what you want out of the
> > > command.  You just need to know which one you want.
> >
> > The problem is not about usefulness of these 2 forms, but consistency
> > with the rest of the tools.
> > If I go git log a..b, I won't get the set of commits involved in
> > git diff a..b. In fact, git log a...b does. And git log a..b gives the
> > commits involved in git diff a...b. Confusing, isn't it ?
> > Moreover, this inconsistency isn't even documented in the manual pages.
> >
> 
> This "inconsistency" had already been raised before. Please refer to:
> http://www.gelato.unsw.edu.au/archives/git/0612/35354.html
> 
> I shared and still share your feeling about that but it seems that
> Junio and Linus don't...

Actually, they may have a good point, cf. the thread you point.
But it is annoying that it is not documented.

Mike
