From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge ignoring whitespace
Date: Thu, 05 Feb 2009 15:44:20 -0800
Message-ID: <7vtz78a1pn.fsf@gitster.siamese.dyndns.org>
References: <2754.1233876289@relay.known.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: layer <layer@known.net>
X-From: git-owner@vger.kernel.org Fri Feb 06 00:46:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVDv0-0003Ff-93
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 00:46:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756707AbZBEXo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 18:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753236AbZBEXo1
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 18:44:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56753 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756701AbZBEXo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 18:44:26 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 296BA2A834;
	Thu,  5 Feb 2009 18:44:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6DCF02A830; Thu, 
 5 Feb 2009 18:44:22 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EB92BC72-F3DE-11DD-A46C-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108634>

layer <layer@known.net> writes:

> Junio, on 3/25/07 you said:
>
>   I know Linus does not like applying patches with whitespace
>   fuzziness, but I personally think a merge that ignores
>   whitespace changes would be a useful thing to have, without
>   having to call an external specialized merge backend. In other
>   words, I do not think it is so special a thing to want to, but
>   it is rather an unfortunate norm.  I am not opposed to give
>   git-merge-recursive a command line option to tell it to merge
>   ignoring the whitespace-only changes, when it does the 3-way
>   file-level merge internally.
>
> Whatever came of this?

I do not know.  When I say "I am not opposed to", I mean just that. 

I may consider it a bad mode of operation, and I may hesitate to encourage
people to use it as their default.  But I do not feel strongly enough to
veto it---as long as it is a rope you need to explicitly ask for to hang
yourself with, I think it is Ok if we allowed such an option.

It is not my itch to scratch, and I do not keep track.

Did you submit a patch that implements the new feature cleanly?
