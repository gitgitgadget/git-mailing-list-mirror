From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH 2/2 (v2)] reset: make the output more user-friendly.
Date: Mon, 17 Aug 2009 19:31:53 +0200
Message-ID: <vpqljlipcs6.fsf@bauges.imag.fr>
References: <7vvdl0kau4.fsf@alter.siamese.dyndns.org>
	<1249676676-5051-1-git-send-email-Matthieu.Moy@imag.fr>
	<1249676676-5051-2-git-send-email-Matthieu.Moy@imag.fr>
	<7viqgztj76.fsf@alter.siamese.dyndns.org>
	<vpq7hxeu4un.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 20:24:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md6sc-0002lS-Le
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 20:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757954AbZHQSYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 14:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757952AbZHQSYQ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 14:24:16 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51162 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757458AbZHQSYP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 14:24:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n7HHTDkM014277
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 17 Aug 2009 19:29:17 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Md63l-00035Z-Tn; Mon, 17 Aug 2009 19:31:53 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Md63l-0004WA-SV; Mon, 17 Aug 2009 19:31:53 +0200
In-Reply-To: <vpq7hxeu4un.fsf@bauges.imag.fr> (Matthieu Moy's message of "Sat\, 08 Aug 2009 09\:44\:48 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 17 Aug 2009 19:29:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n7HHTDkM014277
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1251134957.79976@nVd6Snelv/HNAAFTRLJGWw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126250>

[ back from holiday ]

Any opinion/update on this? I don't think I got any reply ...

Thanks,

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>>
>>>  cat > expect << EOF
>>> -file2: locally modified
>>> +Unstaged changes after reset:
>>> +M	file2
>>
>> It simply feels backwards when plumbing output says something in human
>> language (e.g. "needs update") while Porcelain output spits out a cryptic
>> M or U.  If the goal is human-readability and user-friendliness,
>
> The goal here is just consistency.
>
> And I do consider 'git diff --name-status' as porcelain.
>
>> shouldn't we rather say:
>>
>> 	Path with local modifications:
>>         	file2
>>
>> or something?
>
> Why not, but if we do, we should also remove this "M" from other
> places. It was already there in one error message given by 'git
> rebase' in a non-clean tree (and you just accepted a patch giving the
> same output for another one).

-- 
Matthieu
