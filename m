From: Samuel GROOT <samuel.groot@ensimag.grenoble-inp.fr>
Subject: Re: [RFC/PATCH] Formatting variables in the documentation
Date: Mon, 23 May 2016 18:00:26 +0200
Message-ID: <b06231ac-b100-2565-3bf7-99f268014788@ensimag.grenoble-inp.fr>
References: <1463587109-22476-1-git-send-email-tom.russello@grenoble-inp.org>
 <20160518181500.GD5796@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, matthieu.moy@grenoble-inp.fr,
	erwan.mathoniere@ensimag.grenoble-inp.fr,
	jordan.de-gea@ensimag.grenoble-inp.fr, gitster@pobox.com,
	stefan@sevenbyte.org, jrnieder@gmail.com, rybak.a.v@gmail.com
To: Jeff King <peff@peff.net>,
	Tom Russello <tom.russello@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Mon May 23 18:09:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4sPo-0006ZN-RM
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 18:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595AbcEWQI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 12:08:57 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:55098 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753523AbcEWQIy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2016 12:08:54 -0400
X-Greylist: delayed 505 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 May 2016 12:08:54 EDT
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 4F9BA210B;
	Mon, 23 May 2016 18:00:26 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eVl0m8QI-40E; Mon, 23 May 2016 18:00:26 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 1D53B20A6;
	Mon, 23 May 2016 18:00:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 1480C2077;
	Mon, 23 May 2016 18:00:26 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qt_gUoJAQxhE; Mon, 23 May 2016 18:00:26 +0200 (CEST)
Received: from wificampus-030221.grenet.fr (wificampus-030221.grenet.fr [130.190.30.221])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id EE1092066;
	Mon, 23 May 2016 18:00:25 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
In-Reply-To: <20160518181500.GD5796@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295335>

Some people have suggested to standardize documentation's formatting to 
make it more consistent.

[1] 2015-04-29 20:13:53 GMT, Junio C Hamano wrote:
> Interesting.  What I happen to use when populating the git-manpages
> repository would have wider impact to the users, as I hear that some
> (or many) distros just package whatever I have there.  I do not mind
> enabling it on my end if that gives us more readable rendition.

[2] On 2015-04-29 20:32:47, Jeff King wrote:
> I think it's probably fine and a positive change, but one never knows. I
> guess distros don't package what you ship until you actually tag a
> release, so it would be OK to start doing so during a cycle to shake out
> any problems (and in fact preferable, as anybody who follows "master"
> using "make install-man-quick" would get it early and be able to make a
> report).
>
> If we are doing that, it would make sense to flip MAN_BOLD_LITERAL on by
> default during that same cycle, so we could get reports from people who
> build the manpages from source.

[3] On 2015-11-13 05:45:05, Jeff King wrote:
> If we want to move to backticks, we probably want to also turn on
> MAN_BOLD_LITERAL by default, or it's a step backwards for some folks.

The question is about flipping MAN_BOLD_LITERAL by default or not.

Since 2.8.3 was out recently, we could flip MAN_BOLD_LITERAL on by 
default for this cycle to shake out problems as Jeff King suggested [2].


Another option could be testing if the system does support bold literal 
and flipping it on or off accordingly, but I don't know exactly where 
that could be done.
