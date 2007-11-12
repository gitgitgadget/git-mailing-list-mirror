From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH,RFC 1/2] Make the list of common commands more exclusive
Date: Mon, 12 Nov 2007 11:21:34 +0100
Message-ID: <4738292E.2020103@op5.se>
References: <20071111235819.GB7392@thunk.org> <1194829077-14320-1-git-send-email-tytso@mit.edu> <7vzlxk8apz.fsf@gitster.siamese.dyndns.org> <20071112062222.GA17462@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Nov 12 11:22:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrWR0-0001yl-3y
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 11:22:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756449AbXKLKWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 05:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756120AbXKLKWJ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 05:22:09 -0500
Received: from mail.op5.se ([193.201.96.20]:46938 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754599AbXKLKWI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 05:22:08 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id B29E91F08758;
	Mon, 12 Nov 2007 11:22:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n7d8jMATbE58; Mon, 12 Nov 2007 11:21:35 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 5B5491F08757;
	Mon, 12 Nov 2007 11:21:35 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071112062222.GA17462@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64593>

Theodore Tso wrote:
> 
> They probably would be submitting changes back upstream using e-mail
> before they learn how to publish their own repository, so commands I'd
> be tempted to add would include git-format-patch, git-send-email, and
> git-cherry.  But these commands are pretty complicated for beginners....
> 

git format-patch could probably go in, but skip the others. I've never
used git cherry in my entire life and it's not, strictly speaking,
necessary for users to have it. There are other and easier ways to
find the same information.

I'd keep cherry-pick though. It's incredibly useful, and especially
when a commit ends up on the wrong branch which is something newbies
are likely to do when they start trying out the topic-branch workflow.
I still do it sometimes, but hardly ever stop thinking about it since
it's so easy to fix thanks to cherry-pick.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
