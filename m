From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add tests for git log --pretty, --format and --oneline.
Date: Wed, 25 Feb 2009 02:16:40 -0800
Message-ID: <7vljru4y9j.fsf@gitster.siamese.dyndns.org>
References: <7vljrvhh13.fsf@gitster.siamese.dyndns.org>
 <1235509597-18336-1-git-send-email-felipe.contreras@gmail.com>
 <7vtz6i4zah.fsf@gitster.siamese.dyndns.org>
 <20090225095741.GB16357@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 25 11:18:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcGqJ-0001vq-VZ
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 11:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760557AbZBYKQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 05:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755715AbZBYKQt
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 05:16:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33645 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760283AbZBYKQs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 05:16:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C8F481790;
	Thu, 26 Feb 2009 05:16:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0977E178F; Thu,
 26 Feb 2009 05:16:40 -0500 (EST)
In-Reply-To: <20090225095741.GB16357@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 25 Feb 2009 04:57:41 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 923B0F10-03EE-11DE-AD54-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111437>

Jeff King <peff@peff.net> writes:

> On Wed, Feb 25, 2009 at 01:54:30AM -0800, Junio C Hamano wrote:
>
>> Because 4202 seems to be about testing the log functionality and they rely
>> on correctly working format output to verify other aspects of the
>> operation of "git log", I initially was not sure if this is the right
>> place to add these new tests.  After looking around I didn't find any
>> existing test that checks the various --pretty output formats that the new
>> tests can be added, so this probably is as good a place as any.
>
> t6006?

Good eyes.  But sorry I've already queued the four patches to 'next' and
pushed the result out.  It probably is not worth moving the tests between
two files as a follow-up patch.
