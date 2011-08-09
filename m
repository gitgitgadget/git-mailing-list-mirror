From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am: Document new --exclude=<file> option
Date: Tue, 09 Aug 2011 10:20:23 -0700
Message-ID: <7vy5z2sdrc.fsf@alter.siamese.dyndns.org>
References: <1312903268-19994-1-git-send-email-max@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: maximilian attems <max@stro.at>
X-From: git-owner@vger.kernel.org Tue Aug 09 19:20:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qqpyi-00035l-I2
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 19:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373Ab1HIRU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Aug 2011 13:20:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50969 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181Ab1HIRU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2011 13:20:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 552FA4968;
	Tue,  9 Aug 2011 13:20:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NGN4ZyPjNV2U7mJZrmeMyUaIaEY=; b=JEnAmN
	etk40qed4qDIaOEc5kBYTQYuqLdii/pZ6UHl0MpgQOURqFMKyXipCdaXw5WYvRDc
	shmLD77W5VZY/o31FOdmSHc1FwEOpkldVOtaVRNlc5/nj8Wuq8EzOPciUcL7JeXW
	wAMxLtxbAkWnfhW5b2rbZw/gdUCBoYn1kj3YA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E5muduELurFMytI4/x0AzrU2fTcmdfNz
	FrL+qz4qQvoqjKk5YymOKg2Di86fXx0Pml+w1a+I3TXFnvPrOqjNDKUUsOBIYBee
	b+d8dSulW3XyaBIy2MpOjc42VHfu0u1/j+nMTtA7KKSnEKmxkSbptkgBCAj5b9he
	Ah3kERCLS6Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B63B4967;
	Tue,  9 Aug 2011 13:20:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D375D4966; Tue,  9 Aug 2011
 13:20:24 -0400 (EDT)
In-Reply-To: <1312903268-19994-1-git-send-email-max@stro.at> (maximilian
 attems's message of "Tue, 9 Aug 2011 17:21:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DE78AE86-C2AB-11E0-A78B-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179034>

maximilian attems <max@stro.at> writes:

> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index 6b1b5af..62c8e3c 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -13,7 +13,8 @@ SYNOPSIS
>  	 [--3way] [--interactive] [--committer-date-is-author-date]
>  	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
>  	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
> -	 [--reject] [-q | --quiet] [--scissors | --no-scissors]
> +	 [--exclude=<file>] [--reject] [-q | --quiet]
> +	 [--scissors | --no-scissors]

Please do not say "<file>" here (and below). git-apply.txt documents this
as <path> and that is what the value of this parameter is.
