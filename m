From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Removed redundant static functions such as
 update_tracking_ref() and verify_remote_names() from builtin-send-pack.c, and
 made the ones in transport.c not be static so they can be used instead.
Date: Fri, 24 Apr 2009 15:41:54 -0700
Message-ID: <7vfxfxad3h.fsf@gitster.siamese.dyndns.org>
References: <1240546432-26212-1-git-send-email-andy@petdance.com>
 <20090424210418.GC13561@coredump.intra.peff.net>
 <99B4BF12-01B9-4A68-B2E0-EF5DF2595FF0@petdance.com>
 <20090424212313.GA14435@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Lester <andy@petdance.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 25 00:43:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxU7O-0007nr-Cb
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 00:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753662AbZDXWmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 18:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752598AbZDXWmB
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 18:42:01 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41969 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787AbZDXWmB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 18:42:01 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1DE691134E;
	Fri, 24 Apr 2009 18:42:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 50A5B1134D; Fri,
 24 Apr 2009 18:41:56 -0400 (EDT)
In-Reply-To: <20090424212313.GA14435@coredump.intra.peff.net> (Jeff King's
 message of "Fri, 24 Apr 2009 17:23:14 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 202BFA14-3121-11DE-8C2B-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117506>

Jeff King <peff@peff.net> writes:

> On Fri, Apr 24, 2009 at 04:13:14PM -0500, Andy Lester wrote:
>
>> This was what I was looking for.  I think what I'll do is fold your  
>> message into Documentation/SubmittingPatches and submit that as a patch 
>> first.
>
> That probably makes sense.
>
> I keep thinking about writing a separate "how to write a good commit
> message" document that would be more universal than just "here's how you
> submit a patch to git". And some of what I wrote to you could probably
> go in such a document. But I don't know if it makes sense to start a new
> document just with what I said there; it might be a bit sparse (OTOH,
> maybe people would then be encouraged to add their tips to it).

I'm sure our capable project secretary would come up with list of quotes
in the archive from Linus and I perhaps over the weekend in her copious
spare time ;-).
