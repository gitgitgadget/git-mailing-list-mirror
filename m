From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch: refuse to fetch into the current branch in a
 non-bare repository
Date: Sat, 11 Oct 2008 14:44:52 -0700
Message-ID: <7vprm6iz6z.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0810111336350.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, spearce@spearce.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 11 23:46:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KomI3-0001vs-0U
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 23:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754630AbYJKVpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 17:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754620AbYJKVpG
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 17:45:06 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51866 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbYJKVpF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 17:45:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1774C89AB5;
	Sat, 11 Oct 2008 17:45:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CC60689AB1; Sat, 11 Oct 2008 17:44:53 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0810111336350.22125@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Sat, 11 Oct 2008 13:38:02 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DCE9CAB0-97DD-11DD-9863-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97993>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Some confusing tutorials suggest that it would be a good idea to call
> something like this:
>
> 	git pull origin master:master
>
> While it might make sense to store what you want to merge, it typically
> is plain wrong.

I am somewhat confused.

This "confusion" has been there for very long time and (at least the
scripted version of) git-pull/git-fetch pair has supported a workaround in
the form of --update-head-ok option.

Have we broken the workaround ll.127..147 in git-pull.sh recently, or are
you trying to address something else?
