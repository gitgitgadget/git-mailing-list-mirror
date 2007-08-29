From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Explain in --pid-file that using --inetd implies it automatically
Date: Wed, 29 Aug 2007 03:23:54 -0700
Message-ID: <7v7iner64l.fsf@gitster.siamese.dyndns.org>
References: <ejhm3gs6.fsf@cante.net>
	<7vabsasqk2.fsf@gitster.siamese.dyndns.org> <zm0a1vw9.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Wed Aug 29 12:24:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQKiQ-0004S7-Ud
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 12:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbXH2KYA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 06:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756274AbXH2KYA
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 06:24:00 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:49766 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756289AbXH2KX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 06:23:59 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id B2BD112905C;
	Wed, 29 Aug 2007 06:24:17 -0400 (EDT)
In-Reply-To: <zm0a1vw9.fsf@cante.net> (Jari Aalto's message of "Wed, 29 Aug
	2007 13:24:06 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56931>

Jari Aalto <jari.aalto@cante.net> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>>> -	Save the process id in 'file'.
>>> +	Save the process id in 'file'. When `--inetd` is in use, this
>>> +        option is not needed.
>>
>> Is it "is not needed"?  I think you meant to say "is ignored",
>> IOW, no pid file is written.
>
> Corrected
>
>     git repository http://cante.net/~jaalto/git/git
>     Branch: git-daemon.txt+option--pid-file.collapse
>
>  Documentation/git-daemon.txt |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Phuleeeze.  Try to apply what you sent out with "git am" and
watch the resulting commit log message in horrors!

Hint. "Documentation/SubmittingPatches".

Thanks.  I'll do this by hand so no need to resend.

>
> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
> index f902161..861d68f 100644
> --- a/Documentation/git-daemon.txt
> +++ b/Documentation/git-daemon.txt
> @@ -124,7 +124,8 @@ OPTIONS
>         Detach from the shell. Implies --syslog.
>  
>  --pid-file=file::
> -       Save the process id in 'file'.
> +       Save the process id in 'file'. When `--inetd` is in use, this
> +        option is ignored.
>  
>  --user=user, --group=group::
>         Change daemon's uid and gid before entering the service loop.
