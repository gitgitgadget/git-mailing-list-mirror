From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Better cooperation between checkouts and stashing
Date: Mon, 01 Feb 2010 22:57:10 +0100
Message-ID: <4B674E36.40708@web.de>
References: <4B67227A.7030908@web.de> <7vhbq0wuy6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 22:57:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc4Gy-0005eo-8Z
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 22:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753056Ab0BAV5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 16:57:25 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:42317 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab0BAV5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 16:57:24 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 359FA14CF09D3;
	Mon,  1 Feb 2010 22:57:23 +0100 (CET)
Received: from [78.48.67.5] (helo=[192.168.1.202])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Nc4Gp-0000TO-00; Mon, 01 Feb 2010 22:57:23 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <7vhbq0wuy6.fsf@alter.siamese.dyndns.org>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1/qpRloS9UMmoWemkR2KRztCpj1/aYyI5dl44/I
	HL2SGzobNZ+6THrcLCjJI2NYn2liyS2G7VBJthULsK/9vHi2uk
	7bGrbnZSbqKRFNFFf8DQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138650>


> But the thing is, that starting point is not quite correct.

Thanks for your detailed explanations.



> I actually have explained this at least a few times here in the past:
>
>  http://thread.gmane.org/gmane.comp.version-control.git/77700/focus=77708
>   

I am also very interested in the three use cases that were mentioned in
the discussion for the topic "Switching branches without committing
changes".


> but I don't see anything that states clearly that "checkout" is designed
> to carry your local changes across in any documentation (I gave a cursory
> look to the user manual, tutorial and checkout manual page).

I find it interesting that these descriptions might need still a few
more clarifications about the involved relationships.


>  - Internally run 'git stash', then run 'git checkout other-branch'.
>   

I imagine that this case is useful because of usual work interruptions
in software development. A developer tries to bring various tasks
forward in parallel. Branches will be switched often with unfinished
work that needs to be kept before the reactivation of another task.

Regards,
Markus
