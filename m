From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2009, #07; Wed, 28)
Date: Wed, 28 Jan 2009 20:22:44 -0800
Message-ID: <7vab9aivvv.fsf@gitster.siamese.dyndns.org>
References: <7vwscej26i.fsf@gitster.siamese.dyndns.org>
 <20090129035138.GC11836@coredump.intra.peff.net>
 <20090129040254.GD11836@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 29 05:24:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSORz-0002wi-Cp
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 05:24:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462AbZA2EW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 23:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754224AbZA2EW5
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 23:22:57 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48952 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754132AbZA2EW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 23:22:57 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A96C22A012;
	Wed, 28 Jan 2009 23:22:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A9CD12A011; Wed,
 28 Jan 2009 23:22:51 -0500 (EST)
In-Reply-To: <20090129040254.GD11836@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 28 Jan 2009 23:02:54 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8084C9B6-EDBC-11DD-B542-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107629>

Jeff King <peff@peff.net> writes:

> We could always assume the remote side is going to eventually put
> content on "master" (we know they aren't using another branch _now_, or
> the repo wouldn't be empty, so we are just guessing they will follow the
> usual convention). That feels a bit hack-ish, though.

Now, doesn't "The other end is empty" error start looking much saner than
everybody seems to have thought ;-)?
