From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] "git shell" won't work, need "git-shell"
Date: Sun, 24 Aug 2008 14:20:20 -0700
Message-ID: <7vbpzikt4b.fsf@gitster.siamese.dyndns.org>
References: <20080824202325.GA14930@eagain.net>
 <7vfxoukv56.fsf@gitster.siamese.dyndns.org>
 <20080824203825.GB14930@eagain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tommi Virtanen <tv@eagain.net>
X-From: git-owner@vger.kernel.org Sun Aug 24 23:21:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXN1h-0006kn-De
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 23:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753095AbYHXVU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 17:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753146AbYHXVU0
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 17:20:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41437 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbYHXVU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 17:20:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 512F66D87B;
	Sun, 24 Aug 2008 17:20:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AFDC16D87A; Sun, 24 Aug 2008 17:20:22 -0400 (EDT)
In-Reply-To: <20080824203825.GB14930@eagain.net> (Tommi Virtanen's message of
 "Sun, 24 Aug 2008 23:38:25 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 77ABEFA6-7222-11DD-BAD9-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93566>

Tommi Virtanen <tv@eagain.net> writes:

> On Sun, Aug 24, 2008 at 01:36:37PM -0700, Junio C Hamano wrote:
>> Of course it would.  Does using /usr/libexec/git-core/git-shell work?
>
> It would, but do you really want people using that?

I do not have particular preference either way.  What people wanted was to
have smaller number of git-foo on $PATH, and especially as "git-shell" is
not something people would be typing from their command line, so I dunno.
