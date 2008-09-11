From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [PATCH] git wrapper: also uses aliases to suggest mistyped commands
Date: Thu, 11 Sep 2008 12:37:35 +0200
Message-ID: <9FACD5FA-7BAE-40B9-B378-165BAEAF2045@ai.rug.nl>
References: <1221062068-5660-1-git-send-email-pdebie@ai.rug.nl> <7vtzcnvfq4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 12:38:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdjZh-0003oP-Tk
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 12:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341AbYIKKhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 06:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752351AbYIKKhu
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 06:37:50 -0400
Received: from frim.nl ([87.230.85.232]:41589 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752326AbYIKKht (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Sep 2008 06:37:49 -0400
Received: from s5591931c.adsl.wanadoo.nl ([85.145.147.28] helo=[192.168.1.11])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1KdjYU-0002X3-6b; Thu, 11 Sep 2008 12:37:42 +0200
In-Reply-To: <7vtzcnvfq4.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95601>


On 10 sep 2008, at 23:44, Junio C Hamano wrote:

> Aliases should not hide the commands available elsewhere, and the  
> actual
> execution codepath around ll.480-490 in git.c avoids getting fooled by
> misconfigured aliases, but you do not protect yourself from that  
> kind of
> misconfiguration in this patch.  You can have both "git-foo" command  
> on
> your private $PATH and alias.foo in your configuration, and they  
> will have
> the same levenshtein score.  I suspect this will cause the same "foo"
> suggested twice when the user types "git fo" from the command line.

Yes, I didn't think of that.

> Here is a suggested fix-up on top of your patch to address these  
> issues.

Looks good. Do you want me to resend the patch or will you squash it?

- Pieter
