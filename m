From: Junio C Hamano <gitster@pobox.com>
Subject: Re: janitoring
Date: Wed, 22 Jul 2009 15:19:01 -0700
Message-ID: <7v7hy0cqei.fsf@alter.siamese.dyndns.org>
References: <1248298475-2990-1-git-send-email-madcoder@debian.org>
 <7vws60cr9m.fsf@alter.siamese.dyndns.org>
 <20090722220209.GE13823@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@madism.org>
X-From: git-owner@vger.kernel.org Thu Jul 23 00:19:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTk9f-00020i-IM
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 00:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002AbZGVWTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 18:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753868AbZGVWTL
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 18:19:11 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57166 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512AbZGVWTK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 18:19:10 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 63671101E8;
	Wed, 22 Jul 2009 18:19:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B2E03101E5; Wed,
 22 Jul 2009 18:19:04 -0400 (EDT)
In-Reply-To: <20090722220209.GE13823@artemis.corp> (Pierre Habouzit's message
 of "Thu\, 23 Jul 2009 00\:02\:09 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ACBBC874-770D-11DE-8FF4-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123801>

Pierre Habouzit <madcoder@madism.org> writes:

> On Wed, Jul 22, 2009 at 03:00:21PM -0700, Junio C Hamano wrote:
>> Pierre Habouzit <madcoder@debian.org> writes:
>> 
>> > [PATCH 1/3] janitor: use NULL and not 0 for pointers.
>> >
>> >   I really dislike the use of 0 when NULL is meant. This patch probably
>> >   fixes most of them. The biggest culprit is nedmalloc, but a few
>> >   remnants exist in plain git code.
>> 
>> I am not enthused about "fixing" borrowed foreign code, unless we know
>> that we are committed to support our fork.  My impression was that this
>> ned stuff was borrowed by the MinGW folks with the understanding that we
>> will slurp it with minimum modification and turn a blind eye to its
>> sub-par coding styles, so that it can be more easily updated from the
>> upstream?
>
> Okay, maybe the 2-3 hunks that don't apply to nedmalloc stuff can be
> saved though, do you want me to send an updated patch ?

No, I'll split out that part and queue the rest.

Thanks.
