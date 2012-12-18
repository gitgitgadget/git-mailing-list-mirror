From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH 1/2] Documentation/git-checkout.txt: clarify usage
Date: Mon, 17 Dec 2012 20:55:56 -0600
Message-ID: <CAEUsAPZHsTh77VJxzg9uetGuGbipJ-E3iCc=NU3-KmtoEr4wdg@mail.gmail.com>
References: <1355726702-27974-1-git-send-email-chris@rorvick.com>
	<1355726702-27974-2-git-send-email-chris@rorvick.com>
	<7vhanlnnz7.fsf@alter.siamese.dyndns.org>
	<50CED5D4.5040705@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	Woody Wu <narkewoody@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Dec 18 04:04:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TknTW-00074f-HP
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 04:04:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286Ab2LRDDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 22:03:53 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:51273 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253Ab2LRDDw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 22:03:52 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so84720lag.19
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 19:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=w/xeLc/QirFNBiwpYBVLOWT18EPwI+WOWEdcjKsx3dY=;
        b=eOIc1+AR7qmM516NsgdklO1FXFvUYeJQPaMfoObfVOZPQsBb6qW9kAVG77VuXgRFhJ
         ikmuyjbflwa2Pwbq8lGFqpAebSfocThs9Nj+2h7G1wo6lilqqsqImeqv1F/A8f4QAL3T
         VEzG+orcUaph3BZqAqJPQX5lI/Ev5o5CLqJWNm9OI1jw+K7X7DvVZ6uFaMWaayyiTVd0
         EyJuM/mswmUaqn2UT3Mk9Wvp+CaxdTenzGebQrEtIopu/S5MvIrh4UybWS80yulwA0Tm
         9YjMliufADmlKz1f0XgIzSN8atm6OF76NMmBc0erTSzJG4SAIrdxR/zlt807OGBkMfPq
         nmOw==
Received: by 10.152.111.41 with SMTP id if9mr428997lab.23.1355799356693; Mon,
 17 Dec 2012 18:55:56 -0800 (PST)
Received: by 10.114.94.131 with HTTP; Mon, 17 Dec 2012 18:55:56 -0800 (PST)
In-Reply-To: <50CED5D4.5040705@viscovery.net>
X-Google-Sender-Auth: RwDyqGMpGOXZ9PaEDj03vDLRWGg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211732>

On Mon, Dec 17, 2012 at 2:20 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>> +'git checkout' [--detach] [<commit>]::
>
> The title here is better spelled as two lines:
>
> 'git checkout' <commit>::
> 'git checkout' --detach <branch>::

AsciiDoc renders these horizontally separated by a comma when
formatted as a man page instead of vertically as written (and as
rendered by the HTML documentation.)  I think this makes this
separation into two less effective, but at least it doesn't line wrap
on an 80-wide terminal like the previous title did.

Chris
