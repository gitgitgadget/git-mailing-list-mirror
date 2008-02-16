From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix line numbers emitted by "git diff --check"
Date: Fri, 15 Feb 2008 23:04:40 -0800
Message-ID: <7vk5l5crg7.fsf@gitster.siamese.dyndns.org>
References: <1203118423-32642-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 08:05:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQH7G-0007OZ-QU
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 08:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbYBPHEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 02:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbYBPHEs
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 02:04:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61523 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbYBPHEs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 02:04:48 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D7C52F93;
	Sat, 16 Feb 2008 02:04:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 48DCC2F91; Sat, 16 Feb 2008 02:04:42 -0500 (EST)
In-Reply-To: <1203118423-32642-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Fri, 15 Feb 2008 18:33:43 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74021>

Jay Soffian <jaysoffian@gmail.com> writes:

> Fixes a problem where git diff --check was emitting incorrect lines
> numbers. Adds a test to verify the fix.
>
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>

Ahh, our mails crossed, and our fixes are equivalent, but yours
has an additional test, which is always good.

Will steal the test part and squash it in (I've already patched
'maint' with the one I sent out), if you do not mind.
