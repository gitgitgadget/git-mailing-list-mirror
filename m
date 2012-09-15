From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Revert diffstat back to English
Date: Sat, 15 Sep 2012 09:41:23 +0700
Message-ID: <CACsJy8BeuQaMTPCTzsyZo8KqE1V9iLDxrYB8fWT8_enq0iAg_g@mail.gmail.com>
References: <20120913132847.GD4287@sigill.intra.peff.net> <1347545786-936-1-git-send-email-pclouds@gmail.com>
 <7vvcfg5yvo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 04:42:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCiLK-0007Xm-UE
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 04:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755367Ab2IOClz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Sep 2012 22:41:55 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33534 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128Ab2IOCly convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2012 22:41:54 -0400
Received: by iahk25 with SMTP id k25so3987080iah.19
        for <git@vger.kernel.org>; Fri, 14 Sep 2012 19:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=FY4+p6uTGkVwVEq1GD+9Kq8brGUfQEi7DD+bYR0S3HE=;
        b=SbM+DU71NzczA82OB+PX3Qp9MSa0BNHZTNa/JIS6voDqJLp0S0c4vC0yKJW73e5oRO
         8+yM0m5JNT9UyfprO1xKmL+h5WmArqgWOndDXqtG0TnsHPRVF0RvgmxrtryYddG5dTwr
         qtq8YnxRwjHfItbO0cxqZ1DSSRGxP4fIXC/8xOxZMLg4ymXu3QWbmrOCtTupXAt+vrt1
         9A2b/5/h1dRmyVnHtfI9bzAGGemVB8p9oQVqwiTPkEdZw6Q0bVcFTMv9Xh8P3/btgJNE
         003foBDLY2WVwdW8rG2Ia4HdkyBXWrcinWI0Q7f+i8imGIxr+6dogyegMCs1j3QfJLd5
         GPCg==
Received: by 10.50.159.130 with SMTP id xc2mr332243igb.15.1347676913243; Fri,
 14 Sep 2012 19:41:53 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Fri, 14 Sep 2012 19:41:23 -0700 (PDT)
In-Reply-To: <7vvcfg5yvo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205544>

On Fri, Sep 14, 2012 at 11:54 PM, Junio C Hamano <junio@pobox.com> wrot=
e:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>
>>> This reverts the i18n part of 7f81463 (Use correct grammar in diffs=
tat
>>> summary line - 2012-02-01) but still keeps the grammar correctness =
for
>>> English. It also reverts b354f11 (Fix tests under GETTEXT_POISON on
>>> diffstat - 2012-08-27). The result is diffstat always in English
>>> for all commands.
>>>
>>> This helps stop users from accidentally sending localized
>>> format-patch'd patches.
>>>
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
>
> Why am I getting this from t3300?
>
>     --- expected    2012-09-14 16:43:09.000000000 +0000
>     +++ current     2012-09-14 16:43:09.000000000 +0000
>     @@ -1,2 +1,2 @@
>       "tabs\t,\" (dq) and spaces"
>     - 1 file changed, 0 insertions(+), 0 deletions(-)
>     + 1 files changed, 0 insertion(+), 0 deletion(-)
>
> Ah, your rewrite of Q_() is wrong. Will squash the attached in
> before queueing this for maint.

Arghhh I found that and fixed it, but probably sent an old version. Tha=
nks.
--=20
Duy
