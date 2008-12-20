From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: fix typos, grammar, asciidoc syntax
Date: Fri, 19 Dec 2008 22:48:42 -0800
Message-ID: <7v3agj1gvp.fsf@gitster.siamese.dyndns.org>
References: <200812191314.19302.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Sat Dec 20 07:50:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDvf5-0002Xy-Mw
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 07:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbYLTGss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 01:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752331AbYLTGsr
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 01:48:47 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35634 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273AbYLTGsr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 01:48:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E817789D97;
	Sat, 20 Dec 2008 01:48:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1809689D96; Sat,
 20 Dec 2008 01:48:43 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4026B0C4-CE62-11DD-8C75-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103626>

Markus Heidelberg <markus.heidelberg@web.de> writes:

> Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
> ---
>  Documentation/diff-format.txt         |    2 +-
>  Documentation/diff-generate-patch.txt |    6 +++---
>  Documentation/git-commit.txt          |    2 +-
>  Documentation/git-diff-tree.txt       |    4 ++--
>  Documentation/git-mailinfo.txt        |    2 +-
>  Documentation/git-receive-pack.txt    |    4 ++--
>  Documentation/git-reflog.txt          |    4 ++--
>  Documentation/git-show-branch.txt     |    4 ++--
>  Documentation/git-submodule.txt       |    2 +-
>  Documentation/git-update-index.txt    |    8 ++++----
>  Documentation/gitcore-tutorial.txt    |    8 ++++----
>  Documentation/gitk.txt                |    4 ++--
>  Documentation/i18n.txt                |    4 ++--
>  13 files changed, 27 insertions(+), 27 deletions(-)

Whew, quite a lot of typos there are.

> @@ -172,7 +172,7 @@ only the primary branches.  In addition, if you happen to be on
>  your topic branch, it is shown as well.
>  
>  ------------
> -$ git show-branch --reflog='10,1 hour ago' --list master
> +$ git show-branch --reflog="10,1 hour ago" --list master
>  ------------

Is this just a personal taste, or a correction to typography?

Other than this one, I did not find anything else in your patch that
looked iffy.  Thanks for lending a good set of eyeballs.
