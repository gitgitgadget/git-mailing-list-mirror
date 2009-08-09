From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge: indicate remote tracking branches in merge
 message
Date: Sun, 09 Aug 2009 12:36:17 -0700
Message-ID: <7vprb47pam.fsf@alter.siamese.dyndns.org>
References: <20090809065936.GA24112@coredump.intra.peff.net>
 <7vab29a1fr.fsf@alter.siamese.dyndns.org>
 <20090809074035.GA4778@coredump.intra.peff.net>
 <20090809091443.GA676@coredump.intra.peff.net>
 <20090809100045.GA25197@coredump.intra.peff.net>
 <20090809100712.GA26250@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 09 21:36:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaEC7-00084w-Qn
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 21:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbZHITgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 15:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbZHITgX
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 15:36:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53483 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbZHITgW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 15:36:22 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 55E9D23269;
	Sun,  9 Aug 2009 15:36:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 71EE323268; Sun,  9 Aug 2009
 15:36:19 -0400 (EDT)
In-Reply-To: <20090809100712.GA26250@coredump.intra.peff.net> (Jeff King's
 message of "Sun\, 9 Aug 2009 06\:07\:12 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EBBA899A-851B-11DE-8733-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125375>

Jeff King <peff@peff.net> writes:

> On Sun, Aug 09, 2009 at 06:00:45AM -0400, Jeff King wrote:
>
>>   [1/3] add tests for merge message headings
>>   [2/3] merge: fix incorrect merge message for ambiguous tag/branch
>>   [3/3] merge: indicate remote tracking branches in merge message
>
> And here is the 4/3 you mentioned earlier:
>
> -- >8 --
> Subject: [PATCH] merge: describe tags as such in merge message
>
> Previously, merging a tag directly via "git merge tag" would
> get you the message "Merge commit 'tag'". It is a little
> more descriptive to note that it was actually a tag (i.e.,
> "Merge tag 'tag'").

Maybe "Merge version 'v1.6.3'" or "Merge commit tagged as 'v1.6.3'"? 
I dunno.
