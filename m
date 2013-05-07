From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] fast-import: only store commit objects
Date: Mon, 6 May 2013 23:39:49 -0500 (CDT)
Message-ID: <alpine.DEB.1.00.1305062332470.8213@s15462909.onlinehome-server.info>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com> <1367555502-4706-5-git-send-email-felipe.contreras@gmail.com> <87y5bw3q1s.fsf@hexa.v.cablecom.net> <CAMP44s1R9hAMZ=DQoPiTVi3+40NpADjVFU7tYovZA8W-PWEhhg@mail.gmail.com>
 <518785B3.3050606@alum.mit.edu> <87ip2wflg0.fsf@linux-k42r.v.cablecom.net> <518789D1.4010905@alum.mit.edu> <CAMP44s1Nk7YAjNkTq=ShQbzkMasw6bpcEPTXLb8x+2q-vXLRGg@mail.gmail.com> <518874A5.5050002@alum.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 07 06:40:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZZh5-00054S-PI
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 06:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760316Ab3EGEjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 00:39:54 -0400
Received: from mout.gmx.net ([212.227.17.20]:60762 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753445Ab3EGEjw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 00:39:52 -0400
Received: from mailout-de.gmx.net ([10.1.76.16]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0LeP1H-1UCfTW0ElZ-00qDP2 for
 <git@vger.kernel.org>; Tue, 07 May 2013 06:39:51 +0200
Received: (qmail invoked by alias); 07 May 2013 04:39:50 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp016) with SMTP; 07 May 2013 06:39:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ijIh97cLiyFxZgDO53aP2tK2/y6ST+M4BgfMsuL
	i1gbshYf17kWqf
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <518874A5.5050002@alum.mit.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223543>

Hi,

On Tue, 7 May 2013, Michael Haggerty wrote:

> On 05/06/2013 11:04 PM, Felipe Contreras wrote:
> > On Mon, May 6, 2013 at 5:45 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> >> On 05/06/2013 12:32 PM, Thomas Rast wrote:

> >> So the proposed change would break a documented use of cvs2git.
> > 
> > It's documented as an alternative. How many people actually use this
> > form over the other? Is there really any advantage? It's possibly that
> > basically nobody is using this form, and there's no benefits.
> 
> You conjectured earlier that nobody uses blob marks, and I provided a
> counterexample.  Then you proposed a workaround that would require
> changes to the cvs2git documentation, and I even explained how your
> proposed workaround is not as flexible as the status quo.  Do you want
> to go through the same argument with every possible user of
> git-fast-import?
> 
> It would be insanity to change the default behavior when a workaround on
> the Git side (namely adding an option that tells git-fast-import *not*
> to emit blob marks) would be quite straightforward to implement and have
> little maintenance cost.

I really wonder how many more counterexamples are required to settle this
discussion.

There is no good reason to artificially limit Git's capabilities here,
especially when it has been demonstrated that supporting that capability
is not only possible, but also outright easy.

Ciao,
Dscho
