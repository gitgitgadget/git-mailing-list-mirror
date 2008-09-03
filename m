From: Andreas Ericsson <ae@op5.se>
Subject: Re: Merge seems to get confused by (reverted) cherry-picks
Date: Wed, 03 Sep 2008 13:04:23 +0200
Message-ID: <48BE6F37.3070302@op5.se>
References: <20080903072011.GA14252@atjola.homenet> <7vprnld5ws.fsf@gitster.siamese.dyndns.org> <48BE56BD.6050805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbr?= =?ISO-8859-15?Q?ink?= 
	<B.Steinbrink@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Ittay Dror <ittay.dror@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 13:06:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaqB6-0000a0-FL
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 13:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbYICLEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 07:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbYICLEa
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 07:04:30 -0400
Received: from mail.op5.se ([193.201.96.20]:50601 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751351AbYICLE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 07:04:29 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 6FBA61B80362;
	Wed,  3 Sep 2008 13:09:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RZgaYME00cnw; Wed,  3 Sep 2008 13:09:56 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.181])
	by mail.op5.se (Postfix) with ESMTP id 5BE681B80046;
	Wed,  3 Sep 2008 13:09:54 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <48BE56BD.6050805@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94785>

Ittay Dror wrote:
> Note: codeville tried to implement a merge algorithm that considers the 
> history to decide what the user wants to do: 
> http://revctrl.org/PreciseCodevilleMerge. Maybe worth while exploring?
> 

I believe that one would still fail for this case, as "ImplicitUndo"
isn't included.

Besides that, I'd rather have something simple that does something
predictable than something complex that pushes the "gets it right"
figure from 98% to 99.2%, while failing in completely annoying and
surprising ways sometimes. Someone or something still has to verify
that the merge produced something sane.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
