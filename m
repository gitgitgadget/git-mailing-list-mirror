From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 4/3] Add example git-vcs-p4
Date: Sun, 11 Jan 2009 22:29:48 -0800
Message-ID: <7viqoljaub.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0901110336380.19665@iabervon.org>
 <7vy6xhl1i7.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0901120026290.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jan 12 07:31:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMGKd-0000yO-5r
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 07:31:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbZALGaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 01:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbZALGaD
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 01:30:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33897 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbZALGaA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 01:30:00 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id AB6361C4B6;
	Mon, 12 Jan 2009 01:29:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8CAB71C4B3; Mon,
 12 Jan 2009 01:29:54 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0901120026290.19665@iabervon.org> (Daniel
 Barkalow's message of "Mon, 12 Jan 2009 00:41:19 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6FC28836-E072-11DD-966A-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105297>

Daniel Barkalow <barkalow@iabervon.org> writes:

>> vcs-p4.c:504: warning: ISO C90 forbids mixed declarations and code
>> make: *** [vcs-p4.o] Error 1
>
> I haven't been over the 4/3 stuff for coding style yet. But how do you get 
> these warnings?

I thought I have mentioned this already, but...

I compile with (at least) these:

    -Wno-pointer-to-int-cast
    -Wold-style-definition
    -Wdeclaration-after-statement

explicitly specified.

I also run kernel's checkpatch.pl script (but ignoring "more than 80-col
is too long" rule) from time to time.

I consider these are good ways to check style-discipline.
