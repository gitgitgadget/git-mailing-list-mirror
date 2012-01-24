From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] t0061: Fix incorrect indentation
Date: Tue, 24 Jan 2012 14:39:47 -0800
Message-ID: <7v8vkw3eto.fsf@alter.siamese.dyndns.org>
References: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
 <1327444346-6243-2-git-send-email-fransklaver@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 24 23:39:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rpp1u-0000dY-NE
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 23:39:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173Ab2AXWju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 17:39:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36734 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751870Ab2AXWjt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 17:39:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20012747C;
	Tue, 24 Jan 2012 17:39:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BQEfDsK1fdecbk1I5gJNCnBkPgU=; b=nImDos
	DyGeac9W6F5eAtVHoVR/imPYSw4SpRYk5rxptYm/1OOwadPFKMFkyBt1I6SZJmFW
	qKIbayBUPMPm9LRe7ybtmJRPjloRlidR6V/zq+S/zfmCJNBNWMgTl/ViBgUbEeGh
	8Hq6WkheWnpskgE/Obit6cmBysE9VsP+unSY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jQdnUjodMBujw5NeHyqZ4wiphVNhiW++
	JtDUI8uHOxpQOPYiRg1HnpHQ4+mvV+Dx5rklGncga6nNvqn0co7RecGMBuCYPuse
	m1L9pSeFKj7Lrh+BEkjwgybuQl8dODaR0KEMVkIGa0/TPaCqJUz7GDBai6GySnpM
	A7vzl2pDB8g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17BE4747B;
	Tue, 24 Jan 2012 17:39:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7542D7479; Tue, 24 Jan 2012
 17:39:48 -0500 (EST)
In-Reply-To: <1327444346-6243-2-git-send-email-fransklaver@gmail.com> (Frans
 Klaver's message of "Tue, 24 Jan 2012 23:32:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 52464922-46DC-11E1-A2F3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189082>

Frans Klaver <fransklaver@gmail.com> writes:

> The hello.sh script started with <tab>#!, which is not considered a
> correct hash-bang line.

Isn't that exactly the reason why we start the here text with "<<-EOF",
not the usual "<<EOF"?

> required for this specific test.
>
> Signed-off-by: Frans Klaver <fransklaver@gmail.com>
> ---
>  t/t0061-run-command.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
> index 8d4938f..95e89bc 100755
> --- a/t/t0061-run-command.sh
> +++ b/t/t0061-run-command.sh
> @@ -8,8 +8,8 @@ test_description='Test run command'
>  . ./test-lib.sh
>  
>  cat >hello-script <<-EOF
> -	#!$SHELL_PATH
> -	cat hello-script
> +#!$SHELL_PATH
> +cat hello-script
>  EOF
>  >empty
