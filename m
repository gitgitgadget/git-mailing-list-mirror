From: Michael <barra_cuda@katamail.com>
Subject: Re: [PATCH] fix git-revert command-line options
Date: Thu, 3 Aug 2006 22:48:58 +0200
Message-ID: <200608032248.58156.barra_cuda@katamail.com>
References: <20060803153742.109978@dial-up-mi-12.lombardiacom.it> <20060803184141.GA5476@admingilde.org> <7vmzalpqdt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Thu Aug 03 22:45:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8k3f-0006if-Hl
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 22:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWHCUoZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 16:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWHCUoZ
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 16:44:25 -0400
Received: from fe-3c.inet.it ([213.92.5.106]:59854 "EHLO fe-3c.inet.it")
	by vger.kernel.org with ESMTP id S1751350AbWHCUoX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 16:44:23 -0400
Received: from dial-up-mi-300.lombardiacom.it ([::ffff:212.34.226.46]) by fe-3c.inet.it via I-SMTP-5.4.4-546
	id ::ffff:212.34.226.46+QEAgIM1Td1k; Thu, 03 Aug 2006 22:44:17 +0200
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.8.2
In-Reply-To: <7vmzalpqdt.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Message-ID: <20060803204417.516906@dial-up-mi-300.lombardiacom.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Martin Waitz <tali@admingilde.org> writes:
> > On Thu, Aug 03, 2006 at 05:42:23PM +0200, Michael wrote:
> >> -	-n|--n|--no|--no-|--no-c|--no-co|--no-com|--no-comm|\
> >> +	-n|--no-c|--no-co|--no-com|--no-comm|\
> >>
> >> -	--n|--no|--no-|--no-e|--no-ed|--no-edi|--no-edit)
> >> +	--n|--no-e|--no-ed|--no-edi|--no-edit)
> >
> > well spottet, but now we still have "-n" versus "--n".
> > Perhaps we should drop the single-letter options or at least only
> > keep one of them and then explicitly document that in the manpage.
>
> Good suggestion.

Well, I left "--n" for the lazy typers, but it's too confusing - and
can be easy misremembered. I'd leave "-n" for "--no-commit", though
(and it's already on man page).
Your choice.
