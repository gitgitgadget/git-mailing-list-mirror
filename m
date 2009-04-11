From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC 5/6] send-email: Cleanup the usage text a bit
Date: Sat, 11 Apr 2009 12:22:44 -0700
Message-ID: <7veivzf117.fsf@gitster.siamese.dyndns.org>
References: <1239139522-24118-1-git-send-email-mfwitten@gmail.com>
 <1239139522-24118-2-git-send-email-mfwitten@gmail.com>
 <1239139522-24118-3-git-send-email-mfwitten@gmail.com>
 <1239139522-24118-4-git-send-email-mfwitten@gmail.com>
 <1239139522-24118-5-git-send-email-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 11 21:25:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsipD-0004sO-Qq
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 21:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758884AbZDKTWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 15:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758870AbZDKTWu
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 15:22:50 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40153 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758864AbZDKTWu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 15:22:50 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id F3431EE8E;
	Sat, 11 Apr 2009 15:22:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 676A2EE8D; Sat,
 11 Apr 2009 15:22:46 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 24C77EFC-26CE-11DE-A7C7-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116324>

Michael Witten <mfwitten@gmail.com> writes:

> All lines should be < 80 characters.
>
> Signed-off-by: Michael Witten <mfwitten@gmail.com>
> ---
>  git-send-email.perl |   16 +++++++++++-----
>  1 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 481bf36..c3e3598 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -42,6 +42,9 @@ package main;
>  
>  
>  sub usage {
> +
> +	# All printed lines should be less than 80 characters.
> +

Perhaps a good idea.  It would have been nicer if this were early in the
series.
