From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] Do not use SHELL_PATH from build system in prepare_shell_cmd on Windows
Date: Tue, 17 Apr 2012 10:04:25 -0400
Message-ID: <1334671397-sup-5172@pinkfloyd.chass.utoronto.ca>
References: <7vvclmoit6.fsf@alter.siamese.dyndns.org> <1333157601-6458-1-git-send-email-bwalton@artsci.utoronto.ca> <4F8D15B9.70803@viscovery.net> <1334670128-sup-4966@pinkfloyd.chass.utoronto.ca> <4F8D7779.9080506@viscovery.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: peff <peff@peff.net>, jrnieder <jrnieder@gmail.com>,
	gitster <gitster@pobox.com>, git <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Apr 17 16:04:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SK91F-0006Uy-91
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 16:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756097Ab2DQOE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 10:04:28 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:33254 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755605Ab2DQOE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 10:04:28 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:34986 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SK917-0002W9-Qt; Tue, 17 Apr 2012 10:04:25 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SK917-0006xz-Po; Tue, 17 Apr 2012 10:04:25 -0400
In-reply-to: <4F8D7779.9080506@viscovery.net>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195760>

Excerpts from Johannes Sixt's message of Tue Apr 17 10:00:25 -0400 2012:

> It would require either to #define yet another new name to
> SHELL_PATH or "sh", or to #undef SHELL_PATH and re#define it for
> WIN32. Neither is very appealing. I personally prefer to have the
> conditional (if it is as short as this one) at the point where it
> matters.

Ok.  I'll defer to your more experienced judgement. :)  Thanks for
clarifying though.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
