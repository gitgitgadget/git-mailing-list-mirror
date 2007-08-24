From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Tags of non-commits
Date: Fri, 24 Aug 2007 13:26:49 -0700
Message-ID: <7vsl68d6gm.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0708241337560.5774@iabervon.org>
	<7vwsvkdaz0.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0708241506300.5774@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Aug 24 22:27:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOfkM-00022D-CZ
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 22:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757092AbXHXU1G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 16:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756724AbXHXU1F
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 16:27:05 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:60514 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756172AbXHXU1D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 16:27:03 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id E73B8127B0B;
	Fri, 24 Aug 2007 16:27:22 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0708241506300.5774@iabervon.org> (Daniel
	Barkalow's message of "Fri, 24 Aug 2007 15:13:16 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56598>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I get a bunch of:
>
> error: Object 0938d5832b4e40e6f440fa5c424c77b70714fb59 is a blob, not a commit
>
> lines. I think it's either in trying to decide whether they should be put 
> in FETCH_HEAD or in trying to determine reachability through them.

Ah, that should be fixable.  Never noticed it.

> ...server also seems to be unable to tell that I already have the blobs, and 
> sends a pack of all of them each time I pull with tags.

That may indeed be a limitation in native protocol.
