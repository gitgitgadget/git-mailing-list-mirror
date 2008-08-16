From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-stash: improve synopsis in help and manual page
Date: Sat, 16 Aug 2008 02:49:06 -0700
Message-ID: <7vljyxe1d9.fsf@gitster.siamese.dyndns.org>
References: <1218857251-2971-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Aug 16 11:50:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUIQM-000443-EV
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 11:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435AbYHPJtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 05:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752427AbYHPJtP
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 05:49:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41317 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336AbYHPJtO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2008 05:49:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CD82F62E35;
	Sat, 16 Aug 2008 05:49:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 244EB62E2E; Sat, 16 Aug 2008 05:49:07 -0400 (EDT)
In-Reply-To: <1218857251-2971-1-git-send-email-s-beyer@gmx.net> (Stephan
 Beyer's message of "Sat, 16 Aug 2008 05:27:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 943D8A5E-6B78-11DD-941E-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92539>

Stephan Beyer <s-beyer@gmx.net> writes:

>    btw, should the "create" command be used directly at all?
>    Then a line for this should perhaps be added.

It's pretty much for Porcelain writer's consumption, so I do not think
it is worth adding it to command line help, even though it would be nice
to describe it in the documentation.

> +dashless=$(basename "$0" | sed -e 's/-/ /')
> +USAGE="list [<options>]
> +   or: $dashless (show | drop | pop ) [<stash>]
> +   or: $dashless [--index] apply [<stash>]
> +   or: $dashless branch <branchname> [<stash>]
> +   or: $dashless [--keep-index] [save [<message>]]
> +   or: $dashless clear"

These --index and --keep-index are subcommand options and come after
them (i.e. apply/save).
