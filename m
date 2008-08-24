From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: enable SNPRINTF_RETURNS_BOGUS for HP-UX
Date: Sat, 23 Aug 2008 18:00:04 -0700
Message-ID: <7vabf3w7l7.fsf@gitster.siamese.dyndns.org>
References: <1219529275-8194-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Schiele <rschiele@gmail.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Aug 24 03:01:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KX3yn-0003WY-OJ
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 03:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604AbYHXBAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 21:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752560AbYHXBAM
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 21:00:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57592 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbYHXBAK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 21:00:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 99F936B933;
	Sat, 23 Aug 2008 21:00:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1C2746B92F; Sat, 23 Aug 2008 21:00:05 -0400 (EDT)
In-Reply-To: <1219529275-8194-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Sun, 24 Aug 2008 00:07:55 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FFB68088-7177-11DD-B1FD-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93507>

Miklos Vajna <vmiklos@frugalware.org> writes:

> In 81cc66a, customization has been added to Makefile for supporting
> HP-UX, but git commit is still problematic. This should fix the issue.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>

Is this missing "Tested-by: Robert"?  I do not mind adding it myself --
just checking.
