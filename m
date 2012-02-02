From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Breakage in master?
Date: Thu, 2 Feb 2012 19:57:39 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1202021956370.1249@s15462909.onlinehome-server.info>
References: <CABPQNSbWu0r_gKGvCHk567pUtQiyDOCO8vFfrzPMFW1eUaj1nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	=?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 19:57:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt1qr-0005mF-W3
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 19:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291Ab2BBS5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 13:57:41 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:47817 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752900Ab2BBS5l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 13:57:41 -0500
Received: (qmail invoked by alias); 02 Feb 2012 18:57:39 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp069) with SMTP; 02 Feb 2012 19:57:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/wQblYHtvwVRyMirjQHREOySHt2bMC7dXRtkVyHr
	E1bHW8URmrbGJE
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CABPQNSbWu0r_gKGvCHk567pUtQiyDOCO8vFfrzPMFW1eUaj1nw@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189672>

Hi Erik,

On Thu, 2 Feb 2012, Erik Faye-Lund wrote:

> Something strange is going on in Junio's current 'master' branch
> (f3fb075). "git show" has started to error out on Windows with a
> complaint about our vsnprintf:
> ---8<---
> 
> $ git show
> commit f3fb07509c2e0b21b12a598fcd0a19a92fc38a9d
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Tue Jan 31 22:31:35 2012 -0800
> 
>     Update draft release notes to 1.7.10
> 
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> fatal: BUG: your vsnprintf is broken (returned -1)
> ---8<---
>
> [...]
>
> I'm at a loss here. Does anyone have a hunch about what's going on?

It very much reminds me of 6ef404095bc1162031fc3cb43430b512e975bc6a...

Is it possible that NO_GETTEXT is either not set, or ignored?

Ciao,
Dscho
