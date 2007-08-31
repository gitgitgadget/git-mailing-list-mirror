From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Add commands that git-gc runs underneath
Date: Fri, 31 Aug 2007 11:33:12 +0200
Message-ID: <46D7E058.9050001@op5.se>
References: <lkbtwek0.fsf@cante.net>	<Pine.LNX.4.64.0708301107320.28586@racer.site>	<46D6984D.9040802@op5.se> <7v7inc907e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 11:33:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR2sX-0002Zk-NT
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 11:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbXHaJdQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 05:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbXHaJdQ
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 05:33:16 -0400
Received: from mail.op5.se ([193.201.96.20]:50693 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932099AbXHaJdP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 05:33:15 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 7B2F5194431;
	Fri, 31 Aug 2007 11:33:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0MgC+P8F71zK; Fri, 31 Aug 2007 11:33:13 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id F2D7E1943C5;
	Fri, 31 Aug 2007 11:33:12 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <7v7inc907e.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57143>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
>> When gc was a shell-script, it was fairly easy to find out the command-
>> sequence...
> 
> Maybe referring more advanced/curious users to contrib/examples/
> directory is a good idea, but not necessarily from manpages of
> the commands that have been rewritten in C.
> 
> I think contrib/examples/ needs a README file that effectively
> say "these are the last versions of shell script implementation
> of the commands before they were rewritten in C.  New features
> may have been added to the built-in ones but these example
> scripts are not kept up to date.  They are here to serve as
> examples to show you how you would pipeline the plumbing level
> commands."
> 

Sensible, and also avoids the possible bitrot problem with the
man-page should there be additional actions added to standard
git-gc operations.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
