From: Christopher Faylor <me@cgf.cx>
Subject: Re: NT directory traversal speed on 25K files on Cygwin
Date: Mon, 27 Feb 2006 13:34:17 -0500
Message-ID: <20060227183417.GA17978@trixie.casa.cgf.cx>
References: <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com> <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com> <43FD84EB.3040704@op5.se> <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com> <43FDB8CC.5000503@op5.se> <81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com> <20060226195552.GA30735@trixie.casa.cgf.cx> <20060226231701.GA11961@nospam.com> <20060227011801.GB9264@trixie.casa.cgf.cx> <20060227183049.GA13195@nospam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Feb 27 19:34:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDnCP-0005WU-HO
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 19:34:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWB0SeS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 13:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbWB0SeS
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 13:34:18 -0500
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:33193 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1751461AbWB0SeS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2006 13:34:18 -0500
Received: by cgf.cx (Postfix, from userid 201)
	id C1CD813C3E2; Mon, 27 Feb 2006 13:34:17 -0500 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060227183049.GA13195@nospam.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16871>

On Mon, Feb 27, 2006 at 07:30:49PM +0100, Rutger Nijlunsing wrote:
>However, the point I was trying to make was that git might be sped up
>by a magnitude (although not all of the magnitudes in comparison to
>Linux) by looking at why the file IO is this slow: Windows' file IO is
>_not_ the only reason. Using a different/new/better fitted interface
>to Cygwin or Win32 for a specific git task might help, although I have
>no clue what or how.

I'm going to revisit Cygwin's file I/O soon to see if I can figure out
what's adding the overhead and see if it really is inavoidable.  It's
been a while since I've gone through that exercise so it should prove
instructive.

cgf
