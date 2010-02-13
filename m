From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] Fix signal handler
Date: Sat, 13 Feb 2010 14:30:45 +0100
Message-ID: <4B76A985.9070809@web.de>
References: <4B684F5F.7020409@web.de> <20100202205849.GA14385@sigill.intra.peff.net> <4B71A2EE.8070708@web.de> <4B72E81B.3020900@web.de> <20100210173348.GA5091@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 13 14:30:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgI5I-0005Mk-Eo
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 14:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754641Ab0BMNat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 08:30:49 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:37094 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861Ab0BMNat (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 08:30:49 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id EF8DB13DF8299;
	Sat, 13 Feb 2010 14:30:47 +0100 (CET)
Received: from [92.227.193.197] (helo=[192.168.1.202])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NgI59-00013S-00; Sat, 13 Feb 2010 14:30:47 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <20100210173348.GA5091@coredump.intra.peff.net>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1/cR9ki1G7DGL0KkvIf+of3O7xbKUbuGo5LF5Yp
	IT3aK7ATY47EGhzc6SK9lqt1dwxirnDDFVKm0AlHkJ/7G96nla
	KoNadgdaAadxI4IMervQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139794>


>
> Why does this need to become extern?

How do you think about to stress the detail that the function
"log_show_early" is called by the function "limit_list" from an other
translation unit.



>
> Overall, this change looks sane to me.

How are the chances to get the update suggestion into the public Git
repository?


> You still haven't provided any evidence that this is a problem in practice,
> but these changes are not particularly cumbersome, so it is probably better
> to be on the safe side.
>   

It is a matter of safety if all implementation details of the source
code conform to well-known programming standards.

Regards,
Markus
