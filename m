From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-apply: keep information about files to be
 deleted
Date: Sat, 18 Apr 2009 12:56:19 -0700
Message-ID: <7vws9hviqk.fsf@gitster.siamese.dyndns.org>
References: <1239478260-7420-1-git-send-email-michal.kiedrowicz@gmail.com>
 <7v4owsfktw.fsf@gitster.siamese.dyndns.org>
 <20090413230351.7cbb01f5@gmail.com>
 <7v1vrwdyxx.fsf@gitster.siamese.dyndns.org>
 <20090417192324.3a888abf@gmail.com>
 <7vskk6y2tl.fsf@gitster.siamese.dyndns.org> <49E9B90F.8070204@op5.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
	git@vger.kernel.org
To: Andreas Ericsson <exon@op5.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 21:58:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvGfp-0006VQ-Uq
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 21:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561AbZDRT40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 15:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752244AbZDRT40
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 15:56:26 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39499 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607AbZDRT4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 15:56:25 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A666510B48;
	Sat, 18 Apr 2009 15:56:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EF61910B44; Sat,
 18 Apr 2009 15:56:20 -0400 (EDT)
In-Reply-To: <49E9B90F.8070204@op5.com> (Andreas Ericsson's message of "Sat,
 18 Apr 2009 13:27:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FF1A9740-2C52-11DE-BBBB-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116862>

Andreas Ericsson <exon@op5.com> writes:

>> There are two stances we can take:
>>
>>  (1) The user knows what he is doing.
>>
>>      In the first example, if he wanted the change in #3 to end up in B,
>>      he would have arranged the patches in a different order, namely, 3 1
>>      2, but he didn't.  We should modify A (that came from C).
>>
>
> This gets my vote. Standard "diff -u" patches have always had to be
> numbered properly if they have even the slightest chance of interfering
> with each other, so developers are already used to it.

You stripped the more important part from the quote, where I describe why
this would not work well for the second situation.  Without addressing it,
how could you possibly vote?
