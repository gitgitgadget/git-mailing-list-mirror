From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible bug: "git log" ignores "--encoding=UTF-8" option if
 --pretty=format:%e%n%s%n is used
Date: Wed, 12 Nov 2008 21:10:26 -0800
Message-ID: <7vod0ki531.fsf@gitster.siamese.dyndns.org>
References: <85647ef50811111112o5449c12elfc571e46e607cfd0@mail.gmail.com>
 <20081112104318.GA20120@coredump.intra.peff.net>
 <85647ef50811120311q7bc5451x7c084fd2a7864177@mail.gmail.com>
 <20081112112654.GA20640@coredump.intra.peff.net>
 <85647ef50811120508j5074f892p1e2a95acfae8c0a8@mail.gmail.com>
 <7vvdusjtg8.fsf@gitster.siamese.dyndns.org>
 <20081113043454.GA5048@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 13 06:12:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0UUq-0007wN-TG
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 06:12:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbYKMFKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 00:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbYKMFKp
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 00:10:45 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35778 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbYKMFKp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 00:10:45 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1A1887B6FF;
	Thu, 13 Nov 2008 00:10:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 73F477B6FE; Thu,
 13 Nov 2008 00:10:33 -0500 (EST)
In-Reply-To: <20081113043454.GA5048@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 12 Nov 2008 23:34:55 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6BD2C71E-B141-11DD-82CD-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100851>

Jeff King <peff@peff.net> writes:

> What about "git rev-list --pretty=raw"? Is that also porcelain?

Does it re-encode?  I didn't check, but ideally it shouldn't (but I do not
care too much either way, to be honest).

> I would be curious to hear your take on our failure to respect
> --encoding for --pretty=format. Is it a bug to be fixed, or a historical
> behavior to be maintained?

I think the fix you outlined was quite reasonable.
