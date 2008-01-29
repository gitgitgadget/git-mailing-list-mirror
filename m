From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fetch <repo> <branch>:<branch> fetches tags?
Date: Tue, 29 Jan 2008 00:54:42 -0800
Message-ID: <7vabmpovu5.fsf@gitster.siamese.dyndns.org>
References: <479E9063.5000403@nrlssc.navy.mil>
	<7v3ashs5yg.fsf@gitster.siamese.dyndns.org>
	<7vodb5qk2b.fsf@gitster.siamese.dyndns.org>
	<loom.20080129T055937-532@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 09:55:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJmFe-0002NR-Ee
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 09:55:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171AbYA2Iy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 03:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753135AbYA2Iyz
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 03:54:55 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56645 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509AbYA2Iyz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 03:54:55 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7619E3A7D;
	Tue, 29 Jan 2008 03:54:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 004053A7C;
	Tue, 29 Jan 2008 03:54:48 -0500 (EST)
In-Reply-To: <loom.20080129T055937-532@post.gmane.org> (Brandon Casey's
	message of "Tue, 29 Jan 2008 08:46:19 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71969>

Brandon Casey <drafnel@gmail.com> writes:

>> Having said that, I do not particularly think the new behaviour
>> is bad per-se.  If you are storing what you fetched locally in
>> tracking branches, you are interested in their work enough to
>> want to auto-follow their tags.
>
> How is "tracking" defined? Is this a term that implies some configuration
> to link a local branch to a remote branch? Or is any local branch created
> from a remote branch considered "tracking"?

I probably should have said "Instead of just letting fetch
temporarily store the result in FETCH_HEAD and using it from
there, you saved it away; that's a good indication of you care
about it deeply enough".

It's really about what's convenient.  I was somewhat upset that
the behaviour change was not I was very aware of (perhaps I said
it was a good idea and I then forgot), I didn't think the
earlier behaviour was broken, but if I have to choose, I think
the new behaviour is probably slightly nicer than the old one.
