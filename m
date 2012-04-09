From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] Avoid bug in Solaris xpg4/sed as used in submodule
Date: Mon, 09 Apr 2012 14:47:58 -0400
Message-ID: <1333997276-sup-2760@pinkfloyd.chass.utoronto.ca>
References: <1333935414-10389-1-git-send-email-bwalton@artsci.utoronto.ca> <m2sjgde7cs.fsf@linux-m68k.org> <1333977812-sup-4111@pinkfloyd.chass.utoronto.ca> <m2fwcdc57q.fsf@igel.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, GIT List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Apr 09 20:48:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHJdG-000598-Vt
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 20:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226Ab2DISsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 14:48:00 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:55732 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428Ab2DISsA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 14:48:00 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:49148 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SHJd8-00017C-Pl; Mon, 09 Apr 2012 14:47:58 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SHJd8-0000u3-Ok; Mon, 09 Apr 2012 14:47:58 -0400
In-reply-to: <m2fwcdc57q.fsf@igel.home>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195027>

Excerpts from Andreas Schwab's message of Mon Apr 09 11:09:13 -0400 2012:

> >> How about using 's|[^/][^/]*|..|g' instead, which should avoid the bug
> >> as well.
>
> AFAICS the variables at this point never contain a value with a leading
> slash.

Ok.  Junio also agrees with this and the test suite passes too. I'll
send in an updated patch shortly.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
