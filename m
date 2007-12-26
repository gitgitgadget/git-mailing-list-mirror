From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Allow selection of different cleanup modes for commit messages
Date: Wed, 26 Dec 2007 15:54:14 -0800
Message-ID: <7vmyrxm2qh.fsf@gitster.siamese.dyndns.org>
References: <1198382136-15724-1-git-send-email-gitster@pobox.com>
	<1198382136-15724-2-git-send-email-gitster@pobox.com>
	<1198382136-15724-3-git-send-email-gitster@pobox.com>
	<1198382136-15724-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 27 00:54:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J7g5M-0004qs-0W
	for gcvg-git-2@gmane.org; Thu, 27 Dec 2007 00:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbXLZXy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2007 18:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbXLZXy2
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Dec 2007 18:54:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45099 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbXLZXy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2007 18:54:27 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5383A5AA7;
	Wed, 26 Dec 2007 18:54:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E51895AA3;
	Wed, 26 Dec 2007 18:54:21 -0500 (EST)
In-Reply-To: <1198382136-15724-4-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Sat, 22 Dec 2007 19:55:36 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69251>

Junio C Hamano <gitster@pobox.com> writes:

> From: Alex Riesen <raa.lkml@gmail.com>
> Date: Sat, 22 Dec 2007 19:46:24 +0100
>
> Although we traditionally stripped away excess blank lines, trailing
> whitespaces and lines that begin with "#" from the commit log message,
> sometimes the message just has to be the way user wants it.
> ...

Any comments on the cleaned-up series?
