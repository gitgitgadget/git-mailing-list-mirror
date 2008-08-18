From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Revert "Windows: Use a customized struct stat that
 also has the st_blocks member."
Date: Mon, 18 Aug 2008 13:44:02 -0700
Message-ID: <7v7iaem4tp.fsf@gitster.siamese.dyndns.org>
References: <273481A4-0BB2-4A58-83AD-604B425DE824@web.de>
 <7vy72w6kiv.fsf@gitster.siamese.dyndns.org>
 <200808182157.16392.johannes.sixt@telecom.at>
 <200808182201.06114.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Andreas =?utf-8?Q?F=C3=A4rber?= <andreas.faerber@web.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Aug 18 22:45:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVBbI-0005YL-OZ
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 22:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246AbYHRUoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 16:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752689AbYHRUoN
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 16:44:13 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38223 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbYHRUoM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 16:44:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7DBD75ED2E;
	Mon, 18 Aug 2008 16:44:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9B7F45ED2D; Mon, 18 Aug 2008 16:44:05 -0400 (EDT)
In-Reply-To: <200808182201.06114.johannes.sixt@telecom.at> (Johannes Sixt's
 message of "Mon, 18 Aug 2008 22:01:06 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 684EA2E4-6D66-11DD-86DB-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92739>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> This reverts commit fc2ded5b08e071beed974117c0148781b1acc94a.
>
> Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
> ---
> And this is the follow-up to revert to the regular struct stat on MinGW.
>
> BTW, do we sign-off reverts?

We not only encourage to sign-off reverts but also to explain why the
change is not necessary anymore.
