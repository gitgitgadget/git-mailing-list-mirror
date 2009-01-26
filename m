From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 1/3] Introduce config variable "diff.primer"
Date: Sun, 25 Jan 2009 19:38:49 -0800
Message-ID: <7v8woybut2.fsf@gitster.siamese.dyndns.org>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu>
 <1232904657-31831-2-git-send-email-keith@cs.ucla.edu>
 <7v1vurf7lq.fsf@gitster.siamese.dyndns.org>
 <7v1vuqdcjp.fsf@gitster.siamese.dyndns.org>
 <20090126031820.GC14277@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Keith Cascio <keith@cs.ucla.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 26 04:40:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRIKj-0000jt-Fc
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 04:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbZAZDi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 22:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbZAZDi4
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 22:38:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65504 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbZAZDi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 22:38:56 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 845811D4CA;
	Sun, 25 Jan 2009 22:38:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 979DF1D4C9; Sun,
 25 Jan 2009 22:38:50 -0500 (EST)
In-Reply-To: <20090126031820.GC14277@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 25 Jan 2009 22:18:20 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DBA04C62-EB5A-11DD-B1F6-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107166>

Jeff King <peff@peff.net> writes:

> So I think what you will end up with is a list in gitk of "these
> particular options are known good for passing through". And that doesn't
> really need tool support from git-core. It's up to each script how much
> it wants to protect the user.

I tend to agree.  Also at the same time this does not have to contradict
with what Keith wants to do.  gitk just needs to learn to peek into
diff.primer, and use the safe ones while discarding others.  A tool
support is already there in the form of git-config to do this, though.
