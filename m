From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fetch <repo> <branch>:<branch> fetches tags?
Date: Mon, 28 Jan 2008 21:26:04 -0800
Message-ID: <7vodb5qk2b.fsf@gitster.siamese.dyndns.org>
References: <479E9063.5000403@nrlssc.navy.mil>
	<7v3ashs5yg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Jan 29 06:27:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJizr-00069X-1d
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 06:26:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbYA2F01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 00:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752627AbYA2F01
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 00:26:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48266 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbYA2F00 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 00:26:26 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CF3E42564;
	Tue, 29 Jan 2008 00:26:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AAAA253F;
	Tue, 29 Jan 2008 00:26:20 -0500 (EST)
In-Reply-To: <7v3ashs5yg.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 28 Jan 2008 18:47:51 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71947>

Junio C Hamano <gitster@pobox.com> writes:

> Brandon Casey <casey@nrlssc.navy.mil> writes:
> ...
>> I expect these to _not_ fetch tags (and they don't):
>>
>>    git fetch <repo> <branch>
>>    git pull <repo> <branch>
>>
>> But, I did not expect these to fetch tags:
>>
>>    git fetch <repo> <branch>:<branch>
>>    git pull <repo> <branch>:<branch>
>
> Sigh... that matches my expectation.
>
> Did we break it when we overhauled "git fetch", or was this an
> independent "improvement" that happened long before that?

Having said that, I do not particularly think the new behaviour
is bad per-se.  If you are storing what you fetched locally in
tracking branches, you are interested in their work enough to
want to auto-follow their tags.

It's just that the expectation you and I shared is the
documented behaviour everywhere, and we would need to document
the new behaviour.
