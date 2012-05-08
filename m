From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] checkout: do not corrupt HEAD on empty repo
Date: Tue, 8 May 2012 18:43:07 +0200
Message-ID: <CABPQNSYLLSsfAumjk0_RGBPbbV4=vFWVFAn13ZLwq_vm01+M4Q@mail.gmail.com>
References: <1336493114-4984-1-git-send-email-kusmabite@gmail.com>
 <7v4nrqy6ur.fsf@alter.siamese.dyndns.org> <CABPQNSb-YPAa6qPtxeo1k-p-0REnk3soOTuPgABj9+s61o80VA@mail.gmail.com>
 <7vwr4mwrq6.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, j.sixt@viscovery.net, schwab@linux-m68k.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 08 18:43:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRnVx-0000yI-7F
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 18:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757186Ab2EHQnt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 12:43:49 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56807 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757046Ab2EHQns convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2012 12:43:48 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so8249790pbb.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 09:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=X09SeuWq392lQgXFdorRpYlzImkFf8+nkbREpXDy4/o=;
        b=Ib8Bc/ImNn9TwYTXvVfkf0vpVzk4Tv8Ux7xiFW6zKxpB8PtyI0QJaRbNz9UmmOgFDM
         Ou7702CtecVHS1/u0E890A6bHKR+/fTBKqoNP11FU9msyZPLUFbokK+EUnML8ojfi0Iw
         qSEZCylelZ3061R8t/Q+m6RgCOseUJ8i5Ya5gDNBZzfS+TZl4GKhcWEDzE/6uFhQPrCU
         fsR0vuFaAr0XTIDSKmRt+bxYRMsehyvyL7kyVUj8mW4RtwVPKyA1Rnlg02YiZo8YyhDz
         sC7m5EuCyWs26C0w+ZwXnztmCvLsTCx1X5Cq97U83NzNPGvpIPtttcDlK+6AmETILOlc
         8JCw==
Received: by 10.68.225.104 with SMTP id rj8mr44674375pbc.135.1336495428088;
 Tue, 08 May 2012 09:43:48 -0700 (PDT)
Received: by 10.68.73.65 with HTTP; Tue, 8 May 2012 09:43:07 -0700 (PDT)
In-Reply-To: <7vwr4mwrq6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197391>

On Tue, May 8, 2012 at 6:41 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>>> (or "are people expected to know what CRT you are talking about?")?
>>
>> Feel free to change it to "the C runtime", or even "the vsnprintf
>> implementation" if you feel like it :)
>
> Ahh, "C RunTime" was what you meant. =A0OK, it somehow immediately di=
d not
> "click".

It's the name we Windows users tend to use for what you unix-guys tend
to call "libc" ;)

Probably because Microsoft Visual C names their MSVCRT.dll.
