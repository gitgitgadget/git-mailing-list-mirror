From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Subject: [PATCH] Push to create
Date: Tue, 03 Mar 2009 00:30:46 -0800
Message-ID: <7v1vtff1op.fsf@gitster.siamese.dyndns.org>
References: <1235865822-14625-3-git-send-email-gitster@pobox.com>
 <20090301031609.GA30384@coredump.intra.peff.net>
 <7v63itbxe7.fsf@gitster.siamese.dyndns.org>
 <20090301100039.GD4146@coredump.intra.peff.net>
 <20090301170436.GA14365@spearce.org>
 <7vwsb7gkvt.fsf_-_@gitster.siamese.dyndns.org>
 <20090303070937.GB30609@coredump.intra.peff.net>
 <7vy6vnf3aw.fsf@gitster.siamese.dyndns.org>
 <20090303080603.GA3158@coredump.intra.peff.net>
 <7v63irf21u.fsf@gitster.siamese.dyndns.org>
 <20090303082706.GC3158@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 09:32:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeQ35-0000ak-5o
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 09:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652AbZCCIaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 03:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753409AbZCCIay
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 03:30:54 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62284 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbZCCIax (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 03:30:53 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 36B8913BF;
	Tue,  3 Mar 2009 03:30:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 829D413BE; Tue, 
 3 Mar 2009 03:30:48 -0500 (EST)
In-Reply-To: <20090303082706.GC3158@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 3 Mar 2009 03:27:06 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9B4191F0-07CD-11DE-A4CC-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112030>

Jeff King <peff@peff.net> writes:

> But I think that coincides with what I was trying to say in my original
> response to the series, which is "this issue is complex, and we need to
> hear from the people who would really want this exactly what it is they
> want".

And we haven't heard from them at all, unless you and/or Shawn are
interested.  After all we may not have to worry about this at all ;-)

And that answers your question (1) in the other message.  The standard way
for users to create a repository becomes:

	mkdir this-new-directory
        cd this-new-directory
        git init
