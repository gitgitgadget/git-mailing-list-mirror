From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 3/3] Adds a #!bash to the top of bash completions so that editors can recognize, it as a bash script. Also adds a few simple comments above commands that, take arguments. The comments are meant to remind editors of potential, problems that
Date: Sat, 17 Jan 2009 13:37:48 +0100
Message-ID: <200901171337.49938.markus.heidelberg@web.de>
References: <2faad3050901160706y297a98d4r35340e4811ca3d2b@mail.gmail.com> <20090117014057.GA15331@coredump.intra.peff.net>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Baz <brian.ewins@gmail.com>,
	Adeodato =?utf-8?q?Sim=C3=B3?= <dato@net.com.org.es>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Ted Pavlic <ted@tedpavlic.com>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 17 13:38:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOARe-0002X8-U7
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 13:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756763AbZAQMhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 07:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756746AbZAQMhK
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 07:37:10 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:55445 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbZAQMhI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 07:37:08 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id CBB34F6A644B;
	Sat, 17 Jan 2009 13:37:06 +0100 (CET)
Received: from [89.59.83.225] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LOAQE-0000Ki-00; Sat, 17 Jan 2009 13:37:06 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <20090117014057.GA15331@coredump.intra.peff.net>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+iYdhmrcE9MSVDn5FvkmJY6ekz/HSpqbMvFGev
	PeoLLNtvHUhO4ZkeDoZy2OFzsDVHuExnmgisiD6hoiKWMzfN8Y
	kVdkqlb3Pdst+N4Ja3ow==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106047>

Jeff King, 17.01.2009:
> On Fri, Jan 16, 2009 at 03:06:34PM +0000, Baz wrote:
> 
> > > At the beginning I tried to fulfil this limit, but often it's not easy.
> > > So should it be adjusted to a slightly higher value in the documentation
> > > or even split into a recommended limit (e.g. 50) and a recommended
> > > absolute maximum (e.g. 76)? Hmm, the split wouldn't make sense, I think.
> > 
> > The 50 character limit is for the first line, try "git log
> > --pretty=oneline" and it should be obvious why.
> 
> I'm not sure it makes sense to make a workflow recommendation that the
> git project itself does not follow.

I think, it doesn't.

> In practice, is this a problem for people using git.git?
> 
> Personally, I find --pretty=oneline unreadable because so much of the
> screen real estate is wasted on random characters that I don't care
> about. I find --pretty=tformat:'%h %s' much nicer

But it doesn't automatically color the SHA1.

> (yes, --abbrev-commit
> works, too, but I find the '...' a pointless waste of space).

And they are annoying for selecting with the mouse doubleclick, at least
Konsole selects the SHA1 including the '...'. Xterm doesn't and I
haven't looked if Konsole can be configured to do so, but without the
'...' it would probably work regardless of the terminal emulator and
its setting.

Markus
