From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Check for -amend as a common wrong usage of --amend.
Date: Fri, 25 Jan 2008 22:20:41 -0800
Message-ID: <7vd4rp3y6e.fsf@gitster.siamese.dyndns.org>
References: <1201198439-3516-1-git-send-email-pascal@obry.net>
	<alpine.LSU.1.00.0801241818441.5731@racer.site>
	<4798DE6A.1050201@obry.net>
	<20080124204711.GC17765@kodama.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Sat Jan 26 07:21:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIePr-00075F-DK
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 07:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbYAZGUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 01:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752211AbYAZGUv
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 01:20:51 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36171 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbYAZGUu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 01:20:50 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CF6D24BA;
	Sat, 26 Jan 2008 01:20:48 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EB6B924B7;
	Sat, 26 Jan 2008 01:20:43 -0500 (EST)
In-Reply-To: <20080124204711.GC17765@kodama.kitenet.net> (Joey Hess's message
	of "Thu, 24 Jan 2008 15:47:11 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71762>

Joey Hess <joey@kitenet.net> writes:

> Some option parsers avoid this sort of ambiguity by not allowing short
> options that take a string to be bundled in the same word with other
> short options.
>
> So, for example, git-commit -am<msg> would not be allowed, while
> git-commit -a -m<msg> and perhaps git-commit -am <msg> would be allowed.
>
> There could still be problems if there were a --mend option that could
> be typoed as -mend.
>
> I don't know enough about compatability to say if this would work for git.

Yeah, I think that is quite a sensible workaround.
