From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] misc-sh: fix up whitespace in some other .sh files.
Date: Fri, 05 Aug 2011 10:26:32 -0700
Message-ID: <7vmxfn3h2v.fsf@alter.siamese.dyndns.org>
References: <1312551089-3753-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 05 19:26:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpOAS-0003fb-Pj
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 19:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966Ab1HER0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Aug 2011 13:26:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34940 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751405Ab1HER0e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 13:26:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA2AB305C;
	Fri,  5 Aug 2011 13:26:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8AOpVg4keJCGu5y3CcI7O0qQC8k=; b=AB2N7k
	xoO6FR0x+lRhJgT4+Zu4RZAdS45OmFkjiZMOlz92Z4QYB9h5rh8ZNo0pEucAycpY
	C8zo+as4pmotDrnZAJdWxa0u5mXQDfrjllb/8a4kV+nrNcRDxEeUufCRkrAtA1Sl
	QlyKXx7rn5e6ahasAkmppV3l9VKMP+ul197Yk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vJoZRLM09NUd8XOnbToD5wP7AssdZvUU
	uWb5kB4h7+9DEsnS8/vg1OZykJ8PybNAvR11ueLDeAeZzyiBki7jnL1RYi4B/i/1
	e0ufQ98Wnfz2hWcZs1XnwSBnv45ZFnV+DhvYyAnI8vXTn/FfTyjOiaZpMH8MSVkg
	jUasMPTXYFc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0DE9305B;
	Fri,  5 Aug 2011 13:26:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 735FA305A; Fri,  5 Aug 2011
 13:26:33 -0400 (EDT)
In-Reply-To: <1312551089-3753-1-git-send-email-jon.seymour@gmail.com> (Jon
 Seymour's message of "Fri, 5 Aug 2011 23:31:29 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 108695C2-BF88-11E0-99DE-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178805>

Jon Seymour <jon.seymour@gmail.com> writes:

> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 962a93b..0d399aa 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -98,11 +98,11 @@ set_ident () {
>  }
>  
>  USAGE="[--env-filter <command>] [--tree-filter <command>]
> -            [--index-filter <command>] [--parent-filter <command>]
> -            [--msg-filter <command>] [--commit-filter <command>]
> -            [--tag-name-filter <command>] [--subdirectory-filter <directory>]
> -            [--original <namespace>] [-d <directory>] [-f | --force]
> -            [<rev-list options>...]"
> +	    [--index-filter <command>] [--parent-filter <command>]
> +	    [--msg-filter <command>] [--commit-filter <command>]
> +	    [--tag-name-filter <command>] [--subdirectory-filter <directory>]
> +	    [--original <namespace>] [-d <directory>] [-f | --force]
> +	    [<rev-list options>...]"
>  
>  OPTIONS_SPEC=
>  . git-sh-setup

Everything other than this hunk is unquestionably fine. I think this one
also is Ok but I wonder where the "Indented by 12 columns" comes
from. "Usage: git filter-branch " that is prefixed to the first line is 25
columns long, so the "[--index-filter ..." on the second line would not
align with "[--env-filter ..." on the first line to begin with.

And I do not think they need to align --- the point is if the second and
subsequent lines do not aim to align with anything on the first line, it
is just fine to indent them with a single HT, I think.
