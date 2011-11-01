From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Re: [PATCHv2] Compile fix for MSVC
Date: Tue, 1 Nov 2011 17:51:59 -0500 (CDT)
Message-ID: <alpine.DEB.1.00.1111011750420.32316@s15462909.onlinehome-server.info>
References: <1320088364-25916-1-git-send-email-vfr@lyx.org> <7vd3dcq4s5.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1110311908240.1930@bonsai2> <CABPQNSaCRRRpEQPG1Mb4DovkMdQSBhHTm-i7y5M4iT+ndHX4XA@mail.gmail.com> <alpine.DEB.1.00.1111011332400.32316@s15462909.onlinehome-server.info>
 <CABPQNSb07fRUCqPCX7JbfGW_55etZZtPyP=yuCKV9wJeNP-iQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org,
	ramsay@ramsay1.demon.co.uk, msysgit@googlegroups.com,
	Karsten Blees <blees@dcon.de>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 01 23:52:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLNBi-0006dU-8p
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 23:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364Ab1KAWwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Nov 2011 18:52:05 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:56855 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753733Ab1KAWwD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 18:52:03 -0400
Received: (qmail invoked by alias); 01 Nov 2011 22:52:00 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp067) with SMTP; 01 Nov 2011 23:52:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/EWYIhL8vEgU3h/2TBp6ODwtb7KFXW8ETXlLHJeS
	WZXoxhIwriwlcZ
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CABPQNSb07fRUCqPCX7JbfGW_55etZZtPyP=yuCKV9wJeNP-iQw@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184605>

Hi kusma,

On Tue, 1 Nov 2011, Erik Faye-Lund wrote:

> On Tue, Nov 1, 2011 at 7:40 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > Maybe if someone donates Jenkins resources, we could make an automatic 
> > branch in the future that has git.sln in it (similar to the 'html' 
> > branch in git.git).
> 
> CloudBees seems to have some kind of a free Jenkins service. Perhaps 
> it's sufficient? http://www.cloudbees.com/dev-pricing.cb

Looks quite cool, but keep in mind: they only have Linux build machines. 
We'd need to pimp up our cross-platform compiling capabilities; WINE will 
most likely not be good enough (we'd only have 2000 minutes per month).

Ciao,
Dscho
