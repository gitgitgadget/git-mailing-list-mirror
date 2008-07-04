From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH]: fix typos in docs
Date: Fri, 04 Jul 2008 12:37:49 -0700
Message-ID: <7v63rlv3si.fsf@gitster.siamese.dyndns.org>
References: <877ic1sg47.fsf@offby1.atm01.sea.blarg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Hanchrow <offby1@blarg.net>
X-From: git-owner@vger.kernel.org Fri Jul 04 21:38:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEr7Q-0001Tx-Eg
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 21:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbYGDTh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 15:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbYGDTh6
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 15:37:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47723 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbYGDTh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 15:37:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A7E3017DFE;
	Fri,  4 Jul 2008 15:37:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D3DB817DFA; Fri,  4 Jul 2008 15:37:51 -0400 (EDT)
In-Reply-To: <877ic1sg47.fsf@offby1.atm01.sea.blarg.net> (Eric Hanchrow's
 message of "Fri, 04 Jul 2008 10:39:52 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B3216BDC-4A00-11DD-B967-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87414>

Eric Hanchrow <offby1@blarg.net> writes:

> From 098e3ec480254069d944e494a42afcf2013d08d7 Mon Sep 17 00:00:00 2001
> From: Eric Hanchrow <offby1@blarg.net>
> Date: Mon, 30 Jun 2008 23:34:08 -0700
> Subject: [PATCH] Fix typos

Unnecessarily duplicated headers.  Please drop them, especially the first
one (the latter three are fine if the difference between them and what
appears in your e-mail header matters).

> diff --git a/Documentation/.gitignore b/Documentation/.gitignore
> index d8edd90..ce24e4a 100644
> --- a/Documentation/.gitignore
> +++ b/Documentation/.gitignore

This part does not look like "fix typos" at all, and is an unrelated
change.  Explain in the commit log message please.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> -	then 'gitcvs.allbinary' is used. See linkgit:gitattribute[5].
> +	then 'gitcvs.allbinary' is used. See linkgit:gitattributes[5].
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> -linkgit:giteveryday[7], linkgit:gitcvs-migration[7],
> +linkgit:everyday[7], linkgit:gitcvs-migration[7],
> diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
> -linkgit:giteveryday[7], linkgit:gitcvs-migration[7],
> +linkgit:everyday[7], linkgit:gitcvs-migration[7],
> diff --git a/Documentation/gitglossary.txt b/Documentation/gitglossary.txt
> -linkgit:giteveryday[7], linkgit:gitcvs-migration[7],
> +linkgit:everyday[7], linkgit:gitcvs-migration[7],

These are "fix broken links" aren't they?  Please make them into a
separate patch that has only "fix broken links" and nothing else.

The remaining are rewording, "fix grammar", with one typofix; it is good
to include them in a single patch but please give a bit better label.

Please split this into at least two, possibly three patches:

 (0) A change to Documentation/.gitignore with justification.  As far as I
     can see, the two files you added are not built products nor cruft
     left by our build procedure.

 (1) "Documentation: fix broken links".

 (2) "Documentation: fix grammar and typo, and reword for readability".
