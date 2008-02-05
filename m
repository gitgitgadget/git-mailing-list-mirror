From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH-v2 4/4] git-commit: add a prepare-commit-msg hook
Date: Tue, 05 Feb 2008 12:02:20 -0800
Message-ID: <7vwspj9noz.fsf@gitster.siamese.dyndns.org>
References: <1202205704-10024-1-git-send-email-bonzini@gnu.org>
	<1202205704-10024-4-git-send-email-bonzini@gnu.org>
	<alpine.LSU.1.00.0802051500190.8543@racer.site>
	<47A87DDC.5030708@gnu.org>
	<alpine.LSU.1.00.0802051520520.8543@racer.site> <47A88032.107@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 21:04:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMU0b-0006CV-Uc
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 21:03:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759829AbYBEUCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 15:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759824AbYBEUCi
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 15:02:38 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59858 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759756AbYBEUCh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 15:02:37 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FD20640E;
	Tue,  5 Feb 2008 15:02:36 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 616A36408;
	Tue,  5 Feb 2008 15:02:32 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72685>

Paolo Bonzini <bonzini@gnu.org> writes:

>> I might be missing something
>
> No, you are not.
>
>> but should this not be solved by having the prepare-commit-msg exit
>> 0?  I mean, it is conceivable that such a bad error occurs in the
>> hook that the commit should be stopped then and there.
>
> So you say, don't suppress the hook with --no-verify *and* exit if the
> hook returns 1, even if --no-verify is given.  That's fine by me.

Fine by me as well, and I would prefer it that way.
