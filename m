From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] parse-opt: migrate builtin-ls-files.
Date: Sat, 14 Feb 2009 12:04:44 -0800
Message-ID: <7vmycoss2r.fsf@gitster.siamese.dyndns.org>
References: <20090107144640.GD831@artemis.corp>
 <1231376145-32331-1-git-send-email-vmiklos@frugalware.org>
 <20090115001410.GE30710@genesis.frugalware.org>
 <7vljtdw961.fsf@gitster.siamese.dyndns.org>
 <20090214121631.GG4371@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Feb 14 21:06:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYQmJ-0006qO-48
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 21:06:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbZBNUEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 15:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751973AbZBNUEv
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 15:04:51 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59814 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbZBNUEu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 15:04:50 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3B9192B220;
	Sat, 14 Feb 2009 15:04:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 686372B21F; Sat,
 14 Feb 2009 15:04:46 -0500 (EST)
In-Reply-To: <20090214121631.GG4371@genesis.frugalware.org> (Miklos Vajna's
 message of "Sat, 14 Feb 2009 13:16:31 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BC6C6894-FAD2-11DD-82C5-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109913>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Wed, Jan 14, 2009 at 07:16:38PM -0800, Junio C Hamano <gitster@pobox.com> wrote:
>> Miklos Vajna <vmiklos@frugalware.org> writes:
>> 
>> > Was this dropped on the floor by accident?
>> 
>> I am not fundamentally opposed to the parseopt conversion, but I was
>> somewhat discouraged from taking another one, after we got burned by the
>> one that converted git-apply without much visible gain but with a new bug.
>> 
>> Because ls-files is a plumbing, it has somewhat lower priority for user
>> friendliness than any other patches currently in-flight on the list; hence
>> it has been backburnered.  It still is kept in my Inbox.
>
> I'm just asking again as I see the parseopt patch for builtin-config now
> on the list.
>
> Should I just resend this patch after v1.6.2?

You can do it either way, and a resend after v1.6.2 is certainly
appreciated,

As I said earlier in "What's cooking", 'pu' and 'next' are open during
this freeze cycle as an experiment.

I limit my bandwidth for handing anything non-fix during the rc freeze
period as always.  The only difference from previous cycles is that the
cap used to be set to near-absolute-zero, but in this cycle it is not.

It still is capped and updates to 'pu' and 'next' are "as time permits"
basis.
