From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Completion of error handling
Date: Tue, 02 Feb 2010 20:42:58 +0100
Message-ID: <4B688042.8090400@web.de>
References: <4B68249F.6070004@web.de> <alpine.LFD.2.00.1002021324290.1681@xanadu.home> <4B6873AC.4030303@web.de> <alpine.LFD.2.00.1002021424550.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Feb 02 20:43:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcOeg-0000LD-1j
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 20:43:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755127Ab0BBTnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 14:43:17 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:46901 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852Ab0BBTnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 14:43:16 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id E2CB5145FC7CD;
	Tue,  2 Feb 2010 20:43:00 +0100 (CET)
Received: from [78.49.150.133] (helo=[192.168.1.202])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NcOeK-00017l-00; Tue, 02 Feb 2010 20:43:00 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <alpine.LFD.2.00.1002021424550.1681@xanadu.home>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX19gIAQJWHxLHkIWmefpxSodHZw5yvXx97l8tIy+
	WFl4Itr4Wa1CAZytBWAm4M6psTY1zS9lQERVU1qJDMJ+KK7tbW
	9+Eqr3r4/hp3yBkz8a0g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138743>


> At least on Linux, most of those functions simply cannot fail.

Would you like to support software environments that work without a
famous out-of-memory killer?


> There is just no dynamic memory allocation involved.
>   

I find this opinion strange.


> All other errors are normally due to bad code.
>   

I suggest to avoid unchecked function calls.
Would you like to detect every error situation as early as possible?

Regards,
Markus
