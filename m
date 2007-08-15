From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 1.5.3-rc5 regression on OS X?
Date: Wed, 15 Aug 2007 15:59:17 -0700
Message-ID: <7v7inwo14q.fsf@gitster.siamese.dyndns.org>
References: <801552.56844.qm@web52810.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Perrin Meyer <perrinmeyer@yahoo.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 00:59:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILRpo-0001Gb-Et
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 00:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759672AbXHOW7X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 18:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758063AbXHOW7X
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 18:59:23 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:46782 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbXHOW7X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 18:59:23 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id E32C4121C64;
	Wed, 15 Aug 2007 18:59:41 -0400 (EDT)
In-Reply-To: <801552.56844.qm@web52810.mail.re2.yahoo.com> (Perrin Meyer's
	message of "Wed, 15 Aug 2007 15:52:05 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55966>

Perrin Meyer <perrinmeyer@yahoo.com> writes:

> Well, this is my first time using git-bisect (which seems like a VERY cool tool), but iterating through, using 
> $ make clean ; make -j 4 ; cd t ; sh t1000-read-tree-m-3way.sh ; cd ..
>
> The first bad commit is:
>
> 933bf40a5c6328b6c022b636f45a6f2c48c3838e is first bad commit
> ...
> I'll install the newest Xcode and see if that fixes things. 

Thanks, but before doing so could you try the patch I just sent
out?
