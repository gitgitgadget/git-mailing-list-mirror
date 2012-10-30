From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Tue, 30 Oct 2012 18:20:48 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info>
References: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com> <20121029085045.GA5023@sigill.intra.peff.net> <CAMP44s0RVe6i4DpNmaV_n7_5KO_aq2WxCPVafjsTukExRSR5Jw@mail.gmail.com> <20121029212643.GA20513@sigill.intra.peff.net>
 <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com> <20121029215631.GF20513@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 30 18:21:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTFUw-0001Dn-Ta
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 18:21:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922Ab2J3RUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 13:20:54 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:55415 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933842Ab2J3RUx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 13:20:53 -0400
Received: (qmail invoked by alias); 30 Oct 2012 17:20:50 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp071) with SMTP; 30 Oct 2012 18:20:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+qRco0eayqeebaLBwNCmngSNlt6X5d/WvqUAVZnb
	UxRpsC4fI4721T
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20121029215631.GF20513@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208710>

Hi all,

On Mon, 29 Oct 2012, Jeff King wrote:

> On Mon, Oct 29, 2012 at 10:47:04PM +0100, Felipe Contreras wrote:
> 
> > >> Yeah, the test script is not ready for merging, it needs to check
> > >> for python, hg, and hg-git.
> > >>
> > >> Do you have hg-git installed?
> > >
> > > No. But it's important that it fail gracefully; I can't even take it
> > > in pu if I can't run the test suite in a sane way.
> > 
> > The contrib part is fine for 'pu'. The tests aren't even meant to
> > exercise stuff in 'contrib', right? There might be some exceptions,
> > but either way, there's plenty of stuff in 'contrib' without any
> > tests. The tests I'm providing are simply a little sugar.
> 
> Yeah, contrib is a bit of a wildcard. Most things do not have tests.

Given that the tests of remote-hg as in git://github.com/msysgit/git's
'devel' branch run just fine without additional dependencies (which
probably triggered the not-quite-constructive and unnecessarily-flaming
"bloated" comment of Felipe), and given that the code in said branch is
well-tested and exercised by daily use, and given the fact that my major
concern was not understood (and probably not addressed), and also given
the fact that Sverre indicated that he could finalize the work as a 20%
project, I decided that other projects I have to do unfortunately have a
too-high priority to take care of testing and measuring the performance of
the patch series that is discussed in this thread.

Sorry,
Johannes

P.S.: I would still recommend to have a detailed look at the 'devel'
branch, in particular the commits starting with "fast-export: do not refer
to non-existing marks" and ending with "t5801: skip without hg". My
understanding is that it was completely ignored after a brief and maybe
too-cursory look. In the least, it has a couple of lessons we learnt the
hard way, and if git.git is dead set on duplicating the work, making these
mistakes again could be avoided by learning from our lessons.
