From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH] Teach rebase to rebase even if upstream is up to date 
	with -f
Date: Fri, 13 Feb 2009 00:24:14 +0100
Message-ID: <bd6139dc0902121524o776703bdw1bb199caecbc9c21@mail.gmail.com>
References: <1234468061-29923-1-git-send-email-srabbelier@gmail.com>
	 <7vbpt7jq4c.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0902121357l1eea7b8xe890513b756e97c2@mail.gmail.com>
	 <7viqnfi6la.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailinglist <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <normalperson@yhbt.net>,
	"Shawn O. Pear, Sverre Rabbelier <srabbelier@gmail.com>"@b-sasl-quonix.sasl.smtp.pobox.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 00:25:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXkwC-0002gU-N5
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 00:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755359AbZBLXYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 18:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753779AbZBLXYR
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 18:24:17 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:41442 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbZBLXYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 18:24:16 -0500
Received: by fg-out-1718.google.com with SMTP id 16so317361fgg.17
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 15:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=4OzgPGEDcyEK9cQQPCj4xgq/vhF/CjFqbmSkYxg9bXo=;
        b=vYStAU7dJWIO9IsIAtpjAh/REcu8NnnpWpk8fX1ez7qY3WpwJ4ZuiOwbGf4cErUE8U
         BDJV3m/K5X686Nye6jXdK5Ks1xG4LFqvfU/g8AuuV0yp3m0cV5B60xA6AHno0SAof8x6
         J5iM8unGEmBojbeeAE23MxqcM/5ylvkjZGGzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=n0R5Z1BOqdhLZ8p8j8CBIoAl3bdJWp+rHWtHFiJc598RlxLihJytfNGAy3n7G8moDv
         gsVjwLq1Qyz8LEsqdekdmTxnup21iXSQQALhq5B2UaV6UQAnG9NJvuC6835srErm34Fy
         lVIhETFkoFWWzVGMSnJXqqblgFm4sMdSDKyes=
Received: by 10.86.4.2 with SMTP id 2mr254517fgd.49.1234481054776; Thu, 12 Feb 
	2009 15:24:14 -0800 (PST)
In-Reply-To: <7viqnfi6la.fsf@gitster.siamese.dyndns.org>
X-Google-Sender-Auth: b5e9e0bfb2230df4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109681>

On Fri, Feb 13, 2009 at 00:22, Junio C Hamano <gitster@pobox.com> wrote:
> No, because I didn't read the patch text; I don't read patches that are
> larger than 20 lines during the day-job hours.

Hehe, that sounds like a fair policy.

> I was only commenting on your "rebase does not work if I am up to date
> with respect to origin and here is my workaround".

Ok, thanks for the comment then, I'll wait for more comment and maybe
write some tests tomorrow.

-- 
Cheers,

Sverre Rabbelier
