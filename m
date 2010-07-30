From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] Document -B<n>[/<m>], -M<n> and -C<n> variants of -B, -M and -C
Date: Fri, 30 Jul 2010 17:23:19 +0200
Message-ID: <vpqmxt93sew.fsf@bauges.imag.fr>
References: <1280310239-16897-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vk4oeuv4b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 30 17:24:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OerRf-0004Xz-7q
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 17:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213Ab0G3PYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 11:24:17 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49979 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945Ab0G3PYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 11:24:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o6UFLSTM030949
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 30 Jul 2010 17:21:28 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OerQd-00067r-Vg; Fri, 30 Jul 2010 17:23:19 +0200
In-Reply-To: <7vk4oeuv4b.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 29 Jul 2010 09\:10\:28 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 30 Jul 2010 17:21:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6UFLSTM030949
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1281108088.77374@F+4fpM0FEmE0xbJZe2n52w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152247>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> I'm not really happy with my description of -Bn/m, which I essentially
>> took from eeaa46031479 (Junio, Jun 3 2005, diff: Update -B
>> heuristics). Someone with better understanding of how it works can
>> probably propose something better.
>
> Your explanation for '<n>' being the same across -B/-M/-C is reasonable.
> Explanation of '<m>' might want to clarify why it counts only the deletion
> and to mention that "100-similarity != dissimilarity", but as the end-user
> level documentation, these probably are unnecessary.

The thing is: I don't know the anwser myself, so I'm not in a position
do write such documentation :-(.

>> +-B[<n>]::
>> +-B<n>/<m>::
>>  	Break complete rewrite changes into pairs of delete and create.
>> +	If `n` is specified, it gives the threshold (as a percentage
>> +	of changed lines) above which a change is considered as
>> +	complete rewrite.  For example, `-B90%` means git will detect a
>> +	rewrite if more than 90% of the lines have been modified. ...
>
> I am fine with the use of word "lines" if it is clear that we are giving a
> simplified explanation (white lie) to the readers, but the (dis)similarity
> numbers don't have much to do with "lines".

Likewise, I didn't write "lines" as a white lie, but because of my
ignorance ... hence my request for help.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
