From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] Re: Git commit path vs rebase path
Date: Wed, 16 May 2012 11:00:06 -0700
Message-ID: <1337191208-21110-1-git-send-email-gitster@pobox.com>
References: <4FB09FF2.70309@viscovery.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Steven Penny <svnpenn@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 20:00:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUiWS-0007sw-Db
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 20:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758988Ab2EPSAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 May 2012 14:00:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60816 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755873Ab2EPSAW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 14:00:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC17B81F8;
	Wed, 16 May 2012 14:00:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=FiWN
	rvVUWSytTTk4oahDF6KKtCo=; b=pIrd3gNBAEVHztZHsZZiYHVVz235BI3B58SJ
	CfmTYb2fF+zLN455IBkWpKFqLY6mLY/Q2uiHer1MSxLLDMua5v0ngk6gSHdIGNiV
	LfqZKw/MAy4x7Jm/L8HC3sD2AdQ571x1AaWciS6nP10/dkadpRCfXmq35EJjNq8Q
	g0YviiA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	SDTheI35Ul0l8+aC5nnuBSnXWZrFvDtABIuOW9A7mqJew6N2jNt6nlU7rK2H/m10
	zUWW53vIVcof9MWNYmlVz/mSEXse6nKert+Bn5jP+mPt9thEBeoWELHtKHaJKFdh
	x0FY0WAAxYKLFPvoP+RNcrxia8XN04QU+e2zIn7QiDw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B212381F7;
	Wed, 16 May 2012 14:00:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C64E381F0; Wed, 16 May 2012
 14:00:17 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.2.537.g0ac6509
In-Reply-To: <4FB09FF2.70309@viscovery.net>
X-Pobox-Relay-ID: FEDB831C-9F80-11E1-AF82-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197887>

I do not want to see a discussion hanging around waiting for somebody to
bring it to conclusion, especially when the topic is not something I can
give a tested definitive solution.  It is a sure way to lose the effort so
far that brought us almost there but not quite by not following through
and forgetting about it.

Here are two patches I *think* represent the conclusion of the discussion,
but it needs eyeballing from stakeholders.  I may have misunderstood the
issue entirely.

Also Steven's patch needs a sign-off.


Junio C Hamano (1):
  git-sh-setup: define workaround wrappers before they are used

Steven Penny (1):
  git-sh-setup: work around Cygwin path handling gotchas

 git-sh-setup.sh | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

-- 
1.7.10.2.537.g0ac6509
