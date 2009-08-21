From: Junio C Hamano <gitster@pobox.com>
Subject: [OffTopic] git repos on sourceforge.net seem to have moved
Date: Thu, 20 Aug 2009 20:05:31 -0700
Message-ID: <7v7hwxn9xg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 21 05:05:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeKRm-0008Ft-Va
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 05:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752690AbZHUDFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 23:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752313AbZHUDFg
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 23:05:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38315 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbZHUDFg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 23:05:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BA0B73151B;
	Thu, 20 Aug 2009 23:05:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=ZtTc
	fn3J9BOyRywaTfQED1sGoxk=; b=fZTCxpGoj7mNT4a/o10nCRNmWLwvMpx5PlLI
	wkQPkaFlm1UiPzAfVIscWCDkmENnYMluKV84tT0zGn+DZvM6qZCs5aWZq6qCe6Ot
	VUzKzumZFY+gyp2JiG8VaNjcSySH2v69uCUIxqXDfuHa6kkRbCWLG2YA8VyDTVFl
	JfKCz44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=JKv
	cOMymagzSBqeoLc3Mtbd73I0/+GBZQNhjaGpTwV5Kv0TBKHNLv6Ln/N3h45sdU3Y
	7W6CAEnyBPPO/zZ+Iiilhr4N/fmr57OCNziTTMadM8rXXDv614/xXr1xRbXaYchb
	DkGFxigJxF0qbYGfofkwLt4WpBg9M/s9wmpFtuo8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A935331508;
	Thu, 20 Aug 2009 23:05:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EC84631506; Thu, 20 Aug 2009
 23:05:32 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7FB56462-8DFF-11DE-90C1-3142836986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126669>

Just FYI, to save others from wasting time like I did...

If you were using sourceforge.net instead of k.org or repo.or.cz to
clone/fetch your copy of git from, you may have started experiencing
problem recently.

The git URL advertized on the project page (still) looks like:

    git://git-core.git.sourceforge.net/gitroot/git-core

but it seems that they (meaning sourceforge admins) moved the projects one
hierarchy down.  The correct URL is (currently):

    git://git-core.git.sourceforge.net/gitroot/git-core/git-core/

This change seems to affect the people who push (like myself) over ssh.
