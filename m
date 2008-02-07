From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] Retain extra blank lines between the summary and the body
Date: Thu, 07 Feb 2008 01:09:51 -0800
Message-ID: <7vsl05nnds.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802061141320.13593@iabervon.org>
	<7v4pclx1xu.fsf@gitster.siamese.dyndns.org>
	<alpine.LNX.1.00.0802061711231.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Feb 07 10:10:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN2mF-0001xu-G4
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 10:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbYBGJKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 04:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752259AbYBGJKG
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 04:10:06 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42847 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123AbYBGJKD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 04:10:03 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 261773479;
	Thu,  7 Feb 2008 04:10:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8856C3478;
	Thu,  7 Feb 2008 04:09:57 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72913>

Daniel Barkalow <barkalow@iabervon.org> writes:

> When we discussed this ages ago, I think we came to the conclusion that it 
> didn't matter. The code doesn't remove extra blank lines from between body 
> paragraphs, so it's a bit arbitrary to remove them between the first line 
> and the following paragraph. And people tend not to have commit messages 
> with blank lines there (in fact, I think git strips them out on commit).

Ah, then "Stripping only at the beginning is inconsistent and
wrong" would be a better description.  Then that's fine by me in
either case.

Thanks for a reminder.
