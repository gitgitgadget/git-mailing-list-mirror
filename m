From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add warning about known issues to documentation of
 cvsimport
Date: Mon, 30 Mar 2009 17:51:53 -0700
Message-ID: <7v4oxaa506.fsf@gitster.siamese.dyndns.org>
References: <20090323195304.GC26678@macbook.lan>
 <20090324031448.GA12829@coredump.intra.peff.net>
 <20090330223646.GC68118@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 02:54:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoSEu-0000As-A9
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 02:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756706AbZCaAwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 20:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753641AbZCaAwG
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 20:52:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57200 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756842AbZCaAwF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 20:52:05 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3C467A6052;
	Mon, 30 Mar 2009 20:52:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 23AC0A6051; Mon,
 30 Mar 2009 20:51:55 -0400 (EDT)
In-Reply-To: <20090330223646.GC68118@macbook.lan> (Heiko Voigt's message of
 "Tue, 31 Mar 2009 00:36:46 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 25126690-1D8E-11DE-8D3B-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115203>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> On Mon, Mar 23, 2009 at 11:14:48PM -0400, Jeff King was talking about:
>> On Mon, Mar 23, 2009 at 08:53:05PM +0100, Heiko Voigt wrote:
>> 
>> > The described issues are compiled from the tests by Michael Haggerty and me.
>> > Because it is not apparent that these can be fixed anytime soon at least warn
>> > unwary users not to rely on the inbuilt cvsimport to much.
>> 
>> I think this change is good in concept.
>> 
>> > +[[issues]]
>> > +ISSUES
>> > +------
>> > +Problems related to timestamps:
>> > +
>> > + * If timestamps of commits in the cvs repository are not stable enough
>> > +   to be used for ordering commits
>> > + * If any files were ever "cvs import"ed more than once (e.g., import of
>> > +   more than one vendor release)
>> > + * If the timestamp order of different files cross the revision order
>> > +   within the commit matching time window
>> 
>> Reading this, I kept waiting for the "then" to your "if". I think the
>> implication is "your import will be incorrect". But it would be nice to
>> say _how_, even if it's something as simple as "changes may show up in
>> the wrong commit, the wrong branch, be omitted" or whatever. Just give a
>> general idea of what can happen.
>
> You are right, I actually wanted to update my patch but as I've seen
> today my patch already made it into master. So I guess I will prepare an
> update patch to address these issues.

Thanks.
