From: Christopher Faylor <me@cgf.cx>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 2 Mar 2006 10:22:19 -0500
Message-ID: <20060302152219.GG2781@trixie.casa.cgf.cx>
References: <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com> <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com> <43FD84EB.3040704@op5.se> <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com> <43FDB8CC.5000503@op5.se> <81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com> <20060226195552.GA30735@trixie.casa.cgf.cx> <Pine.LNX.4.64.0602261217080.22647@g5.osdl.org> <20060226204027.GC30735@trixie.casa.cgf.cx> <81b0412b0603020618q3b205cdeuabc7e204044cca5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Mar 02 16:23:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEpdM-0001Ns-V0
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 16:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbWCBPWU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 10:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbWCBPWU
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 10:22:20 -0500
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:187 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1751490AbWCBPWT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 10:22:19 -0500
Received: by cgf.cx (Postfix, from userid 201)
	id 1CC445A8010; Thu,  2 Mar 2006 10:22:19 -0500 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <81b0412b0603020618q3b205cdeuabc7e204044cca5b@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17078>

On Thu, Mar 02, 2006 at 03:18:44PM +0100, Alex Riesen wrote:
>On 2/26/06, Christopher Faylor <me@cgf.cx> wrote:
>> The cygwin/windows version of spawn is basically like an extended version
>> of exec*():
>>
>> pid = spawnlp (P_NOWAIT, "/bin/ls", "ls", "-l", NULL);
>>
>
>By the way, is argv worked around?
>AFAIK, windows has only one argument, returned by GetCommandLine?

Cygwin passes an argv list between cygwin processes and a quoted command
line to pure windows processes.

cgf
