From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] Avoid crippled getpass function on Solaris
Date: Sun, 05 Aug 2012 22:35:06 -0400
Message-ID: <1344220427-sup-3468@pinkfloyd.chass.utoronto.ca>
References: <1344208672-20028-1-git-send-email-bwalton@artsci.utoronto.ca> <7vboio231n.fsf@alter.siamese.dyndns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: peff <peff@peff.net>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 04:35:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyDA7-0004sb-08
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 04:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755492Ab2HFCfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 22:35:12 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:51789 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755468Ab2HFCfL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 22:35:11 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:54203 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SyD9u-0008Ln-PY; Sun, 05 Aug 2012 22:35:06 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SyD9u-0006My-OY; Sun, 05 Aug 2012 22:35:06 -0400
In-reply-to: <7vboio231n.fsf@alter.siamese.dyndns.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202953>

Excerpts from Junio C Hamano's message of Sun Aug 05 21:59:48 -0400 2012:
> Wouldn't
> 
>     #if solaris
>         #define getpass getpassphrase
>         #endif
> 
> without anything else be more than sufficient?

Yes, it would, but I was hoping to make it more explicit that the
function getpass may be substituted with something else.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
