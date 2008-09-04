From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Are more and more patches getting lost lately?
Date: Thu, 04 Sep 2008 02:00:27 -0700
Message-ID: <7v8wu85lqs.fsf@gitster.siamese.dyndns.org>
References: <7vd4jk8r78.fsf@gitster.siamese.dyndns.org>
 <20080904083343.6117@nanako3.lavabit.com>
 <20080904172059.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 11:02:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbAik-0007I7-0H
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 11:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543AbYIDJAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 05:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752326AbYIDJAf
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 05:00:35 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33729 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbYIDJAe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 05:00:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9F332724F5;
	Thu,  4 Sep 2008 05:00:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B0EBE724F4; Thu,  4 Sep 2008 05:00:29 -0400 (EDT)
In-Reply-To: <20080904172059.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Thu, 04 Sep 2008 17:20:59 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EE1E3B68-7A5F-11DD-8715-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94909>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>:
>
>> Nanako Shiraishi <nanako3@lavabit.com> writes:
>>
>>> I noticed that recently there are many patches sent to the list
>>> that are left unapplied (and many of them are from you).  Many
>>> of them look useful or at least promising to become useful.
>>
>> Geez.  Well,... thanks.
>>
>> Do you have particular ones in the list that you really want to see
>> in-tree early, do you want all of them, or what?
>
> Your "diff --quiet" and Petr's bash completion.

I do not recall what the status of "diff --quiet" thing was when the
discussion petered off.  I'll have to dig it up later.

I've queued the bash completion from Pasky.

> Also there are many patches that are from *you*.  Did you forget to apply
> them, are they buggy, or are they in any way bad?
>
> From: Junio C Hamano <gitster@pobox.com>
> Subject: Re: [PATCH] Enable git rev-list to parse --quiet
> Date: Thu, 17 Jul 2008 23:10:19 -0700
> Message-ID: <7vy73zd8ok.fsf@gitster.siamese.dyndns.org>
>
> http://article.gmane.org/gmane.comp.version-control.git/88994

Be reasonable -- that's more than 5 minutes ago.

'rev-list --check-empty $args' would be equivalent to 'test -z "$(rev-list
-1 $args)"'; I am not interested in it myself, and original requestor went
away.  I have been assuming that it is not worth our time to worry about
it if the change is not even necessary by somebody who brought it up
originally.

> From: Junio C Hamano <gitster@pobox.com>
> Subject: [PATCH/RFC] feeding Maildir to git-am
> Date: Tue, 19 Aug 2008 22:25:57 -0700
> Message-ID: <7vbpzotfyy.fsf@gitster.siamese.dyndns.org>
>
> http://article.gmane.org/gmane.comp.version-control.git/92963

I wanted to see more positive feedback or better alternatives from people
who do deal with Maildir, especially because I do not use Maildir
anywhere.  Again, the discussion seems to have petered out, so...

> From: Junio C Hamano <gitster@pobox.com>
> Subject: Re* [PATCH] git-apply - Add --include=PATH
> Date: Mon, 25 Aug 2008 01:05:31 -0700
> Message-ID: <7vhc99h644.fsf@gitster.siamese.dyndns.org>
>
> http://article.gmane.org/gmane.comp.version-control.git/93604

IIRC, the patch was in a good shape but without documentation and tests.
I suspect reassembling the pieces from the mailing list archive into an
appliable e-mail submission would have been trivial, if somebody cared
deeply enough, but nothing came out of it.
