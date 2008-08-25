From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a reference to gitk localbranc remote/branch in
 gittutorial
Date: Mon, 25 Aug 2008 14:53:48 -0700
Message-ID: <7v63pog3rn.fsf@gitster.siamese.dyndns.org>
References: <20080825215023.11822a20@paolo-desktop>
 <loom.20080825T200956-169@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 23:55:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXk1c-0000Fh-Iz
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 23:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140AbYHYVx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 17:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752306AbYHYVx4
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 17:53:56 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47866 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbYHYVx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 17:53:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2BFE968170;
	Mon, 25 Aug 2008 17:53:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1912868166; Mon, 25 Aug 2008 17:53:49 -0400 (EDT)
In-Reply-To: <loom.20080825T200956-169@post.gmane.org> (Eric Raible's message
 of "Mon, 25 Aug 2008 20:12:03 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 500CA214-72F0-11DD-B48B-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93687>

Eric Raible <raible@gmail.com> writes:

> Paolo Ciarrocchi <paolo.ciarrocchi <at> gmail.com> writes:
>
>> +Alice can also use gitk to browse that Bob did:
>
> s/that/what/ ?
>
>> +------------------------------------------------
>> +alice$ gitk master origin/master
>> +------------------------------------------------
>
> I think that you meant:
>
> alice$ gitk master..origin/master


I'd suggest rewording the explanation to have Alice "compare what both of
them did", not just "browse what Bob did".

And for that purpose, I think the original form used by Paolo's patch is
the most appropriate here in an early part of the tutorial, as it teaches
how to view full histories leading to the tips of these two branches.

Earlier in the tutorial sequence we teach "gitk" without any parameter to
view the history of the current branch, and here the user learns one new
thing, to view more than just the current branch.

Limiting the output with "..origin/master" (or "...origin/master") can be
taught after demonstrating this most basic form.
