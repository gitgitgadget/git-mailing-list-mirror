From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH 1/2] pull: respect rebase.autostash
Date: Fri, 14 Jun 2013 07:59:16 -0400
Message-ID: <CABURp0rFtp0O0RTMmZUxmsHLu15Swg6SSex-H3NvsnR0QkRvvw@mail.gmail.com>
References: <1371200178-9927-1-git-send-email-artagnon@gmail.com>
 <1371200178-9927-2-git-send-email-artagnon@gmail.com> <vpqfvwlkqb5.fsf@anie.imag.fr>
 <CALkWK0n4QXsRNQxiSfeoPRdwp6kva8V08oG0h9Ld7TpBTgKDKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 13:59:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnSfR-0006qt-KV
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 13:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477Ab3FNL7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 07:59:37 -0400
Received: from mail-vb0-f48.google.com ([209.85.212.48]:38547 "EHLO
	mail-vb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337Ab3FNL7g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 07:59:36 -0400
Received: by mail-vb0-f48.google.com with SMTP id w15so351654vbf.7
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 04:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OOvPa3vUkDq3zi1fI1nTdqfmKsrwevtTLen4MNHZ2lA=;
        b=QMrvZ55+Haow18ltUgoFAN2PUmGU+W4bbaE8Q7qUDOtn68JrKATYEdMB+O/vwN+lYO
         itU7L6MQ7ihaGZbGt66orevXCHHPdcUipjyg9UiX1Dx145wKU2PawV1YTrBZZ7UaIoV4
         70sk+PtYSFxhWDnJbobhbF4GkgGGmUT1n47NCZ/ioSJQN5YeIr4dB+DGBCQJwconm0od
         C50/jDsCfT/crmMmfQtOsq9IGmVf3hJV2Di+gSOlb8SrqBfWbn8Oe8wuFOxSnjT4oZNp
         T5XwNihNZlPKy9pmYoDSy4lJMSi1/mXYdVdD30cusev7mpCArmqETYB0dS4ohbMze/a1
         847w==
X-Received: by 10.220.48.73 with SMTP id q9mr808128vcf.36.1371211176273; Fri,
 14 Jun 2013 04:59:36 -0700 (PDT)
Received: by 10.58.243.34 with HTTP; Fri, 14 Jun 2013 04:59:16 -0700 (PDT)
In-Reply-To: <CALkWK0n4QXsRNQxiSfeoPRdwp6kva8V08oG0h9Ld7TpBTgKDKA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227812>

On Fri, Jun 14, 2013 at 6:41 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Matthieu Moy wrote:
>> It would be nice to have an --autostash command-line option too,
>
> I thought it would be a bit ugly, since it's already overloaded with
> options to pass to merge.

Eventually I think a switch will be needed.  At least there is
   git -c rebase.autostash=false

But we will probably need to also have --no-autostash for scripts and users.


Phil
