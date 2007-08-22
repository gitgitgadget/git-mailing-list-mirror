From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: update documentation with CAVEATS section
Date: Wed, 22 Aug 2007 15:41:24 -0700
Message-ID: <7v4piri44r.fsf@gitster.siamese.dyndns.org>
References: <20070816085645.GA3159@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Aug 23 00:41:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INytI-0004gG-7u
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 00:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764181AbXHVWla (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 18:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763954AbXHVWl3
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 18:41:29 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:51920 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764024AbXHVWl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 18:41:28 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 46DFE12279F;
	Wed, 22 Aug 2007 18:41:48 -0400 (EDT)
In-Reply-To: <20070816085645.GA3159@soma> (Eric Wong's message of "Thu, 16 Aug
	2007 01:56:45 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56432>

Eric Wong <normalperson@yhbt.net> writes:

>   I've been meaning to do this for a while, hopefully this cuts
>   down on the redundant mailing list traffic about these subjects.
> ...
> +CAVEATS
> +-------
> +
> +For the sake of simplicity and interoperating with a less-capable system
> +(SVN), it is recommended that all git-svn users clone, fetch and dcommit
> +directly from the SVN server, and avoid all git-clone/pull/merge/push
> +operations between git repositories and branches.  The recommended
> +method of exchanging code between git branches and users is
> +git-format-patch and git-am, or just dcommiting to the SVN repository.
> +
> +Running 'git-merge' or 'git-pull' is NOT recommended on a branch you
> +plan to dcommit from.  Subversion does not represent merges in any
> +reasonable or useful fashion; so users using Subversion cannot see any
> +merges you've made.

Ok, my ruling before 1.5.3 is to take this patch, and encourage
interested parties to help Eric adding reliable support for the
feature after that, if such is possible.
