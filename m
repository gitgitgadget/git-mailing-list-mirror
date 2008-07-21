From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a notice to the doc of git-ls-tree.
Date: Sun, 20 Jul 2008 17:14:16 -0700
Message-ID: <7vljzw14br.fsf@gitster.siamese.dyndns.org>
References: <1216592735-23789-1-git-send-email-code@istique.net>
 <20080720230846.GH32184@machine.or.cz>
 <7vy73w16nj.fsf@gitster.siamese.dyndns.org>
 <7vtzek15b5.fsf@gitster.siamese.dyndns.org>
 <20080721000824.GI10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steve =?utf-8?Q?Fr=C3=A9cinaux?= <code@istique.net>,
	git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jul 21 02:15:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKj3l-0007yz-BD
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 02:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755940AbYGUAOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 20:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755794AbYGUAOY
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 20:14:24 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63956 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754926AbYGUAOX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 20:14:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2E7EE34DFF;
	Sun, 20 Jul 2008 20:14:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EC92034DFE; Sun, 20 Jul 2008 20:14:18 -0400 (EDT)
In-Reply-To: <20080721000824.GI10151@machine.or.cz> (Petr Baudis's message of
 "Mon, 21 Jul 2008 02:08:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F8A8D81E-56B9-11DD-82A7-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89273>

Petr Baudis <pasky@suse.cz> writes:

> I don't understand your point now.  --full-name cares only about the
> displaying part; do you suggest that it should be extended to also turn
> off prepending the prefix...

Ah, sorry, I thought you were talking about the display part.

I never thought you would think "showing relative to tree-root" is even an
option.  That would make it inconsistent with not just the established
semantics of what the plumbing did, but also with what ls-files does.
