From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] Doc add: link gitignore
Date: Sun, 16 Sep 2012 22:50:38 -0700
Message-ID: <7vhaqxw635.fsf@alter.siamese.dyndns.org>
References: <1347793083-4136-7-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 07:50:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDUEM-0005C4-00
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 07:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826Ab2IQFum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 01:50:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46545 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912Ab2IQFul (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 01:50:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3627646B;
	Mon, 17 Sep 2012 01:50:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LGu/lgkdhtiLecwK8ncz8FbMM58=; b=adV/0e
	SE1ZbCdV+auHiZ/FRBslfyS2n/6mfrSaki692oTDEHxE1auTwR1lSYsEpfxcX/3z
	8EYPL5+CEO+L1saVYX1m4Ar2+MLH/tfCSc5zR9jvvQ0QgWNrhxahgRQ/aFXA21vc
	8+8xcf3G2mvbJcTZsxjt5vOtJm2E4cr1Wenz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tLJxXN0/l31rPSxKXnlDmtFwUWfXl3Ex
	HYICmT4t18BEyV0St3G7a0pdjrTSEXhtYIsQGJgy1HIJBmpBX1EFuuvjqeYopjdr
	4N96c++KH9ejbRHw4fNYJ4fvz9ldhjIz95dXQNYomokeuLQBR10U/j2yNZxP3HTn
	68luPM+irV8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D19E5646A;
	Mon, 17 Sep 2012 01:50:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30A1D6469; Mon, 17 Sep 2012
 01:50:40 -0400 (EDT)
In-Reply-To: <1347793083-4136-7-git-send-email-philipoakley@iee.org> (Philip
 Oakley's message of "Sun, 16 Sep 2012 11:58:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9C960544-008B-11E2-8A9F-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205651>

Philip Oakley <philipoakley@iee.org> writes:

> Include the gitignore link with the paired gitrepository-
> layout link.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
>
> without the gitignore link users are unlikely to realise the
> significance of the repository layout link, nor what to look for
> within it
>
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index 9c1d395..311be9a 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -155,7 +155,8 @@ Configuration
>  The optional configuration variable `core.excludesfile` indicates a path to a
>  file containing patterns of file names to exclude from git-add, similar to
>  $GIT_DIR/info/exclude.  Patterns in the exclude file are used in addition to
> -those in info/exclude.  See linkgit:gitrepository-layout[5].
> +those in info/exclude.  See linkgit:gitrepository-layout[5] and
> +linkgit:gitignore[5].

A reader of git-add shouldn't have to refer to gitrepository-layout[5]
in the first place when we talk about "add $pathspec" may ignore
paths that are configured to be ignored.  gitignore[5] should give
everything necessary to him.

This section (even before the precontext we can see in the patch)
may need a bit larger rewrite so that it just refers to gitignore[5]
and leave the details of where the exclude information comes to that
manual page.
