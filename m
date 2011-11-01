From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Re: [PATCHv2] Compile fix for MSVC
Date: Tue, 1 Nov 2011 13:40:18 -0500 (CDT)
Message-ID: <alpine.DEB.1.00.1111011332400.32316@s15462909.onlinehome-server.info>
References: <1320088364-25916-1-git-send-email-vfr@lyx.org> <7vd3dcq4s5.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1110311908240.1930@bonsai2> <CABPQNSaCRRRpEQPG1Mb4DovkMdQSBhHTm-i7y5M4iT+ndHX4XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org,
	ramsay@ramsay1.demon.co.uk, msysgit@googlegroups.com,
	Karsten Blees <blees@dcon.de>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 01 19:40:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLJG5-0003CR-JS
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 19:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187Ab1KASkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Nov 2011 14:40:21 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:59272 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754260Ab1KASkU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 14:40:20 -0400
Received: (qmail invoked by alias); 01 Nov 2011 18:40:18 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp071) with SMTP; 01 Nov 2011 19:40:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19CFBEZmY1CiNWK6C38bNoGArCSwdPkgq+Oo+vEyl
	grKCtNwVavQLZ7
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CABPQNSaCRRRpEQPG1Mb4DovkMdQSBhHTm-i7y5M4iT+ndHX4XA@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184581>

Hi kusma,

On Tue, 1 Nov 2011, Erik Faye-Lund wrote:

> On Tue, Nov 1, 2011 at 1:09 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Mon, 31 Oct 2011, Junio C Hamano wrote:
> >
> >> Thanks. The patch looks good from a POSIX person's point of view, and 
> >> I do not immediately see how this would break other variants of 
> >> Windows build at least from the code inspection.
> >
> > As my virtual machine still ran the test suite after my latest 
> > rebasing merge when I left work, I could not test the MSVC stuff just 
> > yet. I wanted to do that tomorrow and either merge or come back with 
> > suggestions.
> 
> I've applied the patches to 'devel', verified that the result builds, 
> and pushed it out.

I've applied your patches and made up commit messages. So far, I only 
tested with MSVCE 9.0 (AKA Express 2008) before running out of time. 
Please have a look at the commits (since I could build a git.exe with the 
correct version, I felt comfortable enough to push out to 'devel').

Maybe if someone donates Jenkins resources, we could make an automatic 
branch in the future that has git.sln in it (similar to the 'html' branch 
in git.git).

Ciao,
Dscho
