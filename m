From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] stash: Don't paginate by default with list command
Date: Tue, 30 Aug 2011 13:43:46 -0400
Message-ID: <1314726104-sup-5174@pinkfloyd.chass.utoronto.ca>
References: <4e5d1e5c.438d9c87.bm000@wupperonline.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?utf-8?q?Ingo_Br=C3=BCckl?= <ib@wupperonline.de>
X-From: git-owner@vger.kernel.org Tue Aug 30 19:44:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QySMX-0000Tj-ST
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 19:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755904Ab1H3Roa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 13:44:30 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from jerry.cquest.utoronto.ca ([192.82.128.5]:42277 "EHLO
	jerry.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755858Ab1H3Rnt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 13:43:49 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:43992 ident=93)
	by jerry.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1QySLi-0005FZ-UN; Tue, 30 Aug 2011 13:43:46 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1QySLi-0002NA-TV; Tue, 30 Aug 2011 13:43:46 -0400
In-reply-to: <4e5d1e5c.438d9c87.bm000@wupperonline.de>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180424>

Excerpts from Ingo Br=C3=BCckl's message of Tue Aug 30 13:21:18 -0400 2=
011:

> The output of "stash list" is such that piping into a pager
> normally isn't necessary but annoying, so disable it by default.

If you $PAGER is less and you use the default LESS environment value
=46RXS, this shouldn't be annoying at all.  Are you using either a
different pager or a different value for LESS?

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
