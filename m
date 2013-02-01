From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] Add a description for 'gitfile' to glossary
Date: Fri, 01 Feb 2013 10:41:56 -0800
Message-ID: <7v4nhvc1vv.fsf@alter.siamese.dyndns.org>
References: <210945773.1090030.1359741840305.JavaMail.ngmail@webmail18.arcor-online.net>
 <7vzjzodfp1.fsf@alter.siamese.dyndns.org>
 <7v38xsjzxg.fsf@alter.siamese.dyndns.org>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <2009548606.632825.1358795980319.JavaMail.ngmail@webmail20.arcor-online.net>
 <CAJDDKr4fnUp_35ni72XJS_NSp4jxbvQPENLnk3AhFv2FBg3DTg@mail.gmail.com>
 <50804391.814945.1358931502165.JavaMail.ngmail@webmail07.arcor-online.net>
 <274664435.1090127.1359742284591.JavaMail.ngmail@webmail18.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davvid@gmail.com
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Fri Feb 01 19:42:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1LZ8-0000mm-5f
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 19:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757094Ab3BASmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 13:42:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48591 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756502Ab3BASl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 13:41:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85170C6B7;
	Fri,  1 Feb 2013 13:41:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=umlxs044NMYA3EJ5+JMYSIAokj0=; b=xRBA0l
	zrDcL2EfeLNjCU7oNP6L5md6oUa6AKQII5E1VkLBaIeOV2fITRKzW6S/tnmHzVs3
	/PiA0XxjoT6qX3q2SlMUK1dbZ6Udral8aZeKbTWWJqRqfCcF55K/huwR2OSACFrz
	P0kdAES4xA7+0/U351nzmMe1dgZYnFJKlpY2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VCpHufLZijE9WQSp/7UFNQ0hR6PH/+pE
	9CHafJh2AYVfhonATdnd9jcPuT1ZY5vJWTjk7I6DI/0WrHttiD7L/KA3OkLhvUJn
	qnhLQOMjn7u88+JNbqk5mIB8514ibkuwsHFXnkvb4hCfxFuIKcdjJ67KdiarjY0o
	svy3E14Awg0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79725C6B6;
	Fri,  1 Feb 2013 13:41:58 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D8775C6B4; Fri,  1 Feb 2013
 13:41:57 -0500 (EST)
In-Reply-To: <274664435.1090127.1359742284591.JavaMail.ngmail@webmail18.arcor-online.net>
 (Thomas Ackermann's message of "Fri, 1 Feb 2013 19:11:24 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0ED483D6-6C9F-11E2-AEE9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215246>

Thomas Ackermann <th.acker@arcor.de> writes:

> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>  Documentation/glossary-content.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index 7c15bc0..ddf2f66 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -149,6 +149,9 @@ to point at the new commit.
>  [[def_git_archive]]Git archive::
>  	Synonym for <<def_repository,repository>> (for arch people).
>  
> +[[def_gitfile]]gitfile::
> +	A `.git` file which points to a `$GIT_DIR` (used for Git submodules).
> +

It is more like 'used by' ;-)  People are free to write their
Porcelain system that uses this mechanism.

>  [[def_grafts]]grafts::
>  	Grafts enables two otherwise different lines of development to be joined
>  	together by recording fake ancestry information for commits. This way
