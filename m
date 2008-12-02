From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Modified the default git help message to be grouped by
 topic
Date: Mon, 01 Dec 2008 17:45:12 -0800
Message-ID: <7v7i6jqriv.fsf@gitster.siamese.dyndns.org>
References: <20081201173037.GA41967@agadorsparticus>
 <20081201183258.GB24443@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 02:46:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7KLq-0003Ad-Nx
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 02:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbYLBBpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 20:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752075AbYLBBpm
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 20:45:42 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42526 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbYLBBpl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 20:45:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 99BE0839E2;
	Mon,  1 Dec 2008 20:45:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 760F5839DD; Mon,
  1 Dec 2008 20:45:14 -0500 (EST)
In-Reply-To: <20081201183258.GB24443@coredump.intra.peff.net> (Jeff King's
 message of "Mon, 1 Dec 2008 13:32:59 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ECD2F840-C012-11DD-A3BE-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102093>

Jeff King <peff@peff.net> writes:

> On Mon, Dec 01, 2008 at 09:30:37AM -0800, Scott Chacon wrote:
>
>> It's difficult to process 21 commands (which is what is output
>> by default for git when no command is given).  I've re-grouped
>> them into 4 groups of 5 or 6 commands each, which I think is
>> clearer and easier for new users to process.
>
> I like it (and I think the categorizations look reasonable, which is
> something that I recall caused some discussion at the GitTogether).
>
> The only downside I see is that we're now >24 lines.

If this list is meant to show "the most commonly used" basics, then you
can trim the list somewhat.  For example, "rm" and "mv" can be safely
discarded, "status" can be replaced with "diff", and "diff" can be removed
from "History Commands".
