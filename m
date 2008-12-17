From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3 (edit v2)] gitweb: Cache $parent_commit info in
 git_blame()
Date: Wed, 17 Dec 2008 00:34:55 -0800
Message-ID: <7v63ljp5cg.fsf@gitster.siamese.dyndns.org>
References: <20081209224622.28106.89325.stgit@localhost.localdomain>
 <200812101439.18526.jnareb@gmail.com>
 <7v7i67zsgj.fsf@gitster.siamese.dyndns.org>
 <200812110133.33124.jnareb@gmail.com> <20081217081935.GC3640@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Luben Tuikov <ltuikov@yahoo.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Dec 17 09:36:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCrtU-00082h-F0
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 09:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753818AbYLQIfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 03:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753811AbYLQIfL
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 03:35:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38177 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbYLQIfK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 03:35:10 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7366C1A763;
	Wed, 17 Dec 2008 03:35:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CE5461A762; Wed,
 17 Dec 2008 03:34:57 -0500 (EST)
In-Reply-To: <20081217081935.GC3640@machine.or.cz> (Petr Baudis's message of
 "Wed, 17 Dec 2008 09:19:35 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9ACE4F5E-CC15-11DD-81FE-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103319>

Petr Baudis <pasky@suse.cz> writes:

> (though I think the commit message is total overkill for such an obvious
> change ;-)

I think so too; the performance figures are nice but there is no need to
talk about what is not implemented.
