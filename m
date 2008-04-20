From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: remove use of dashed git commands
Date: Sun, 20 Apr 2008 10:51:24 -0700
Message-ID: <7vskxgbejn.fsf@gitster.siamese.dyndns.org>
References: <1208712525-1747-1-git-send-email-dpmcgee@gmail.com>
 <alpine.DEB.1.00.0804201841570.5084@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan McGee <dpmcgee@gmail.com>, spearce@spearce.org,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Apr 20 19:52:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JndiH-0000sl-1l
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 19:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754958AbYDTRvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 13:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754943AbYDTRvn
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 13:51:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35164 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754909AbYDTRvm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 13:51:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CEF29674B;
	Sun, 20 Apr 2008 13:51:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 072D46746; Sun, 20 Apr 2008 13:51:32 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0804201841570.5084@eeepc-johanness> (Johannes
 Schindelin's message of "Sun, 20 Apr 2008 18:43:37 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79971>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Sun, 20 Apr 2008, Dan McGee wrote:
>
>> [no commit message]
>
> I would like to deprecate dashed form _officially_ first (as in 
> ReleaseNotes), before doing something that could lead to quite some 
> surprised users.

I'd share your distaste against an empty log message to justify the
changes, but I do not see where those "quite some surprised users" would
come from.

At least people know "git foo" form is and has been supported, so if
somebody changes "git-ls-files" to "git ls-files", nobody would go "gee, I
did not know I can write it without dash" these days...
