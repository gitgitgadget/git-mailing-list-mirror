From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] builtin-apply: use warning() instead of
 fprintf(stderr, "warning: ")
Date: Sun, 22 Mar 2009 14:58:46 -0700
Message-ID: <7v3ad5dxt5.fsf@gitster.siamese.dyndns.org>
References: <200902190736.49161.johnflux@gmail.com>
 <20090219081725.GB7774@coredump.intra.peff.net>
 <20090219120708.GM4371@genesis.frugalware.org>
 <20090219122104.GA4602@sigill.intra.peff.net>
 <4f61642d10063adbff86094e91b1b6e90efabe8e.1235047192.git.vmiklos@frugalware.org> <20090220030245.GC22419@coredump.intra.peff.net> <7viqn5iqnn.fsf@gitster.siamese.dyndns.org> <20090322113646.GL27459@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Mar 22 23:00:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlVif-0002AY-SF
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 23:00:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756020AbZCVV64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 17:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755983AbZCVV6z
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 17:58:55 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48244 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755852AbZCVV6y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 17:58:54 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1B92089C7;
	Sun, 22 Mar 2009 17:58:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5F78489C5; Sun,
 22 Mar 2009 17:58:48 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A1F75750-172C-11DE-B38D-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114180>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Thu, Feb 19, 2009 at 10:11:24PM -0800, Junio C Hamano <gitster@pobox.com> wrote:
>> Jeff King <peff@peff.net> writes:
>> 
>> > Other than that, these all look pretty straightforward. Probably the
>> > shell scripts should be switched to match, too. But it would be nice to
>> > hear from Junio first that this cleanup is even desired (so you don't
>> > waste time).
>> 
>> I think it is a good thing to do.  If the pre-release-freeze is a good
>> time to do so it is a different matter.  A good way to judge would be 
>> how much of these overlap with "git diff master next" (smaller the better,
>> obviously).
>
> Should I rebase the series against current master and resend?

Yes, please, if the overlap with "diff master next" is small enough.
