From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use compatibility regex library also on AIX
Date: Thu, 11 Sep 2008 01:27:05 -0700
Message-ID: <7v7i9jt7dy.fsf@gitster.siamese.dyndns.org>
References: <20080907184537.GA4148@regex.yaph.org>
 <e2b179460809100103t4266650bnac00097cfb86c0b1@mail.gmail.com>
 <20080910100301.GA27748@regex.yaph.org>
 <e2b179460809100453r3df4ec8dh3d9bfbbd468c5676@mail.gmail.com>
 <e2b179460809110059i2eca8b07x6d263f06cc8e5d32@mail.gmail.com>
 <48C8D374.9050007@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Ralphson <mike.ralphson@gmail.com>, git@vger.kernel.org,
	Arjen Laarhoven <arjen@yaph.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 11 10:28:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdhXI-0002Up-Jn
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 10:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753607AbYIKI1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 04:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753561AbYIKI1Q
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 04:27:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57816 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbYIKI1P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 04:27:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6F2355FE86;
	Thu, 11 Sep 2008 04:27:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 639725FE83; Thu, 11 Sep 2008 04:27:08 -0400 (EDT)
In-Reply-To: <48C8D374.9050007@viscovery.net> (Johannes Sixt's message of
 "Thu, 11 Sep 2008 10:14:44 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6F643242-7FDB-11DD-A61F-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95595>

Johannes Sixt <j.sixt@viscovery.net> writes:

> This augments 3632cfc24 (Use compatibility regex library on Darwin,
> 2008-09-07), which already carries a "Tested-by" statement for AIX,
> but that test was actually done with this patch included.
>
> Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
> Tested-by: Mike Ralphson <mike@abacus.co.uk>
> ---
> Mike Ralphson schrieb:
>> 2008/9/10 Mike Ralphson <mike.ralphson@gmail.com>:
>> Junio, sorry, I should have made this clear, but as above in the
>> thread, Johannes Sixt's 'patchlet' is required to be squashed into
>> 3632cfc24, and I think Arjen was going to re-roll the patch.
>> 
>> I can submit the required follow-up, but it really should have J6's S-o-b.
>
> Here it is. Disclaimer: This patch submission was hand-crafted. ;)

Sorry, my fault --- I should have noticed the missing "ifeq AIX"
anywhere in the hunk headers.

Thanks.
