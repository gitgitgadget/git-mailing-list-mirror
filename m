From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git.txt: update description of the configuration
 mechanism
Date: Thu, 14 Feb 2013 08:52:53 -0800
Message-ID: <7vhale3kii.fsf@alter.siamese.dyndns.org>
References: <1360856214-934-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Feb 14 17:53:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U623k-0002pv-OS
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 17:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757364Ab3BNQw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 11:52:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62932 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754085Ab3BNQw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2013 11:52:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A97B8B6A7;
	Thu, 14 Feb 2013 11:52:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CRMWfdMjKId8LoYFcZSfcnpB/64=; b=pHLal/
	G10VlQ+o5HrNZurTzrjtN9MGyMYXEYDKePRVRftNJ908YO2Vrd/Ymic3Y8rRiGop
	aW5daFICKBtEBHtaJEcx1GycR93dsNQox4F8TFTm6Fc9fpE9v4AoYu+R8aONC74q
	jOIhR7MraLpsVL1LAXNtogUHxRHMSEMal0u44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xZKGhg+p7MYQHEVhrvVASjZNw7UtcZSX
	dsg1BVtjJRr2hRyHv716xerZhq1N2NVq/abrY75Uj6uux0Wu/ch/wPp3SWGSBXrU
	2yGGaqeadWJUKX3zKOgoKk3lZzZwOdXRRx7pm39NXG4RVfUkuu+lyyhb710oUuMI
	9qys1LX6ud0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BA2FB6A6;
	Thu, 14 Feb 2013 11:52:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07704B69D; Thu, 14 Feb 2013
 11:52:54 -0500 (EST)
In-Reply-To: <1360856214-934-1-git-send-email-Matthieu.Moy@imag.fr> (Matthieu
 Moy's message of "Thu, 14 Feb 2013 16:36:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA5B04A2-76C6-11E2-9213-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216321>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The old Git version where it appeared is not useful only to historians,
> not to normal users.

That statement cannot be generally true, unless the "old" is really
old and no longer relevant but 0.99.9 is sufficiently old so the
value of the part of the message you removed that warns users with
ancient versions that they may not be able to use the feature
without upgrading has diminished.

> +Git uses a simple text file format modeled after `.ini` format
> +familiar to some people to store its configuration. The `.git/config`
> +file is used to hold per-repository configuration options, and
> +per-user configuration can be stored in a `~/.gitconfig` file.
> +Here is an example:
>  
>  ------------
>  #
> @@ -559,7 +560,7 @@ people.  Here is an example:
>  
>  Various commands read from the configuration file and adjust
>  their operation accordingly.  See linkgit:git-config[1] for a
> -list.
> +list and more details about the configuration mechanism.

Both look sensible.
