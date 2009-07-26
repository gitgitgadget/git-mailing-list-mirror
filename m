From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Add support for external programs for handling
 native fetches
Date: Sun, 26 Jul 2009 12:05:35 -0700
Message-ID: <7vljmbp8n4.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0907251330240.2147@iabervon.org>
 <alpine.LFD.2.01.0907251107500.3960@localhost.localdomain>
 <7viqhgrm1h.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907260901100.3960@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jul 26 21:05:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MV92c-0000mV-8J
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 21:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbZGZTFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 15:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752159AbZGZTFl
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 15:05:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:32948 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbZGZTFl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 15:05:41 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2F937125E4;
	Sun, 26 Jul 2009 15:05:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DBFE0125DD; Sun, 26 Jul 2009
 15:05:36 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.01.0907260901100.3960@localhost.localdomain>
 (Linus Torvalds's message of "Sun\, 26 Jul 2009 09\:06\:58 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4FEF9A8C-7A17-11DE-BCBE-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124134>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 25 Jul 2009, Junio C Hamano wrote:
>
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>> 
>> > So a very big Acked-by: from me for the series. I didn't test that http: 
>> > works with it, but I don't personally even care, so I'd ack it even 
>> > without that ;)
>> 
>> Heh, "git ls-remote http://..." segfaulting for me is not a very good
>> sign, but I like the concept.
>
> Hmm. Just tested. Works for me (git and kernel repos on kernel.org).

Interesting.

The version from 'pu' seems to work just fine (and I just double checked
that ldd says I do not link the main git binary with cURL library with
that version).  I saw the breakage when running the version from the topic
branch itself, but I do not seem to be able to reproduce it anymore.
