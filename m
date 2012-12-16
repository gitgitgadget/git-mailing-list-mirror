From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v6 0/7] make test output coloring more intuitive
Date: Sun, 16 Dec 2012 19:01:56 +0000
Message-ID: <CAOkDyE9B_HfUZmqNqO35mtjTvdihBTiW=uOV2oEQgLUw1xyf=A@mail.gmail.com>
References: <1355682495-22382-1-git-send-email-git@adamspiers.org>
	<7v8v8xrfnp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 20:02:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkJTd-0004d5-2A
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 20:02:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066Ab2LPTB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 14:01:59 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:56463 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632Ab2LPTB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 14:01:58 -0500
Received: by mail-we0-f174.google.com with SMTP id x10so2357504wey.19
        for <git@vger.kernel.org>; Sun, 16 Dec 2012 11:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Uq5W2AR6CHkx4qr90pig1QuTX3bGP+aD3ZJivQAlG+A=;
        b=Kdqcx7A3IkC3x5tC/PwTigUYYZMzSA7frZLAO14OMeImpZ897j/U2EHHRoxrOKpMnt
         xMV66mblfnG730OpetrCLRK6GF5bXA/ecSKvefgK9oIAz2frvmWIUrwFZkeg3aGzrJ+O
         et0xeOigHxBq2t5ipkxh0TGGr8j5G8SFaQ4fuM+efjXDz3Tzb0d3zOX2mZ2qCxJM6UCM
         WFScCcM2Lyq+CFjZlNT0iBNO4UeJDgKDzJhw3BK28RuZr5eFes+cnwXjap4sUxUZ41dX
         nxVbuphN9MDCV/d0qStAzWZdY3sWYsUqb1bZodLlOtGT3RnMZVMyU4OR9pIeyA4Ppc/n
         NZsw==
Received: by 10.180.102.40 with SMTP id fl8mr11916833wib.22.1355684516709;
 Sun, 16 Dec 2012 11:01:56 -0800 (PST)
Received: by 10.194.56.232 with HTTP; Sun, 16 Dec 2012 11:01:56 -0800 (PST)
In-Reply-To: <7v8v8xrfnp.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: XVrj4IPBA7xNZYSLi3zzgj35u9c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211604>

On Sun, Dec 16, 2012 at 6:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Adam Spiers <git@adamspiers.org> writes:
>
>> This series of commits attempts to make test output coloring
>> more intuitive,...
>
> Thanks; I understand that this is to replace the previous one
> b465316 (tests: paint unexpectedly fixed known breakages in bold
> red, 2012-09-19)---am I correct?

Correct.  AFAICS I have incorporated all feedback raised in previous
reviews.

> Will take a look; thanks.

Thanks.  Sorry again for the delay.  I'm now (finally) resuming work
on as/check-ignore.
