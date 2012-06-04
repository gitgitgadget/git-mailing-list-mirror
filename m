From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/3] api-credentials.txt: mention credential.helper explicitly
Date: Mon, 04 Jun 2012 19:51:33 +0200
Message-ID: <vpqehpvrmmy.fsf@bauges.imag.fr>
References: <1338739804-32167-1-git-send-email-Matthieu.Moy@imag.fr>
	<1338739804-32167-3-git-send-email-Matthieu.Moy@imag.fr>
	<20120604115442.GB27676@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 04 19:51:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbbRV-0004Y3-2d
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 19:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754824Ab2FDRvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 13:51:45 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45595 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754478Ab2FDRvo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 13:51:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q54Hh1gJ005079
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 4 Jun 2012 19:43:01 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SbbRG-0007Ct-4W; Mon, 04 Jun 2012 19:51:34 +0200
In-Reply-To: <20120604115442.GB27676@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 4 Jun 2012 07:54:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 04 Jun 2012 19:43:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q54Hh1gJ005079
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339436582.26161@Llc2wYpxlDl+ZSeiOPJ1WA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199162>

Jeff King <peff@peff.net> writes:

> On Sun, Jun 03, 2012 at 06:10:03PM +0200, Matthieu Moy wrote:
>
>> --- a/Documentation/technical/api-credentials.txt
>> +++ b/Documentation/technical/api-credentials.txt
>> @@ -179,7 +179,8 @@ credentials from and to long-term storage (where "long-term" is simply
>>  longer than a single git process; e.g., credentials may be stored
>>  in-memory for a few minutes, or indefinitely on disk).
>>  
>> -Each helper is specified by a single string. The string is transformed
>> +Each helper is specified by a single string in the configuration
>> +variable credential.helper. The string is transformed
>>  by git into a command to be executed using these rules:
>
> They may be in other variables, too (like credential.*.helper). I don't
> know if it is worth making that distinction.
>
> Originally, helpers could also use these specification strings to chain
> to each other, but in the current implementation, there is no chaining
> (it was more important when prompting wasn't automatic, so storage
> helpers would chain to prompting helpers). So I think we can disregard
> that for now, and they really do just appear in config.

I'd say it is not worth making the distinction, but we may just say
"in the configuration variable credential.helper (and others, see
linkgit:../git-config.txt[1])" to be complete.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
