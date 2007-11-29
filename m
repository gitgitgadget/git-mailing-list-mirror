From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvsserver runs hooks/post-receive
Date: Wed, 28 Nov 2007 16:24:31 -0800
Message-ID: <7v3aup291c.fsf@gitster.siamese.dyndns.org>
References: <1195809174-28142-1-git-send-email-mfwitten@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@mit.edu>
X-From: git-owner@vger.kernel.org Thu Nov 29 01:24:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxXD7-0005nV-BN
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 01:24:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757141AbXK2AYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 19:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753061AbXK2AYi
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 19:24:38 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:57778 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbXK2AYh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 19:24:37 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8F2D82F0;
	Wed, 28 Nov 2007 19:24:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 262149ADBD;
	Wed, 28 Nov 2007 19:24:56 -0500 (EST)
In-Reply-To: <1195809174-28142-1-git-send-email-mfwitten@mit.edu> (Michael
	Witten's message of "Fri, 23 Nov 2007 04:12:54 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66478>

Michael Witten <mfwitten@mit.edu> writes:

> git-cvsserver just did the following:
>     (1) run hooks/update
>     (2) commit if hooks/update passed
>
> This commit simply adds:
>     (3) run hooks/post-receive
>
> Also, there are a few grammar cleanups and
> consistency improvements.

I gave only a very cursory look; looks Ok to me.  This makes me wonder
if post-update wants to run as well.

What do other people who run git-cvsserver think?
