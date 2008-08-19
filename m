From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Note the use of "rebase -i" to squash consecutive
 commits into one.
Date: Mon, 18 Aug 2008 20:32:53 -0700
Message-ID: <7vtzdhisre.fsf@gitster.siamese.dyndns.org>
References: <1219012340-23376-1-git-send-email-offby1@blarg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Hanchrow <offby1@blarg.net>
X-From: git-owner@vger.kernel.org Tue Aug 19 05:34:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVHyv-00049o-1c
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 05:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604AbYHSDdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 23:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752579AbYHSDdA
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 23:33:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbYHSDc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 23:32:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9A721581A9;
	Mon, 18 Aug 2008 23:32:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 07A38581A8; Mon, 18 Aug 2008 23:32:55 -0400 (EDT)
In-Reply-To: <1219012340-23376-1-git-send-email-offby1@blarg.net> (Eric
 Hanchrow's message of "Sun, 17 Aug 2008 15:32:20 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 84CC7B1A-6D9F-11DD-98F2-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92808>

This is missing sign-off.

More importantly, I do not think adding an extra illustration that starts
talking about an example history that is _different_ from what was being
discussed is a good idea.  The end result lacks coherence and forces the
reader to reset his mind for each example.

I'd suggest you to rewrite the example part that begins a few lines before
you touched.  Present the example "original" history with illustration
first (and call it A---B---C---D---E---F---G, not QRSTU), and clarify the
existing example of reordering the last 5 commits, and show the history
after such reordering.

Then you talk about squashing, with before-and-after illustrations, but
base that illustration on the same example history.  That way, the reader
has to understand the original scene only once to grok both examples.
