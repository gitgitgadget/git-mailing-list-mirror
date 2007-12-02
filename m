From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Corrupted (?) commit 6e6db85e confusing gitk
Date: Sun, 02 Dec 2007 10:53:33 -0800
Message-ID: <7vir3hx70y.fsf@gitster.siamese.dyndns.org>
References: <5F1A20CC-7427-4E7A-AB95-E89C9FA17951@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Dec 02 19:54:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iytx6-0006VO-7U
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 19:54:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605AbXLBSxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 13:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752276AbXLBSxm
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 13:53:42 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40290 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbXLBSxl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 13:53:41 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 2450A2F9;
	Sun,  2 Dec 2007 13:54:00 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 827C69C218;
	Sun,  2 Dec 2007 13:53:57 -0500 (EST)
In-Reply-To: <5F1A20CC-7427-4E7A-AB95-E89C9FA17951@zib.de> (Steffen Prohaska's
	message of "Sun, 2 Dec 2007 17:06:07 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66808>

Steffen Prohaska <prohaska@zib.de> writes:

> I'd like to conclude with some questions:
>  - Is this commit corrupted?
>  - How was the commit created?
>  - Should "git fsck" detect such corruption?
>  - Should gitk more gracefully handle corrupted commits?

Yeah, I was wondering what that commit that records the change older
than git or myself come to life ;-)

I did rewrite the commit a few times, and it was some interaction
between the built-in commit series, git-rebase -i and git-am, but I do
not have the details, sorry.
