From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git no longer reads attributes from the index properly
Date: Fri, 20 Mar 2009 01:27:31 -0700
Message-ID: <7vab7gk39o.fsf@gitster.siamese.dyndns.org>
References: <20090320073527.GC1037@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	msysgit@googlegroups.com
To: bdowning@lavos.net
X-From: git-owner@vger.kernel.org Fri Mar 20 09:29:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lka6M-0003uD-FD
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 09:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754639AbZCTI1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 04:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754178AbZCTI1m
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 04:27:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46251 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbZCTI1l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 04:27:41 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 51825A3488;
	Fri, 20 Mar 2009 04:27:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A8A10A3486; Fri,
 20 Mar 2009 04:27:33 -0400 (EDT)
In-Reply-To: <20090320073527.GC1037@lavos.net> (Brian Downing's message of
 "Fri, 20 Mar 2009 02:35:27 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F93EE358-1528-11DE-8DCE-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113914>

bdowning@lavos.net (Brian Downing) writes:

> As of 34110cd4e394e3f92c01a4709689b384c34645d8, (2008-03-06, just over a
> year ago), Git no longer reads attributes from the index properly in all
> cases....

Perhaps you would want to try it on 06f33c1 (Read attributes from the
index that is being checked out, 2009-03-13) that is part of 'pu'?
