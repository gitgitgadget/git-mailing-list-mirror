From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Temporary directories getting errantly added into trees
Date: Thu, 22 Nov 2007 03:37:26 -0800
Message-ID: <7vhcje5x55.fsf@gitster.siamese.dyndns.org>
References: <4744FCD9.7020102@vilain.net>
	<Pine.LNX.4.64.0711221052280.27959@racer.site>
	<46a038f90711220301o1cbb16b7g79eea541f8ca5e58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Sam Vilain" <sam@vilain.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 12:37:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvANU-0004bP-MJ
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 12:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbXKVLhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 06:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750696AbXKVLhf
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 06:37:35 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:52528 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060AbXKVLhe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 06:37:34 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 2E2422F0;
	Thu, 22 Nov 2007 06:37:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id AF4A5979A1;
	Thu, 22 Nov 2007 06:37:50 -0500 (EST)
In-Reply-To: <46a038f90711220301o1cbb16b7g79eea541f8ca5e58@mail.gmail.com>
	(Martin Langhoff's message of "Fri, 23 Nov 2007 00:01:46 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65804>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> when it comes to .dotest/patch, it must be reasonably accessible. When
> git-am refuses to apply a patch, and I am resolving things by hand, I
> need it pretty handy. I also sometimes edit .dotest/msg-clean.

Any serious "am" user shares the habit to edit .dotest/patch and
it would be VERY painful to change this, I suspect.

I do not mind shipping .dotest in the sample templates/info--exclude
file, though.
