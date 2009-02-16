From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Improving CRLF error message; also, enabling autocrlf and
 safecrlf by default
Date: Sun, 15 Feb 2009 19:14:30 -0800
Message-ID: <7vhc2vf4yx.fsf@gitster.siamese.dyndns.org>
References: <loom.20090216T022524-78@post.gmane.org>
 <20090216030446.GC18780@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Spiro <jasonspiro4@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 04:16:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYtxn-0004xW-KO
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 04:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755810AbZBPDOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 22:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755733AbZBPDOh
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 22:14:37 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33022 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755546AbZBPDOh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 22:14:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7724B9ADF4;
	Sun, 15 Feb 2009 22:14:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 45A179ADF3; Sun,
 15 Feb 2009 22:14:31 -0500 (EST)
In-Reply-To: <20090216030446.GC18780@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 15 Feb 2009 22:04:46 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F0A1991C-FBD7-11DD-9AD9-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110122>

Jeff King <peff@peff.net> writes:

> I'm happy you want to improve git; but please, if you want to report
> problems, check what the status is in a more recent version (or at least
> tell us your version, which can help).
> ...
> It might be worth splitting the trailing whitespace detection into
> "spaces and tabs at the end" and "CRLF", and providing different
> messages (though it is hopefully also obvious with the new output that
> it is a CRLF issue).

I think the status on this in a more recent version can be found by
running "git grep cr-at-eol" ;-)
