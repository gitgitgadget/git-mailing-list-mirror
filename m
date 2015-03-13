From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git prompt: Use toplevel to find untracked files.
Date: Thu, 12 Mar 2015 23:16:24 -0700
Message-ID: <xmqqmw3hzakn.fsf@gitster.dls.corp.google.com>
References: <20150313021910.11996.54041@catuvm>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Cody A Taylor <cody.taylor@maternityneighborhood.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 07:16:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWItc-0007I7-G8
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 07:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbbCMGQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 02:16:28 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57110 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751123AbbCMGQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2015 02:16:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 97CDB3A1E5;
	Fri, 13 Mar 2015 02:16:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3fhB/zdRpJw6E8dddwWLsMR4Vk8=; b=tEOl/s
	3CvpuOgfJUUETgLUtFeQfowet470sAQza5i3jMX3w+rPzBawxW/iBMzuozavRREh
	yqQEvHYKIrlybkZHFju51CfCcSg7NLF8OyhYAT6Cr5z1MeabCOgBAuwHZIWlq7Rn
	S0Yw5d1mTpASft6kTM6G6hPOTNaA8TQw8EyXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MNwGy7Yy+Nza4nVqQu11OIvc5dP2DmdD
	qpvO9Ok7CGIF40GckZx2ns13w+JzTznLOkYINpbdBcx6SUA3wT9F+FjJJsSEO/pW
	Mc53PArM39HdWBFyBprD8c4BagYyq6uRduRQeIPJcBCUL7PpsadLwpCDk3kOaN3+
	0XF4uzN6Ttw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F8993A1E4;
	Fri, 13 Mar 2015 02:16:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1275E3A1E3;
	Fri, 13 Mar 2015 02:16:26 -0400 (EDT)
In-Reply-To: <20150313021910.11996.54041@catuvm> (Cody A. Taylor's message of
	"Thu, 12 Mar 2015 19:24:50 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7AACED20-C948-11E4-9714-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265403>

Cody A Taylor <cody.taylor@maternityneighborhood.com> writes:

> From c861d5cb401110ce7d86b76c1eaa8e89e80f484e Mon Sep 17 00:00:00 2001
> From: Cody A Taylor <codemister99@yahoo.com>
> Date: Thu, 12 Mar 2015 20:36:44 -0400
> Subject: [PATCH] git prompt: Use toplevel to find untracked files.

All of the above four lines are unwanted in the e-mail body.

 * The first line is a separating line to make format-patch output
   look like a mbox file, and does not even belong to this patch.

 * From: line, when you are not relaying somebody else's patch,
   should not be necessary, as long as you set up your MUA correctly
   so that the e-mail shows a correct From: in its header.

 * Date: is the same; unless you are relaying somebody else's patch,
   in which case you might want to preserve the author timestamp,
   the first time _we_ the recipients see your patch matters more,
   which should be available from the e-mail header.

 * Subject: should be in the e-mail header.  Sometimes when sending
   a patch to an ongoing discussion that has its own subject, it is
   handy to be able to override the title with in-body Subject:, but
   this patch submission is not such a case.  The subjects are the
   same in the fourth line in the body (which should be dropped) and
   in the header anyway in this message, so please edit it out.

In short

 (1) If you cannot convince your mailer to show your @yahoo.com
     address on the e-mail header From: line, then having the
     in-body From: line above (i.e. the second line) is OK as a
     workaround.  We however would prefer if you didn't.

 (2) Edit the other three lines out.

> The __git_ps1() prompt function would not show an untracked
> state when the current working directory was not a parent of
> the untracked file.

Good find, and nicely explained.  I wonder if we can add a test
or two to t9903-bash-prompt.sh?

The patch itself makes sense.  Thanks.

> Signed-off-by: Cody A Taylor <codemister99@yahoo.com>
> ---
>  contrib/completion/git-prompt.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 214e859f99e7..f18aedc73be9 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -487,7 +487,7 @@ __git_ps1 ()
>  
>  		if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ] &&
>  		   [ "$(git config --bool bash.showUntrackedFiles)" != "false" ] &&
> -		   git ls-files --others --exclude-standard --error-unmatch -- '*' >/dev/null 2>/dev/null
> +		   git ls-files --others --exclude-standard --error-unmatch -- ':/*' >/dev/null 2>/dev/null
>  		then
>  			u="%${ZSH_VERSION+%}"
>  		fi
