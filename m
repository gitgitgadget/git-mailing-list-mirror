From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-prompt.sh vs leading white space in
 __git_ps1()::printf_format
Date: Tue, 11 Dec 2012 15:04:36 -0800
Message-ID: <7v7goo6vi3.fsf@alter.siamese.dyndns.org>
References: <CAA01Cso1E4EC4W667FEU_af2=uGOfPuaWEB3y+zPCpB+bPzoaA@mail.gmail.com>
 <20121128132033.GA10082@xs4all.nl>
 <CAA01CspHAHN7se2oJ2WgcmpuRfoa+9Sx9sUvaPEmQ-Y+kDwHhA@mail.gmail.com>
 <50B66F41.1030305@xs4all.nl> <7vlidltpyj.fsf@alter.siamese.dyndns.org>
 <50C7B811.7030006@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	git@vger.kernel.org
To: Simon Oosthoek <s.oosthoek@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Dec 12 00:04:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiYsk-0004m1-HC
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 00:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185Ab2LKXEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 18:04:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48472 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754292Ab2LKXEk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 18:04:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3858AAC84;
	Tue, 11 Dec 2012 18:04:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZKzlVpC/x6qO873S36kJKZFc6ok=; b=qMvg0m
	kyJp1BUevPk+qtNJepZT3bFUEclKL+YtdRf+LW5CqhlBKnuMwrr70yb+7Trzb1Hb
	P/HWqsQ6gDmc2ZHGtvdz4ELt1shbc2JCWXUmBLELrU9qG0u4CkThhov0Y9D2FyWS
	JROzDPzr9HWeOl4zOeid6hazXRzoPJh+giv6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bU18veJjbPktYv2Ll2jJhxw7wGcKiWdd
	shhukqXl62AZfH9irbckUf707ErVzYNdTorBxyuxuvOYBOT+WZjgojcNCWhORqED
	MlPFfi4AGG7/HlrgyEILEWZ6zi84hFOMEXSm0JoG/SwFZdhQZD5YiQhZ6K2Wy7vl
	UX+BBBRxyx8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2591DAC83;
	Tue, 11 Dec 2012 18:04:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4433EAC80; Tue, 11 Dec 2012
 18:04:38 -0500 (EST)
In-Reply-To: <50C7B811.7030006@xs4all.nl> (Simon Oosthoek's message of "Tue,
 11 Dec 2012 23:47:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2346B324-43E7-11E2-9E68-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211315>

Simon Oosthoek <s.oosthoek@xs4all.nl> writes:

> This patch for the documentation doesn't seem to be in rc2 of 1.8.1...

There wasn't any patch, and after sending "something like this" I
forgot about the topic, as usual.

> The current tagged 1.8.1-rc2 doesn't yet have your improvement and after
> trying to explain it, I think it should be improved even more ;-)

I am not sure what "my improvement" you are refering to.  Is it only
about how the usage appears in the comment?

Perhaps like this?  I think the straight-forward one should be
listed as the primary usage, and the confusing one should be an
alternate for advanced users, so 3a/3b have been swapped.

 contrib/completion/git-prompt.sh | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git i/contrib/completion/git-prompt.sh w/contrib/completion/git-prompt.sh
index 00fc099..899eb09 100644
--- i/contrib/completion/git-prompt.sh
+++ w/contrib/completion/git-prompt.sh
@@ -10,14 +10,20 @@
 #    1) Copy this file to somewhere (e.g. ~/.git-prompt.sh).
 #    2) Add the following line to your .bashrc/.zshrc:
 #        source ~/.git-prompt.sh
-#    3a) In ~/.bashrc set PROMPT_COMMAND=__git_ps1
-#        To customize the prompt, provide start/end arguments
-#        PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
-#    3b) Alternatively change your PS1 to call __git_ps1 as
+#    3a) Change your PS1 to call __git_ps1 as
 #        command-substitution:
 #        Bash: PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
 #        ZSH:  PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
-#        the optional argument will be used as format string
+#        the optional argument will be used as format string.
+#    3b) Alternatively, if you are using bash, __git_ps1 can be
+#        used for PROMPT_COMMAND with two parameters, <pre> and
+#        <post>, which are strings you would put in $PS1 before
+#        and after the status string generated by the git-prompt
+#        machinery.  e.g.
+#           PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
+#        will show username, at-sign, host, colon, cwd, then
+#        various status string, followed by dollar and SP, as
+#        your prompt.
 #
 # The argument to __git_ps1 will be displayed only if you are currently
 # in a git repository.  The %s token will be the name of the current
