From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-recursive: move the global obuf to struct
 merge_options
Date: Thu, 04 Sep 2008 12:05:50 -0700
Message-ID: <7vr67z3f5d.fsf@gitster.siamese.dyndns.org>
References: <1220402349-7181-1-git-send-email-vmiklos@frugalware.org>
 <cover.1220463034.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Sep 04 21:07:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbKBI-0005YN-IV
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 21:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756512AbYIDTF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 15:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756496AbYIDTF7
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 15:05:59 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43790 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756416AbYIDTF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 15:05:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6750374D57;
	Thu,  4 Sep 2008 15:05:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 767DF74D55; Thu,  4 Sep 2008 15:05:53 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 815E7CC2-7AB4-11DD-AC2A-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94948>

Miklos Vajna <vmiklos@frugalware.org> writes:

> These, and the 4 other related patches which are not yet in git.git at
> the moment are also available in the 'merge-recursive' branch of
> git://repo.or.cz/git/vmiklos.git.

Thanks.

I already expressed my doubts about "move make_virtual_commit()".

"add merge-recursive to LIB_H" should go to 'maint' as a build-fix, so it
does not have to be on this topic.  If this is meant to be a pullable
topic branch, I'd prefer if you didn't have that commit.

I cherry picked call-depth, index-only removal, obuf and current_{f/d}
but haven't pushed the results out.
