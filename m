From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Make git-blame fail when working tree is needed and	we're
 not in one
Date: Sat, 03 Nov 2007 16:01:52 +0100
Message-ID: <472C8D60.4070809@op5.se>
References: <1194092575-7133-1-git-send-email-mh@glandium.org> <1194092575-7133-2-git-send-email-mh@glandium.org> <1194092575-7133-3-git-send-email-mh@glandium.org> <20071103123031.GA7425@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Nov 03 16:02:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoKVo-0001vy-9I
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 16:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978AbXKCPB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 11:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753926AbXKCPB6
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 11:01:58 -0400
Received: from mail.op5.se ([193.201.96.20]:52376 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753918AbXKCPB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 11:01:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id B1CF91730713;
	Sat,  3 Nov 2007 16:01:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id srg8TvcivCjN; Sat,  3 Nov 2007 16:01:45 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id 7570917306E6;
	Sat,  3 Nov 2007 16:01:45 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071103123031.GA7425@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63279>

Mike Hommey wrote:
> Oops, I forgot -n to format-patch. Wasn't there a proposal to have -n
> automatically set when outputing several patches ?
> 

No. There was a patch to skip numbering when only one patch was created.
I suppose a different implementation of that patch could make the default
to number when multiple patches are created but not when a single one is.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
