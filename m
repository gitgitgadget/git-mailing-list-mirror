From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC3 03/13] Docs: send-email: Remove superfluous
 information in CONFIGURATION
Date: Mon, 13 Apr 2009 13:45:09 -0700
Message-ID: <7vljq4e10q.fsf@gitster.siamese.dyndns.org>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-2-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-3-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-4-git-send-email-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 22:46:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtT3I-00075k-67
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 22:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062AbZDMUpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 16:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbZDMUpQ
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 16:45:16 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43736 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753062AbZDMUpO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 16:45:14 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 568A4EC15;
	Mon, 13 Apr 2009 16:45:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BA39FEC14; Mon,
 13 Apr 2009 16:45:10 -0400 (EDT)
In-Reply-To: <1239647037-15381-4-git-send-email-mfwitten@gmail.com> (Michael
 Witten's message of "Mon, 13 Apr 2009 13:23:47 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FCAC146A-286B-11DE-9D60-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116483>

I
Michael Witten <mfwitten@gmail.com> writes:

> n particular, sendemail.confirm was removed, because it's already
> described along with its corresponding option.
>
> Signed-off-by: Michael Witten <mfwitten@gmail.com>
> ---
>  Documentation/git-send-email.txt |    6 ------
>  1 files changed, 0 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 7b87d6e..b58b433 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -271,12 +271,6 @@ sendemail.multiedit::
>  	summary when '--compose' is used). If false, files will be edited one
>  	after the other, spawning a new editor each time.
>  
> -sendemail.confirm::
> -	Sets the default for whether to confirm before sending. Must be
> -	one of 'always', 'never', 'cc', 'compose', or 'auto'. See '--confirm'
> -	in the previous section for the meaning of these values.

I am not sure if this is a good idea.  It may look "superfluous" for
people who read the manual cover-to-cover.  However, a new person whose
mentor allowed her to peek into his configuration to learn tricks from may
find sendemail.confirm and would try to find an entry in the manual.  The
change in this patch will make it inconvenient to go from variable to
description.
