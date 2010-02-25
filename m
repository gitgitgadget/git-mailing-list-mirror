From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH jh/notes] t3301-notes: insert a shbang line in
 ./fake_editor.sh
Date: Thu, 25 Feb 2010 08:42:23 -0800
Message-ID: <7v3a0pcln4.fsf@alter.siamese.dyndns.org>
References: <4B865376.9030209@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Feb 25 17:42:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkgnT-00089d-5I
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 17:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932928Ab0BYQmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 11:42:38 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38104 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932899Ab0BYQmh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 11:42:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EEF59CB5D;
	Thu, 25 Feb 2010 11:42:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x5jxTNo17MtpzXG4ce9DLaGQb+U=; b=m9QF4X
	bL87LqNr0uDRo4+GvXxJoHEEn9X7WbVd2E412P8vHNtivTBmK90sJleKTOoujGlz
	u4tNC8ysknJ9CD201zwyljdKA7UJHqC7YUQh4bOQzz8PqvhssMVio2X6tn0p6zHB
	Jh2J3jfuGJDY6jSDTxFW/eHn9er5HI9EjUSLI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=StbvbcilRmSki27zJ9frGC1jcxfgipKe
	uMq9DOuFME0t/4ct1iIfDyQt8CxibkhJCdS+3/WRu7/mHLoWGHCkkMlP3nCSXsjI
	fwbXlJ8yJo2iwIK2aj2qSnpDgdyO6d1hirWnGwKhcZB+HyJ9TtyxRaukXXnb4bbO
	3AORFTHvWZs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DF1F89CB5C;
	Thu, 25 Feb 2010 11:42:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FE679CB5B; Thu, 25 Feb
 2010 11:42:25 -0500 (EST)
In-Reply-To: <4B865376.9030209@viscovery.net> (Johannes Sixt's message of
 "Thu\, 25 Feb 2010 11\:39\:50 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C388DF40-222C-11DF-AC78-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141054>

Johannes Sixt <j.sixt@viscovery.net> writes:

> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index 90178f9..37b9687 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -8,6 +8,7 @@ test_description='Test commit notes'
>  . ./test-lib.sh
>
>  cat > fake_editor.sh << \EOF
> +#!/bin/sh
>  echo "$MSG" > "$1"
>  echo "$MSG" >& 2
>  EOF

Thanks.

Shouldn't that be "#!$SHELL_PATH", though?
