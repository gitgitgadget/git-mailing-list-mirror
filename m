From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] INSTALL: Update description of our SHA-1 code
Date: Tue, 08 Sep 2009 13:21:01 -0700
Message-ID: <7vab15yyqa.fsf@alter.siamese.dyndns.org>
References: <1252425313-69793-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 22:21:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml7Bk-0000aM-Vt
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 22:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122AbZIHUVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 16:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbZIHUVG
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 16:21:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58804 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbZIHUVF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 16:21:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 401422B4F2;
	Tue,  8 Sep 2009 16:21:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=jfm/w2r/cJJcaTD57eVhlxO9NYc=; b=XRMbE3M9Bwuaj/c5kD7VDpw
	LRJNr8aobSf/Ha9IjA3Aq8VPzi4lhZ1GX2zhjf9ZYvbaDAfVc/95aPX1SFxtUuOk
	l7YYDEMvksg4s5Cr2kNmVgari9jG/rjS/+GUaYw/sL2GNFtPHGTWGiJRVNH1dZmF
	vHd3WLLl31OQnFFOcSfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=um7dGDSSOUsqfARjcBa6+Clkp2w/jFWzxxgpnzBoIa+VCmt+O
	bGvgyxKLxHU79gn2z96VFkmmhX9b6aKQp8mjvtMQd5qFPdlwvucDgHweQcZDoHwH
	dedrpLs8n2iQcZBUt6tApIEyHIUz4aO/8FDtBlFrJSfylWNX+zslBXhBbo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 220F22B4F1;
	Tue,  8 Sep 2009 16:21:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 79EAD2B4ED; Tue,  8 Sep
 2009 16:21:03 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 23313E04-9CB5-11DE-9D05-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128030>

Brian Gernhardt <brian@gernhardtsoftware.com> writes:

> We haven't had Mozilla's code or an ARM optimized algorithm since
> 30ae47b.  Reword the paragraph to give credit but not authorship to
> Mozilla.

Thanks.

> Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
> ---
>
>  Minor nit I noticed while in the INSTALL file.
>
>  INSTALL |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/INSTALL b/INSTALL
> index ae7f750..4a57e47 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -56,8 +56,8 @@ Issues of note:
>  	  library from here.
>  
>  	  If you don't have openssl, you can use one of the SHA1 libraries
> -	  that come with git (git includes the one from Mozilla, and has
> -	  its own PowerPC and ARM optimized ones too - see the Makefile).
> +	  that come with git (git includes one based on Mozilla's as well
> +	  as a PowerPC optimized one - see the Makefile).

The leading comment in block/sha1.c says "initially based on ... although
none of the original remains."  "one loosely based on" or "one inspired
by" might be a more fair statement, although I do not feel too strongly
about it.

>  
>  	- libcurl library; git-http-fetch and git-fetch use them.  You
>  	  might also want the "curl" executable for debugging purposes.
> -- 
> 1.6.4.2.420.g30ecf
