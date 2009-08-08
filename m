From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH v2] push: point to 'git pull' and 'git push --force' in case of non-fast forward
Date: Sat, 08 Aug 2009 17:22:53 +0200
Message-ID: <vpqab2aqqia.fsf@bauges.imag.fr>
References: <1249579933-1782-1-git-send-email-Matthieu.Moy@imag.fr>
	<1249717868-10946-1-git-send-email-Matthieu.Moy@imag.fr>
	<87prb6r9d1.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Sat Aug 08 17:27:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZnps-00059o-Tt
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 17:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbZHHP1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 11:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752088AbZHHP1r
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 11:27:47 -0400
Received: from imag.imag.fr ([129.88.30.1]:57387 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752087AbZHHP1q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 11:27:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n78FMraA009220
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 8 Aug 2009 17:22:54 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MZnkz-0006ja-KN; Sat, 08 Aug 2009 17:22:53 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MZnkz-0003eC-Iz; Sat, 08 Aug 2009 17:22:53 +0200
In-Reply-To: <87prb6r9d1.fsf@iki.fi> (Teemu Likonen's message of "Sat\, 08 Aug 2009 11\:35\:38 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sat, 08 Aug 2009 17:22:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125281>

Teemu Likonen <tlikonen@iki.fi> writes:

> On 2009-08-08 09:51 (+0200), Matthieu Moy wrote:
>> 'git push' failing because of non-fast forward is a very common situation,
>> and a beginner does not necessarily understand "fast forward" immediately.
>
>> +		if (nonfastforward) {
>> +			printf("Push was rejected because it would not result in a fast forward:\n"
>> +			       "Merge in the remote changes (using git pull) before pushing yours,\n"
>> +			       "or use git push --force to discard the remote changes.\n"
>> +			       "See 'non-fast forward' section of 'git push --help' for details.\n");
>> +		}
>
> I'd like to add that some projects that use Git in (partially)
> centralized manner prefer "git pull --rebase" before "git push".

Right, but I don't think this error message is the place to discuss
that. Anything involving rebasing should be taken with care, and
pointing the user to it in a short sentence sounds like "try shooting
yourself in the foot, and read the man page if it hurts" ;-).

-- 
Matthieu
