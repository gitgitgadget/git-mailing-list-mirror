From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-help: fallback to GIT_MAN_VIEWER before man
Date: Fri, 29 Aug 2008 09:12:48 -0700
Message-ID: <7vod3b4x6n.fsf@gitster.siamese.dyndns.org>
References: <877i9zsw6c.fsf@elegiac.orebokech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Romain Francoise <romain@orebokech.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 18:14:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ6cE-0002Ly-9R
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 18:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870AbYH2QM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 12:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757511AbYH2QM6
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 12:12:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47458 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757580AbYH2QM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 12:12:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7B91B5569A;
	Fri, 29 Aug 2008 12:12:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E1C2D55699; Fri, 29 Aug 2008 12:12:50 -0400 (EDT)
In-Reply-To: <877i9zsw6c.fsf@elegiac.orebokech.com> (Romain Francoise's
 message of "Fri, 29 Aug 2008 17:00:43 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 56C8AD62-75E5-11DD-B98E-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94308>

Romain Francoise <romain@orebokech.com> writes:

> In some situations it is useful to be able to switch viewers via the
> environment, e.g. in Emacs shell buffers.  So check the GIT_MAN_VIEWER
> environment variable and try it before falling back to "man".
>
> Signed-off-by: Romain Francoise <romain@orebokech.com>
> ---
>
> The motivation for this is that I want the viewer to be "woman" in
> Emacs shell buffers and "man" otherwise, and having an environment
> variable (like PAGER or EDITOR) is cleaner than using a
> man.viewer.cmd wrapper to do the redirection.

Obviously I am biased, as I am among the people who have PAGER=cat and
EDITOR=emacsclient, and 70% of whose command invocation is from within the
"M-x compile", but I like this.
