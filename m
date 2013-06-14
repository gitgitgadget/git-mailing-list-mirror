From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/31] git-remote-mediawiki: Follow perlcritic's recommandations
Date: Fri, 14 Jun 2013 09:03:48 -0700
Message-ID: <7vwqpwptln.fsf@alter.siamese.dyndns.org>
References: <1371217839-23017-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, benoit.person@ensimag.fr,
	matthieu.moy@grenoble-inp.fr
To: =?utf-8?Q?C=C3=A9lestin?= Matte <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 14 18:03:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnWTk-0004cv-TK
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 18:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408Ab3FNQDw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jun 2013 12:03:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59306 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752106Ab3FNQDv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jun 2013 12:03:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D655C27AB7;
	Fri, 14 Jun 2013 16:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=M2vhP/WlvRE8
	loBiYEHJRm9N4PA=; b=UUEL5bVlrZy2ka8SY3FF2WroM2tHGtRwgzrvjXbbsLEI
	9A1/8nyu5DTpTl8KETfw5FMETYfGv4c4PTpXNLUMr3w67pbahPssSo/NFDb4ys/Y
	O0NJ8bYqyyQKptKEz2W6sSFdSv61c0/2U9Qe5OZaCxyXZZbdUCZ6K+YSoK3FRe8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pEf30f
	bQyWdyOq2tnd6gYniZTKxukxWDBpgYjajzlDMTkZq+uQpWpXp+Br38fPuSW877Jl
	N+6Fee+BPa2pRTvaz3w4dXy5d73CwN6/XJhBElJ8iHk8xqn6GRIe4y9kdCgdcM9v
	VBTSNIcIelXVQMHFz9d1cNxoCi+8fXB33av4k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA93A27AB6;
	Fri, 14 Jun 2013 16:03:50 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 109E327AB4;
	Fri, 14 Jun 2013 16:03:49 +0000 (UTC)
In-Reply-To: <1371217839-23017-1-git-send-email-celestin.matte@ensimag.fr>
	(=?utf-8?Q?=22C=C3=A9lestin?= Matte"'s message of "Fri, 14 Jun 2013
 15:50:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 00976B1E-D50C-11E2-9679-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227890>

C=C3=A9lestin Matte <celestin.matte@ensimag.fr> writes:

> C=C3=A9lestin Matte (31):
>   git-remote-mediawiki: Make a regexp clearer
>   git-remote-mediawiki: Move "use warnings;" before any instruction
>   git-remote-mediawiki: Replace :utf8 by :encoding(UTF-8)
>   git-remote-mediawiki: Always end a subroutine with a return
>   git-remote-mediawiki: Move a variable declaration at the top of the
>     code
>   git-remote-mediawiki: Change syntax of map calls
>   git-remote-mediawiki: Rewrite unclear line of instructions
>   git-remote-mediawiki: Remove useless regexp modifier (m)
>   git-remote-mediawiki: Change the behaviour of a split
>   git-remote-mediawiki: Change separator of some regexps
>   git-remote-mediawiki: Change style in a regexp
>   git-remote-mediawiki: Change style in a regexp
>   git-remote-mediawiki: Add newline in the end of die() error message=
s
>   git-remote-mediawiki: Change the name of a variable
>   git-remote-mediawiki: Turn double-negated expressions into simple
>     expressions
>   git-remote-mediawiki: Remove unused variable $entry
>   git-remote-mediawiki: Rename a variable ($last) which has the name =
of
>     a keyword
>   git-remote-mediawiki: Assign a variable as undef and make proper
>     indentation
>   git-remote-mediawiki: Check return value of open
>   git-remote-mediawiki: remove import of unused open2
>   git-remote-mediawiki: Put long code into a subroutine
>   git-remote-mediawiki: Modify strings for a better coding-style
>   git-remote-mediawiki: Brace file handles for print for more clarity
>   git-remote-mediawiki: Replace "unless" statements with negated "if"
>     statements
>   git-remote-mediawiki: Don't use quotes for empty strings
>   git-remote-mediawiki: Put non-trivial numeric values in constants.
>   git-remote-mediawiki: Fix a typo ("mediwiki" instead of "mediawiki"=
)
>   git-remote-mediawiki: Clearly rewrite double dereference
>   git-remote-mediawiki: Add a .perlcriticrc file
>   git-remote-mediawiki: add a perlcritic rule in Makefile
>   git-remote-mediawiki: Make error message more precise
>
>  contrib/mw-to-git/.perlcriticrc             |  28 ++
>  contrib/mw-to-git/Makefile                  |   2 +
>  contrib/mw-to-git/git-remote-mediawiki.perl | 537 +++++++++++++++---=
----------
>  3 files changed, 320 insertions(+), 247 deletions(-)
>  create mode 100644 contrib/mw-to-git/.perlcriticrc

Thanks.  Will queue.
