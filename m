From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] parse-options: add PARSE_OPT_CUSTOM_ARGH for complicated argh's
Date: Mon, 18 May 2009 00:57:43 -0700
Message-ID: <7vmy9aetc8.fsf@alter.siamese.dyndns.org>
References: <1242557224-8411-1-git-send-email-bebarino@gmail.com>
	<1242557224-8411-2-git-send-email-bebarino@gmail.com>
	<7vd4a7ey4h.fsf@alter.siamese.dyndns.org> <4A11096B.8020208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 09:58:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5xkB-0001su-1H
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 09:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756970AbZERH5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 03:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756988AbZERH5o
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 03:57:44 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:41065 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756950AbZERH5n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 03:57:43 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090518075745.VIBU20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Mon, 18 May 2009 03:57:45 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id svxj1b0074aMwMQ04vxjZS; Mon, 18 May 2009 03:57:43 -0400
X-Authority-Analysis: v=1.0 c=1 a=ckEMPOoq4BcA:10 a=gN7GTBdjX9cA:10
 a=pGLkceISAAAA:8 a=SCkgvFZ-nr6HT9gnmGYA:9 a=E6RUanH0SDuHBTyOv5JKs40YBKYA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <4A11096B.8020208@gmail.com> (Stephen Boyd's message of "Mon\, 18 May 2009 00\:08\:27 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119423>

Stephen Boyd <bebarino@gmail.com> writes:

> This description sounds nice ;) Is PARSE_OPT_CUSTOM_ARGH a good name? I
> was thinking maybe PARSE_OPT_MULTARGS is better?

You are asking a wrong person.  I am terrible at naming things; think
"rerere" ;-).

But I think custom-arghelp is much better than multargs.  You are asking
"use this help for argument value _literally_", so another possibility
perhaps is PARSE_OPT_ARGHELP_LITERAL.

After all, there probably are many other valid reasons why you may not
want "s/.*/<&>/" blindly applied to your string.  One reason may be
because the string describes multiple arguments, but I suspect that it is
not the only one.  It is better to name the option after what it does,
than naming it after one sample reason why you might want to use that
option.

>> Please update Documentation/technical/api-parse-options.txt as well.
>
> There's no documentation on the flags yet, but I suppose I could add that.

Thanks.
