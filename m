From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] Documentation: fix typos, grammar, asciidoc syntax
Date: Sat, 20 Dec 2008 23:18:53 +0200
Message-ID: <87d4fmpmte.fsf@iki.fi>
References: <200812191314.19302.markus.heidelberg@web.de>
	<7v3agj1gvp.fsf@gitster.siamese.dyndns.org>
	<200812201418.38707.markus.heidelberg@web.de>
	<7v3agiy5gs.fsf@gitster.siamese.dyndns.org> <87tz8yponl.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: markus.heidelberg@web.de, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 22:24:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LE9Ja-0005Zh-8j
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 22:24:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753523AbYLTVWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 16:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753449AbYLTVWv
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 16:22:51 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:60474 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753439AbYLTVWu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 16:22:50 -0500
Received: from mithlond.arda.local (80.220.180.181) by jenni2.inet.fi (8.5.014)
        id 48FC5A8802CC5D8B; Sat, 20 Dec 2008 23:19:38 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LE9Dp-0001HW-F5; Sat, 20 Dec 2008 23:18:53 +0200
In-Reply-To: <87tz8yponl.fsf@iki.fi> (Teemu Likonen's message of "Sat\, 20 Dec 2008 22\:39\:10 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103668>

Teemu Likonen (2008-12-20 22:39 +0200) wrote:

> To get the logical single quote the man page source should contain \(aq
> or \[aq] . Don't know how to make asciidoc do this.

But \(aq seems to be groff-specific and not necessarily portable. Oh
well, quotation marks are really a mess in man pages. Some reference:

    http://www.mail-archive.com/groff@gnu.org/msg04150.html

But char " should be reliable anyway. It renders as Ascii double quote.
