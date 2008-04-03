From: Jake Goulding <goulding@vivisimo.com>
Subject: Re: [REQ] Better error reporting when git rebase cannot rebase
Date: Thu, 03 Apr 2008 09:38:35 -0400
Message-ID: <47F4DDDB.60706@vivisimo.com>
References: <47F3A9CA.9090307@vivisimo.com> <20080403095722.GA6673@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 03 15:39:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhPez-00043a-Vg
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 15:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072AbYDCNii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 09:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756694AbYDCNii
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 09:38:38 -0400
Received: from scalix.vivisimo.com ([207.97.211.28]:50164 "EHLO
	mail.vivisimo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753733AbYDCNii (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 09:38:38 -0400
Received: from mail.office.vivisimo.com (mail.office.vivisimo.com [206.210.75.84])
	by mail.vivisimo.com (Postfix) with ESMTP id C64318509BD;
	Thu,  3 Apr 2008 09:38:36 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.office.vivisimo.com (Postfix) with ESMTP id 9A1F12EE886;
	Thu,  3 Apr 2008 09:38:36 -0400 (EDT)
X-Virus-Scanned: amavisd-new at vivisimo.com
Received: from mail.office.vivisimo.com ([127.0.0.1])
	by localhost (office.mail.vivisimo.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jC3RjJbVcmHt; Thu,  3 Apr 2008 09:38:35 -0400 (EDT)
Received: from [192.168.0.20] (unknown [192.168.0.20])
	by mail.office.vivisimo.com (Postfix) with ESMTP id C77C22EE885;
	Thu,  3 Apr 2008 09:38:35 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.12 (X11/20080304)
In-Reply-To: <20080403095722.GA6673@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78749>

Jeff King wrote:
> 
> Unfortunately I am not sure of the best way to fix this message. It
> happens at a very low level in read-cache.c, and so it shows up in
> several different places. I am not even sure of all the places you can
> see it, so coming up with different text that makes more sense is
> non-trivial.
> 

I was afraid that something like that might be the case. Would it be 
worth putting in a second request to make that message more specific?

> But this is, I think, a slightly separate issue, which is that rebase
> just bails without saying why. And that's easy to fix. How about this?
> 
 > [.snip.]

That seems good to me. I think the important thing is to make sure that 
the user is aware that what they wanted to do did not happen.
