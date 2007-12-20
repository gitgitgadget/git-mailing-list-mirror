From: Junio C Hamano <gitster@pobox.com>
Subject: Re: more than 20 commands in everyday.txt
Date: Wed, 19 Dec 2007 16:15:42 -0800
Message-ID: <7vejdite4x.fsf@gitster.siamese.dyndns.org>
References: <20071219225618.GA7378@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Dec 20 01:16:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J595G-0004IQ-5h
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 01:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbXLTAPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 19:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752944AbXLTAPy
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 19:15:54 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58044 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789AbXLTAPx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 19:15:53 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 85733894A;
	Wed, 19 Dec 2007 19:15:48 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 018058949;
	Wed, 19 Dec 2007 19:15:44 -0500 (EST)
In-Reply-To: <20071219225618.GA7378@genesis.frugalware.org> (Miklos Vajna's
	message of "Wed, 19 Dec 2007 23:56:18 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68961>

Miklos Vajna <vmiklos@frugalware.org> writes:

> "every day". of course it may be only me, that's why i ask. here are the
> commands i rarely use and are in everyday.txt:
>
> - git-prune and git-repack: usually i use git-gc only. maybe prune and
>   repack could be removed from everyday.txt?
>
> - git-show-branch: what about mentioning gitk instead? i think it's much
>   more used - compared to git-show-branch
>
> what do you think about this? maybe i'm wrong, but if i'm right, then i
> would provide a patch to update everyday.txt according to these
> suggestions.

I think you would probably get unanimous yes for the former (I don't use
gc myself but "repack -a -d" or "repack -a -d -f" regularly, though ---
I am old fashioned and do not mind being counted as an oddball).

For the latter it all depends on whether you are in windowed environment
(I usually don't).
