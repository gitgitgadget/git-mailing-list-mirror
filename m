From: Andreas Ericsson <ae@op5.se>
Subject: Re: git diff woes
Date: Tue, 13 Nov 2007 08:40:40 +0100
Message-ID: <473954F8.8070908@op5.se>
References: <4738208D.1080003@op5.se>	<Pine.LNX.4.64.0711120958500.4362@racer.site> <47382C84.50408@op5.se>	<7vhcjr2lte.fsf@gitster.siamese.dyndns.org> <4738E9E6.2040001@op5.se> <buomytin9dz.fsf@dhapc248.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 08:41:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrqOK-0002tB-Sp
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 08:41:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbXKMHkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 02:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbXKMHkp
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 02:40:45 -0500
Received: from mail.op5.se ([193.201.96.20]:58907 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847AbXKMHko (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 02:40:44 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id F2DC41F0875A;
	Tue, 13 Nov 2007 08:40:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ExcKhcT3jFkP; Tue, 13 Nov 2007 08:40:42 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id BDE3A1F08758;
	Tue, 13 Nov 2007 08:40:41 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <buomytin9dz.fsf@dhapc248.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64761>

Miles Bader wrote:
> Andreas Ericsson <ae@op5.se> writes:
>> I notice it, and I don't like it. I guess I'm just used to git being
>> smarter than their GNU tool equivalents, especially since it only ever
>> applies patches in full.
> 
> It's not at all obvious that this behavior is actually wrong -- it seems
> perfectly reasonable to use either old or new text for the hunk headers.
> 

Right, which is why I've made it configurable.

> It hardly matters really, since that particular output is just "useful
> noise" to provide a bit of helpful context for human readers, and humans
> (unlike programs) are notoriously good at not being bothered by such
> things.  Er, well most humans anyway.
> 

I wouldn't have reacted either, except that this time someone asked me to
review a branch early in the morning because he had introduced a bug in the
process, and the hunk header information made me assume the wrong hunk of
the patch was the culprit.

On the one hand, it wouldn't have been so much of a problem if the developer
in question would have followed my suggestion of committing small and making
sure the commit message describes everything that's done. On the other hand,
a tool fooling a human isn't a good thing either, even if said human is not
really in shape for using said tool.

Granted, the new form can still fool people, but for archeology excursions
I think it's definitely right to use the "new" funcname in the hunk header.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
