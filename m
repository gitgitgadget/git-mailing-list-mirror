From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] New command: 'git snapshot'.
Date: Tue, 10 Feb 2009 15:08:31 -0800
Message-ID: <7vy6wdkhzk.fsf@gitster.siamese.dyndns.org>
References: <38cfbb550902091054u78f2e706u67752b4dc9de6c3b@mail.gmail.com>
 <etsYQzEDjdk-_NxhvO3i6EyShR6eZ202GBdQx7ZZpPHH5iNfWiuV6g@cipher.nrlssc.navy.mil> <38cfbb550902101240x1202c592ra7eb01d66e22da43@mail.gmail.com> <20090210230054.GD26954@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fabio Augusto Dal Castel <fdcastel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 11 00:10:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX1k2-0008SW-Hh
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 00:10:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756101AbZBJXIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 18:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756005AbZBJXIn
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 18:08:43 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59790 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755754AbZBJXIm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 18:08:42 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D3FE22ADBB;
	Tue, 10 Feb 2009 18:08:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 91DB72AD81; Tue,
 10 Feb 2009 18:08:33 -0500 (EST)
In-Reply-To: <20090210230054.GD26954@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 10 Feb 2009 18:00:54 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C0F07594-F7C7-11DD-92FF-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109336>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 10, 2009 at 06:40:34PM -0200, Fabio Augusto Dal Castel wrote:
>
>> > If stashes were per-branch, then it would probably
>> > be pretty easy to build this snapshot tool on top of it.
>> 
>> Or the other way around <g>.
>> 
>> Remember that 'stash' is actually TWO commands in one:
>> * Save current state
>> * Reset to HEAD
>> 
>> My primary reason to use snapshots is to AVOID the second step.
>
> Doesn't that argue for "git stash --no-reset" or similar instead of a
> separate command?

How is it different from "git stash create"?
