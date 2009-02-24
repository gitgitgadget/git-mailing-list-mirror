From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/23] builtin-remote improvments
Date: Tue, 24 Feb 2009 09:39:53 -0800
Message-ID: <7v7i3fhgye.fsf@gitster.siamese.dyndns.org>
References: <cover.1235461736.git.jaysoffian@gmail.com>
 <1235472816-52420-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 18:41:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc1Hf-0006zi-Ld
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 18:41:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759002AbZBXRkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 12:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758798AbZBXRkD
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 12:40:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34442 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758038AbZBXRkB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 12:40:01 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id AD3152B7AC;
	Tue, 24 Feb 2009 12:39:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C2FBC2BCE8; Tue,
 24 Feb 2009 12:39:54 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 28978F8E-029A-11DE-A6C0-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111323>

Jay Soffian <jaysoffian@gmail.com> writes:

> When I have the series really ready, would you prefer I setup a repo for
> you to pull from? I'm loath to spam the list with another 24 messages.

I don't mind pulling, as it is less work for me, but it would make
harder for others to see the changes in flight and discuss, so...

Even though I'd need to re-read them before merging them to 'next', I also
think the earlier remote-set-head series and Jeff's changes on top of it
looked more or less reasonable.  Perhaps I should rebase them on top of
'master' before moving them to 'next' and then you can build on top, which
would reduce your new series by about 10 commits.
