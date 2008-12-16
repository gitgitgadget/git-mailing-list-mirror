From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: unify boolean feature subroutines
Date: Tue, 16 Dec 2008 01:03:03 -0800
Message-ID: <7vmyewqypk.fsf@gitster.siamese.dyndns.org>
References: <7vabawu1ao.fsf@gitster.siamese.dyndns.org>
 <1229408179-7655-1-git-send-email-kraai@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Tue Dec 16 10:04:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCVqx-00051S-E8
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 10:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbYLPJDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 04:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbYLPJDN
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 04:03:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45379 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbYLPJDM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 04:03:12 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3EDD51A61A;
	Tue, 16 Dec 2008 04:03:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 905681A610; Tue,
 16 Dec 2008 04:03:05 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5C9A084C-CB50-11DD-B7D4-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103263>

I'll queue this in 'pu' for now; it has obvious and trivial conflicts with
other gitweb series that introduce new features ;-)

And regarding your follow-up patch you called "churn", I think it is
probably a good idea in the longer term, although I haven't really
looked at all the callers to make sure everybody would be happy.

But a change to the function signature of feature subroutines is not
something I'd like to apply while other series that want to add new
features are still cooking.  How about doing these two patches as the
first thing that goes to 'next' after 1.6.1, and then force other series
rebase on top of your change?  Alternatively, we could make you wait until
other series do settle in 'next' and then apply your change rebased on
them, but I think that is probably less optimal.

Thanks.
