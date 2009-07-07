From: Junio C Hamano <gitster@pobox.com>
Subject: Re: =?utf-8?Q?Schr=C3=B6dinger's?= diff
Date: Tue, 07 Jul 2009 12:48:45 -0700
Message-ID: <7vtz1o9sv6.fsf@alter.siamese.dyndns.org>
References: <279b37b20907062353k34bca06erf035458e80933c8d@mail.gmail.com>
 <alpine.LNX.2.00.0907071316490.2147@iabervon.org>
 <20090707193605.GA30945@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 07 21:49:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOGey-0002lo-Uq
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 21:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755461AbZGGTsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 15:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755106AbZGGTsx
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 15:48:53 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64581 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754359AbZGGTsx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 15:48:53 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3119F26560;
	Tue,  7 Jul 2009 15:48:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5D25F2655F; Tue, 
 7 Jul 2009 15:48:47 -0400 (EDT)
In-Reply-To: <20090707193605.GA30945@coredump.intra.peff.net> (Jeff King's
 message of "Tue\, 7 Jul 2009 15\:36\:05 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 32738E1A-6B2F-11DE-8BC9-DC021A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122862>

Jeff King <peff@peff.net> writes:

> .... But even that might have holes,
> I'm afraid -- we don't always look at all of the config in every
> command, though perhaps we do for such core functionality.

I personally do not think it is worth it.  If you change the crlf,
clean/smudge, or anything of that sort, just doing a "rm .git/index"
followed by "git reset --hard" would restore sanity to your work tree, no?
