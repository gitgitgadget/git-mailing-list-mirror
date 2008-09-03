From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] tests: use "git xyzzy" form
Date: Wed, 03 Sep 2008 14:22:05 -0700
Message-ID: <7vod359b7m.fsf@gitster.siamese.dyndns.org>
References: <20080903175925.6117@nanako3.lavabit.com>
 <48BE6D1F.1060603@op5.se> <7v8wu9athn.fsf@gitster.siamese.dyndns.org>
 <7vwsht9cw5.fsf@gitster.siamese.dyndns.org>
 <20080903205945.GA32413@coredump.intra.peff.net>
 <20080903210920.GA3199@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 03 23:23:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kazou-0006at-Ok
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 23:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbYICVWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 17:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752597AbYICVWO
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 17:22:14 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57305 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbYICVWN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 17:22:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CDCC97276A;
	Wed,  3 Sep 2008 17:22:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 944D772767; Wed,  3 Sep 2008 17:22:07 -0400 (EDT)
In-Reply-To: <20080903210920.GA3199@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 3 Sep 2008 17:09:20 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5FE290D0-79FE-11DD-8928-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94856>

Jeff King <peff@peff.net> writes:

> On Wed, Sep 03, 2008 at 04:59:45PM -0400, Jeff King wrote:
>
>> I just checked 1/4, which looks fine. Made much easier by the use of
>> --color-words (even easier with -U0, but sometimes the context is
>> helpful for seeing that it is correct).
>> 
>> In 2/4, we change some instances of git-upload-pack, which you otherwise
>> mentioned in your "should be left". It's in t5530 and t5602. Otherwise
>> looks fine.
>
> And 3/4 and 4/4 look fine to me, too.

Thanks, both.  All four patches queued (with the tweak I mentioned to the
test title of t5300 and t5305 in an earlier message).
