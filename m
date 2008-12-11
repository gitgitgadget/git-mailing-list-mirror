From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 4/3] gitweb: Incremental blame (proof of concept)
Date: Wed, 10 Dec 2008 16:47:12 -0800
Message-ID: <7v3agvy1v3.fsf@gitster.siamese.dyndns.org>
References: <20081209223703.28106.29198.stgit@localhost.localdomain>
 <20081210200908.16899.36727.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Luben Tuikov <ltuikov@yahoo.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Petr Baudis <pasky@suse.cz>,
	Fredrik Kuivinen <frekui@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 01:48:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAZjQ-0008K4-Nb
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 01:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149AbYLKArX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 19:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752961AbYLKArX
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 19:47:23 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64563 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309AbYLKArW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 19:47:22 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6A9BD85739;
	Wed, 10 Dec 2008 19:47:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 08E5185735; Wed,
 10 Dec 2008 19:47:13 -0500 (EST)
In-Reply-To: <20081210200908.16899.36727.stgit@localhost.localdomain> (Jakub
 Narebski's message of "Wed, 10 Dec 2008 21:11:18 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 44DC1CB8-C71D-11DD-B7EF-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102758>

Jakub Narebski <jnareb@gmail.com> writes:

> NOTE: This patch is RFC proof of concept patch!: it should be split
> onto many smaller patches for easy review (and bug finding) in version
> meant to be applied.

Hmm, the comments an RFC requests for would certainly be based on reviews
of the patch in question, so if the patch is known to be unsuitable for
reviewing, what would that tell us, I wonder ;-)?

Among the 700 lines added/deleted, 400 lines are from a single new file,
so what may benefit from splitting would be the changes to gitweb.perl but
it does not look so bad (I haven't really read the patch, though).

> Differences between 'blame' and 'blame_incremental' output:

Hmm, are these by design in the sense that "when people are getting
incremental blame output, the normal blame output format is unsuitable for
such and such reasons and that is why there have to be these differences",
or "the code happens to produce slightly different results because it is
implemented differently; the differences are listed here as due
diligence"?

> P.P.S. What is the stance for copyrigth assesments in the files
> for git code, like the ones in gitweb/gitweb.perl and gitweb/blame.js?

There is no copyright assignment.  Everybody retains the own copyright on
their own work.

> P.P.P.S. Should I use Signed-off-by from Pasky and Fredrik if I based
> my code on theirs, and if they all signed their patches?

I think that is in line with what Certificate of Origin asks you to do.
