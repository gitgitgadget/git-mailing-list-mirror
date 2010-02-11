From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Completion of error handling
Date: Thu, 11 Feb 2010 14:08:35 +0100
Message-ID: <4B740153.4010600@web.de>
References: <4B68249F.6070004@web.de> <alpine.LFD.2.00.1002021324290.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Feb 11 14:08:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfYmt-0004UL-Bl
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 14:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134Ab0BKNIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 08:08:41 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:37832 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754229Ab0BKNIk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 08:08:40 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id D652E146C60B4;
	Thu, 11 Feb 2010 14:08:38 +0100 (CET)
Received: from [78.48.68.13] (helo=[192.168.1.202])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NfYmc-00050M-00; Thu, 11 Feb 2010 14:08:38 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <alpine.LFD.2.00.1002021324290.1681@xanadu.home>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX19fYSTf6XxcNLyVgydFiq6D028+x9C1vRvZxsNo
	duCa/Wa4LvOOpPzPIk46IPp3Q5LQtuylPyTuxgKjoWQKQK9GDA
	0rXGVYkufmho+fXsJxmw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139587>


>
> What is the likelihood for those function calls to actually fail?
>   

How do you think about the usual design choices that are described in
the article "Exception Handling Alternatives" by Detlef Vollmann.
http://accu.org/index.php/journals/546


I propose to write pointcuts for all functions that can return values.
Some corresponding error codes are checked already. But there a places
in the source files with open issues for complete software robustness.

Are there any chances to encapsulate more cross-cutting concerns as
reusable aspects?

Would you like to integrate tools like the following into your software
development process?
- AspectC++
  http://aspectc.org/

- ACC
 
http://research.msrg.utoronto.ca/ACC/Tutorial#A_Reusable_Aspect_for_Memory_All

- Coccinelle
  http://coccinelle.lip6.fr/

Regards,
Markus
