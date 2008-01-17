From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Fri, 18 Jan 2008 02:10:06 +0300
Message-ID: <20080117231006.GA14871@dpotapov.dyndns.org>
References: <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <87odbkyuvq.fsf@adler.orangeandbronze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Wincent Colaiuta <win@wincent.com>,
	Kevin Ballard <kevin@sb.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: JM Ibanez <jm@orangeandbronze.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 00:11:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFdsx-0002Yp-Ag
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 00:10:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757882AbYAQXKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 18:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758261AbYAQXKO
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 18:10:14 -0500
Received: from smtp02.mtu.ru ([62.5.255.49]:55563 "EHLO smtp02.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758061AbYAQXKM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 18:10:12 -0500
Received: from smtp02.mtu.ru (localhost [127.0.0.1])
	by smtp02.mtu.ru (Postfix) with ESMTP id 291BF31134;
	Fri, 18 Jan 2008 02:09:57 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-190-40.pppoe.mtu-net.ru [85.141.190.40])
	by smtp02.mtu.ru (Postfix) with ESMTP id 79D6E30E7C;
	Fri, 18 Jan 2008 02:09:56 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JFds6-0003wT-Mw; Fri, 18 Jan 2008 02:10:06 +0300
Content-Disposition: inline
In-Reply-To: <87odbkyuvq.fsf@adler.orangeandbronze.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp02.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70937>

On Fri, Jan 18, 2008 at 06:01:13AM +0800, JM Ibanez wrote:
> 
> With the exception of Unicode.

Nice exception...

> If you check the standard,

The standard of what? Could you provide the exact reference?

> two Unicode
> codepoints (i.e. the numeric value that gets stored on disk)

Does the standard say something about disk storage?

> *can* map to the same character, 

So what?

> hence they are the same.

non-sequitor.

> They don't just look the
> same, they are the same character

Because?

> -- even if the codepoints are
> different (i.e. precomposed vs. decomposed characters).

And where exactly does the standard says so?

> In fact, part of
> the Unicode standard deals with that. (Technically, Unicode calls it
> equivalence, but what the hey).

So they are not the same after all? It is just you don't care
about what it actually says, right? How about this: Unicode
provides a unique number for every character. So, if numbers
are not the same then by definition of the Unicode standard
those characters are different.

> 
> In other words, Unicode treats e.g. both U+0065 and U+00E9 as
> fundamentally the same character.

There is no notion "fundamentally the same character" in the Unicode
standard as far as I know, and the characters you mentioned are very
different in Unicode:
http://www.fileformat.info/info/unicode/char/0065/index.htm
http://www.fileformat.info/info/unicode/char/00e9/index.htm
There have different names, they have different glyphs, and they
are functional different.

Dmitry
