From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Add Documentation/CodingStyle
Date: Wed, 07 Nov 2007 01:04:20 +0100
Message-ID: <47310104.5040202@op5.se>
References: <20071106201518.GA6361@ins.uni-bonn.de> <20071106201809.GD6361@ins.uni-bonn.de> <20071106202600.GH6361@ins.uni-bonn.de> <7vtznzf5jb.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711062317330.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 07 01:04:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpYPR-0007Cc-Ma
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 01:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205AbXKGAE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 19:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbXKGAE1
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 19:04:27 -0500
Received: from mail.op5.se ([193.201.96.20]:39231 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079AbXKGAE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 19:04:26 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 6DDB917305AD;
	Wed,  7 Nov 2007 01:04:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6JQNLq9Z9Tny; Wed,  7 Nov 2007 01:04:07 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id CCB15173059F;
	Wed,  7 Nov 2007 01:04:06 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <Pine.LNX.4.64.0711062317330.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63756>

Johannes Schindelin wrote:
> Even if our code is quite a good documentation for our coding style,
> some people seem to prefer a document describing it.
> 

Sweet. You just saved me 40 minutes of writing one just like that for
company use. I owe you a drink, and then you can tell me what movie
you alluded to ;-)

> +
> + - if you are planning a new command, consider writing it in shell or
> +   perl first, so that changes in semantics can be easily changed and
> +   discussed.  Many git commands started out like that, and a few are
> +   still scripts.

I'd skip this part though and just add a pointer to contrib/examples/,
saying something along the lines of

- if you're planning a new command, sneak a peak in contrib/examples/
  for ample study-material of retired git commands implemented in perl
  and shell.

Possibly with s/retired // on that paragraph.

There's nothing particular wrong with writing in C from the start after
all.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
