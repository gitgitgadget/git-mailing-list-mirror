From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a documentat on how to revert a faulty merge
Date: Sat, 20 Dec 2008 18:37:11 -0800
Message-ID: <7vocz6tfs8.fsf@gitster.siamese.dyndns.org>
References: <20081220202702.6117@nanako3.lavabit.com>
 <200812201612.37455.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Sun Dec 21 03:38:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEEDR-0003FQ-Ek
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 03:38:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbYLUChS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 21:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbYLUChS
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 21:37:18 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51275 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbYLUChR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 21:37:17 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B05E189107;
	Sat, 20 Dec 2008 21:37:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C757B89106; Sat,
 20 Dec 2008 21:37:12 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 48167D72-CF08-11DD-A858-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103682>

"Boyd Stephen Smith Jr." <bss@iguanasuicide.net> writes:

> On Saturday 2008 December 20 05:27:02 Nanako Shiraishi wrote:
>> +Date: Fri, 19 Dec 2008 00:45:19 -0800
>> +From: Linus Torvalds <torvalds@linux-foundation.org>, Junio C Hamano
>> <gitster@pobox.com> +Subject: Re: Odd merge behaviour involving reverts
>> +Abstract: Sometimes a branch that was already merged to the mainline
>> + is later found to be faulty.  Linus and Junio give guidance on
>> + recovering from such a premature merge and continuing development
>> + after the offending branch is fixed.
>> +Message-ID: <7vocz8a6zk.fsf@gitster.siamese.dyndns.org>
>> +References: <alpine.LFD.2.00.0812181949450.14014@localhost.localdomain>
>> +
>> +Alan <alan@clueserver.org> said:
>
> I don't like the email headers as part of the documentation.  It would be 
> better to have a title and abstract in prose.

The above follows the style of other files in Documentation/howto; if you
look at the build procedure of howto-index, you will notice that some of
these are required part of the documentation.

> Also, your email gave me some errors from 'git am':
> .dotest/patch:40: indent with spaces.
>                /

That is "C program source" rules in action.

I thought we had .gitattributes set up in Documentation/ area that applies
different rules to these?  Maybe they have not been tested with things in
howto.  
