From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-format-patch.txt: fix weird backslash
 at --root
Date: Sat, 27 Dec 2008 14:15:33 -0800
Message-ID: <7v4p0pcliy.fsf@gitster.siamese.dyndns.org>
References: <E1LGfLz-0001nM-AO@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Sat Dec 27 23:17:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGhTP-0005q4-4A
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 23:17:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754368AbYL0WPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2008 17:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754163AbYL0WPj
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 17:15:39 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34216 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218AbYL0WPj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 17:15:39 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 260378810F;
	Sat, 27 Dec 2008 17:15:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5E6648810E; Sat,
 27 Dec 2008 17:15:35 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E3E784FC-D463-11DD-AE51-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104026>

jidanni@jidanni.org writes:

> @@ -209 +209 @@ project:
> -$ git format-patch \--root origin
> +$ git format-patch --root origin

I thought these backslashes before double-dash are protecting the latter
from being turned into em-dashes.  I do not see any weird backslash in the
"git help" (aka "manpage") output nor in the HTML documentation, e.g.

    http://www.kernel.org/pub/software/scm/git/docs/git-format-patch.html

without your patch, so I have to say that this chunk is a useless churn.

All of your three patches lack context, which is essential enabler for
easier review.  They have "diff --git" header, but are not made relative
to the root of the project tree (i.e. lack "Documentation/" prefix), which
is the norm for both the tool and for this project and this mailing list.

I guess that you may be experimenting with various options to see how they
work, and the curiosity by itself is a good thing, but please do not make
other people suffer with results from such experiments by sending patches
in nonstandard forms.

By submitting a patch to try improving the system, you are already making
a difference in substance.  Please do not try to be creative in form.  It
only makes lives of other people unnecessarily harder with no real reason
and wastes other people's time.  And it wastes yours, too.  A patch
conforming to the norm is much easier to review, comment on and apply.
Ok?

"Don't try to be different in form, make a difference in substance" also
applies to your S-o-b line, by the way.
