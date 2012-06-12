From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] api-credential.txt: document that helpers field is filled-in automatically
Date: Tue, 12 Jun 2012 11:39:41 +0200
Message-ID: <vpq7gvcx40y.fsf@bauges.imag.fr>
References: <7vzk897rqi.fsf@alter.siamese.dyndns.org>
	<1339437107-25909-1-git-send-email-Matthieu.Moy@imag.fr>
	<20120611190811.GB20889@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 11:39:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeNZu-00068c-PW
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 11:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621Ab2FLJjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 05:39:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48194 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876Ab2FLJjx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 05:39:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5C9Ukas015742
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 12 Jun 2012 11:30:46 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SeNZe-0008Jp-RU; Tue, 12 Jun 2012 11:39:42 +0200
In-Reply-To: <20120611190811.GB20889@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 11 Jun 2012 15:08:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 12 Jun 2012 11:30:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5C9Ukas015742
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340098248.44908@67hZHc3xDkqQytBszHX2mw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199777>

Jeff King <peff@peff.net> writes:

> On Mon, Jun 11, 2012 at 07:51:47PM +0200, Matthieu Moy wrote:
>
>> It was unclear whether the field was to be specified by the user of the
>> API.
>> 
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
>> > It is correct that the C API asks helpers that the user configured,
>> > but I think it is common across three API functions, not limited to
>> > credential_fill().  credential_apply_config() is called from approve
>> > and reject, too.
>> 
>> Ah, right, so compared to v1, we can move the sentence to the
>> description of the "helpers" field, like this:
>
> I think this is OK. Technically it loads other matching config, as well
> (filling in default username fields and respecting useHttpPath). I don't
> know if it is worth mentioning them, too.

Probably not, but I don't care much here. The "helpers" field was
particular in that by reading the documentation, I first thought that
the caller may have a reason to fill-in this field.

>> -helpers below.
>> +helpers below. This list is filled-in by the API functions
>> +according to the corresponding configuration variables before
>> +consulting helpers.
>
> You might want to say something like "...and therefore there is usually
> no need for a caller to modify the helpers field at all".

Agreed. I see that Junio already has this fixup in pu. Junio, let me
know if you prefer a resend.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
