From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] Add support for host aliases in config files
Date: Fri, 25 Jan 2008 12:19:52 -0800
Message-ID: <7vir1h64k7.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0801251336080.13593@iabervon.org>
	<m3fxwlagbu.fsf@localhost.localdomain>
	<alpine.LNX.1.00.0801251355490.13593@iabervon.org>
	<200801252033.13142.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 21:20:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIV2h-0000xF-7e
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 21:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514AbYAYUUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 15:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753594AbYAYUUM
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 15:20:12 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36790 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334AbYAYUUK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 15:20:10 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 587F26BFB;
	Fri, 25 Jan 2008 15:20:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C73246BF7;
	Fri, 25 Jan 2008 15:20:04 -0500 (EST)
In-Reply-To: <200801252033.13142.jnareb@gmail.com> (Jakub Narebski's message
	of "Fri, 25 Jan 2008 20:33:12 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71736>

Jakub Narebski <jnareb@gmail.com> writes:

> So this config variable is actually about _rewriting_ URLs, rather than
> having multiple _alternate_ URLs to fetch from. IMHO either the
> documentation above should be (re)written better (there is time, as we
> are in feature freeze), or the example mentioned above should be added
> (but where?).

I think Documentation/urls.txt would be a good candidate.
Currently it talks only about non-nicknamed remotes, and is
included only in clone and remote.  This makes sense as their
usage of urls.txt documentation is to talk about non-nicknamed
forms only (obviously clone cannot talk about nicknames in a
local repository that does not yet exist, and "remote add" needs
a non-nicknamed form as well).

Documentation/urls.txt can be enhanced to say that once you have
the remote.*.url and other configs, you can use its nickname to
name a remote repository.  Then it would become a good enough
shape to be included in push/fetch/pull pages as well.
