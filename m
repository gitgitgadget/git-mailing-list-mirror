From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] send-mail: Add option to sleep between sending each email.
Date: Mon, 12 Sep 2011 11:04:44 +0530
Message-ID: <CALkWK0=CT_vsWZ6K_DhrL8rNcCEK-Hr9E_t3pgVdhkss4Oi0yg@mail.gmail.com>
References: <1315428191-9769-1-git-send-email-gf@unixsol.org>
 <CALkWK0kH+pD6ymtt9oWLhT0Bftp4EvtrwTtNVw6mjX0aObb-BQ@mail.gmail.com>
 <vpq7h5jtngj.fsf@bauges.imag.fr> <7vbouvx8j5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Georgi Chorbadzhiyski <gf@unixsol.org>,
	Git List <git@vger.kernel.org>,
	Michael Witten <mfwitten@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 12 07:35:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2zAs-0006yl-CU
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 07:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237Ab1ILFfG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Sep 2011 01:35:06 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63187 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413Ab1ILFfF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2011 01:35:05 -0400
Received: by wyh22 with SMTP id 22so3103426wyh.19
        for <git@vger.kernel.org>; Sun, 11 Sep 2011 22:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=DE75x4bMBm0rW7Ar/0rGv6M5Has8zbn3lDwYMO+1cUg=;
        b=e/HrYgl/BeUq8RQZ/MGmYHjsj1AIimsFoUK0WL00JsrP/q3nX4gkAZfmC3GnMl3UE/
         Ft1zOvx5QkFrJKH3FH5HhJuLoTG6/dUS9AA6osw1Em339nupN0eLQpUtyJRVAaQ7D9BT
         n96JQwuK31CPzIcg+q/xrcrCQ6YSI6hkaKLHg=
Received: by 10.216.133.5 with SMTP id p5mr2000583wei.87.1315805704100; Sun,
 11 Sep 2011 22:35:04 -0700 (PDT)
Received: by 10.216.51.135 with HTTP; Sun, 11 Sep 2011 22:34:44 -0700 (PDT)
In-Reply-To: <7vbouvx8j5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181208>

Hi,

Michael Witten writes:
> [...]
> From a quick glance, my patch would appear to have become more advanc=
ed,
> as per your own request, Junio:
>
> =C2=A0Message-ID: <7vskkh1va5.fsf@gitster.siamese.dyndns.org>
> =C2=A0http://thread.gmane.org/gmane.comp.version-control.git/116083

Wow, that was over two years ago.  I only started contributing to Git
a little over a year and a half ago: no wonder I missed the
discussion.  Thanks for digging it out.

Junio C Hamano writes:
> [...]
> IIRC, "git send-email" does its best to force ordering by assigning
> monotonically increasing timestamps on the Date: field, so that the
> recipients can sort the messages based on it, in addition to the
> In-Reply-To field to help threading. I personally do not think there =
is
> anything more than that that should done in the program.

I agree with Junio here.  However, I realize that the patch adds some
value: perhaps we can have it as a script under 'contrib/'?

Thanks.

-- Ram
