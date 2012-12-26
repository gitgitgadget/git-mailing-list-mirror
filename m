From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-prompt.sh vs leading white space in
 __git_ps1()::printf_format
Date: Tue, 25 Dec 2012 23:47:53 -0800
Message-ID: <7vvcbpp846.fsf@alter.siamese.dyndns.org>
References: <CAA01Cso1E4EC4W667FEU_af2=uGOfPuaWEB3y+zPCpB+bPzoaA@mail.gmail.com>
 <20121128132033.GA10082@xs4all.nl>
 <CAA01CspHAHN7se2oJ2WgcmpuRfoa+9Sx9sUvaPEmQ-Y+kDwHhA@mail.gmail.com>
 <50B66F41.1030305@xs4all.nl> <7vlidltpyj.fsf@alter.siamese.dyndns.org>
 <50C7B811.7030006@xs4all.nl> <7v7goo6vi3.fsf@alter.siamese.dyndns.org>
 <7vy5h45e7b.fsf@alter.siamese.dyndns.org> <20121212085507.GA32187@xs4all.nl>
 <7vlid35fe4.fsf@alter.siamese.dyndns.org> <50C8E857.5080000@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	git@vger.kernel.org
To: Simon Oosthoek <s.oosthoek@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Dec 26 08:48:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tnlix-0006e0-K6
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 08:48:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098Ab2LZHr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 02:47:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58028 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751972Ab2LZHr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 02:47:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 042EC95F2;
	Wed, 26 Dec 2012 02:47:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qsVwHm/hGydCPdNXM0l/YtqB6Cw=; b=xp9I0b
	YDRSGd2btdA2ESwP8N+UVSPxixGsb4rFMMNUgKBtfKlOevezowzgAmMQ88td6TxU
	wzuEgNOoU7XhfPPogyL9qSDtayOmURqITwF5x4yeAIwb0E1T+kSUtmRLkWAN/K0J
	GrOhAYot1713Svt+fYqV1PtaZT0NK0p5FqKBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QA0aWzmHOaoov0zLUNVikrBlwjE7CvLh
	SORJMq6ftr3V2kfbz0fHqwAY5GZrOssd+OzlLnSzdWJXmGffYcQPCm8rmWpfQPOp
	lEchhdyL4IGjNvdpp5aeWtUsb0Gqf8q1x+OvH15rQ+rbVBOwx5dgtrQ95CfLGtka
	7cJIHnBhkbU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6EBB95F1;
	Wed, 26 Dec 2012 02:47:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 17F5C95F0; Wed, 26 Dec 2012
 02:47:56 -0500 (EST)
In-Reply-To: <50C8E857.5080000@xs4all.nl> (Simon Oosthoek's message of "Wed,
 12 Dec 2012 21:25:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F9E163A-4F30-11E2-A6A7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212129>

Simon Oosthoek <s.oosthoek@xs4all.nl> writes:

> On 12/12/12 18:50, Junio C Hamano wrote:
>> Simon Oosthoek <s.oosthoek@xs4all.nl> writes:
>> 
>>> This removes most of the ambiguities :-)
>>> Ack from me!
>> 
>> OK, as this is a low-impact finishing touch for a new feature, I'll
>> fast-track this to 'master' before the final release.
>> 
>
> Ok, wonderful!
> BTW, I tried the thing I mentioned and it was safe to do:
> PS1='blabla$(__git_ps1 x y)blabla'
> will not eat your prompt, although I'd recommend putting something
> useful instead of blabla ;-)

Actually, I deeply regret merging this to 'master'.  The original
"as a command substitution in PS1" mode, you could add anything
around the status string, so I could do:

	PS1=': \h \W$(__git_ps1 "/%s"); '

to get something like:

	: hostname dirname/<STATUS>; <CURSOR HERE>

In the new PROMPT_COMMAND mode, there is always parentheses around
the status string (and an SP before the parenthesees) that the user
cannot get rid of.

This is not a usability regression per-se (if you do not like the
extra parentheses, you do not have to use the colored mode), but is
something that will make me never use the mode.

Can we make it take an optional third parameter so that we could say

	PROMPT_COMMAND='__git_ps1 ": \h \W" "; " "/%s"'

to do the same as what the command substitution mode would have
given for

	PS1=': \h \W$(__git_ps1 "/%s"); '

perhaps?

Totally untested, but perhaps along this line.

 contrib/completion/git-prompt.sh | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 9b074e1..b2579f4 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -236,9 +236,10 @@ __git_ps1 ()
 	local printf_format=' (%s)'
 
 	case "$#" in
-		2)	pcmode=yes
+		2|3)	pcmode=yes
 			ps1pc_start="$1"
 			ps1pc_end="$2"
+			printf_format="${3:-$printf_format}"
 		;;
 		0|1)	printf_format="${1:-$printf_format}"
 		;;
@@ -339,6 +340,7 @@ __git_ps1 ()
 
 		local f="$w$i$s$u"
 		if [ $pcmode = yes ]; then
+			local ps1=
 			if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
 				local c_red='\e[31m'
 				local c_green='\e[32m'
@@ -356,29 +358,31 @@ __git_ps1 ()
 					branch_color="$bad_color"
 				fi
 
-				# Setting PS1 directly with \[ and \] around colors
+				# Setting ps1 directly with \[ and \] around colors
 				# is necessary to prevent wrapping issues!
-				PS1="$ps1pc_start (\[$branch_color\]$branchstring\[$c_clear\]"
+				ps1="\[$branch_color\]$branchstring\[$c_clear\]"
 
 				if [ -n "$w$i$s$u$r$p" ]; then
-					PS1="$PS1 "
+					ps1="$ps1 "					
 				fi
 				if [ "$w" = "*" ]; then
-					PS1="$PS1\[$bad_color\]$w"
+					ps1="$ps1\[$bad_color\]$w"
 				fi
 				if [ -n "$i" ]; then
-					PS1="$PS1\[$ok_color\]$i"
+					ps1="$ps1\[$ok_color\]$i"
 				fi
 				if [ -n "$s" ]; then
-					PS1="$PS1\[$flags_color\]$s"
+					ps1="$ps1\[$flags_color\]$s"
 				fi
 				if [ -n "$u" ]; then
-					PS1="$PS1\[$bad_color\]$u"
+					ps1="$ps1\[$bad_color\]$u"
 				fi
-				PS1="$PS1\[$c_clear\]$r$p)$ps1pc_end"
+				ps1="$ps1\[$c_clear\]$r$p"
 			else
-				PS1="$ps1pc_start ($c${b##refs/heads/}${f:+ $f}$r$p)$ps1pc_end"
+				ps1="$c${b##refs/heads/}${f:+ $f}$r$p"
 			fi
+			ps1=$(printf -- "$printf_format" "$ps1")
+			PS1="$ps1pc_start$ps1$ps1pc_end"
 		else
 			# NO color option unless in PROMPT_COMMAND mode
 			printf -- "$printf_format" "$c${b##refs/heads/}${f:+ $f}$r$p"
