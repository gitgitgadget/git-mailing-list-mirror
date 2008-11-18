From: Andreas Ericsson <ae@op5.se>
Subject: Re: [small bug] Surprising "Did you mean this?"
Date: Tue, 18 Nov 2008 19:29:56 +0100
Message-ID: <492309A4.1050702@op5.se>
References: <vpqod0dezh9.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Nov 18 19:31:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2VMM-00064H-2n
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 19:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbYKRSaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 13:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbYKRSaS
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 13:30:18 -0500
Received: from mail.op5.se ([193.201.96.20]:34050 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750844AbYKRSaR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 13:30:17 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id EB1D91B80072;
	Tue, 18 Nov 2008 19:25:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YXcx2KQS2GNt; Tue, 18 Nov 2008 19:25:11 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id 6E8991B80062;
	Tue, 18 Nov 2008 19:25:11 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <vpqod0dezh9.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101276>

Matthieu Moy wrote:
> Hi,
> 
> The following is quite surprising:
> 
>   $ git tags 
>   git: 'tags' is not a git-command. See 'git --help'.
>   
>   Did you mean this?
>           status
>   
> I would have expected git to propose me "tag" (1 character removal),
> while "status" is quite far from "tags" (remove g, add u, add another
> t, shuffle and you're there).
> 

That's the Deveraux(?) addendum in action. shuffle+replace = 3 in the
distance score, while remove = 4 (I think).

Typos by users accustomed to computers are more often of the shuffle
(haed vs head) or replace (hwad vs head) kind, while those less
accustomed often fumble more and press more keys. For this case though,
I agree it gives a rather strange result.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
