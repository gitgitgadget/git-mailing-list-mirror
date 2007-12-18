From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clean up documentation that references deprecated 'git peek-remote'.
Date: Mon, 17 Dec 2007 16:11:55 -0800
Message-ID: <7vy7bs50ac.fsf@gitster.siamese.dyndns.org>
References: <1197882503-4296-1-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Dec 18 01:12:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Q4U-0003QA-Fp
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 01:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933793AbXLRAMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 19:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933535AbXLRAMF
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 19:12:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:32903 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933776AbXLRAME (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 19:12:04 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2228D49EF;
	Mon, 17 Dec 2007 19:12:00 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B095249EE;
	Mon, 17 Dec 2007 19:11:57 -0500 (EST)
In-Reply-To: <1197882503-4296-1-git-send-email-johannes.sixt@telecom.at>
	(Johannes Sixt's message of "Mon, 17 Dec 2007 10:08:23 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68668>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> Now that 'git peek-remote' is deprecated and only an alias for
> 'git ls-remote', it should not be referenced from other manual pages.
>
> This also removes the description of the --exec option, which is no
> longer present.

It seems to be supported as a backward compatibility option but not
shown in the short help.  Removal of it from the documentation is
alright nevertheless.

Thanks.
