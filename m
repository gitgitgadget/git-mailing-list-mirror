From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 06/11 v2] fast-import: Add support for importing commit
 notes
Date: Wed, 29 Jul 2009 09:20:06 -0700
Message-ID: <7v8wi7wjex.fsf@alter.siamese.dyndns.org>
References: <1248656659-21415-1-git-send-email-johan@herland.net>
 <200907280343.56586.johan@herland.net>
 <7vskgg1bbt.fsf@alter.siamese.dyndns.org>
 <200907290441.08246.johan@herland.net> <20090729142634.GC1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	barkalow@iabervon.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jul 29 18:21:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWBuA-0006lh-5u
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 18:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755580AbZG2QUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 12:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755584AbZG2QU3
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 12:20:29 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44791 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755574AbZG2QU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 12:20:26 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 78C8C18841;
	Wed, 29 Jul 2009 12:20:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5DCCD1883E; Wed,
 29 Jul 2009 12:20:11 -0400 (EDT)
In-Reply-To: <20090729142634.GC1033@spearce.org> (Shawn O. Pearce's message
 of "Wed\, 29 Jul 2009 07\:26\:34 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B78C9D16-7C5B-11DE-A2D9-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124366>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>> > We recently hit a similar unintended limitation that we regret in the
>> > fast-import language, didn't we?
>> 
>> I don't know. Must have slipped past my mailbox.
>
> I remember something being raised, but I can't remember exactly
> what it was either.

Exporting a tag that points at a non commit was what I had in mind.

> tag, there might be arguments for tagging trees, e.g. so you can
> export the linux kernel repository with `git fast-export` and reload
> it with fast-import.  But that's unrelated to this change.
>
> See above about notes.

I think we are in agreement then.  Good.
