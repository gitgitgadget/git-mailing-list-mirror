From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 02/22] builtin/blame.c: mark strings for translation
Date: Mon, 29 Feb 2016 07:33:36 +0700
Message-ID: <CACsJy8BvpcwVQuk+kYxCCNcwhQYm1COwpajQamC9z32khMGMVA@mail.gmail.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
 <1456555333-5853-3-git-send-email-pclouds@gmail.com> <xmqq7fhofyt0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 01:34:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaBn1-0004SC-7l
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 01:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbcB2AeJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Feb 2016 19:34:09 -0500
Received: from mail-lb0-f196.google.com ([209.85.217.196]:36727 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbcB2AeI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Feb 2016 19:34:08 -0500
Received: by mail-lb0-f196.google.com with SMTP id gn5so5494535lbc.3
        for <git@vger.kernel.org>; Sun, 28 Feb 2016 16:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=57tFU5aZMvEcsdtOajnyK5QOO6YhaHEgpEWgyiTJUvg=;
        b=xF7T7bsLvlyjdvP2H/gLSdATqtCNdZp+s58agBIZOPMeS4YWKWRX48vn33tQm9zLve
         Jq5DRe9hMJS+jis/wfjd6QnxMQkFb3mcG07zSPZj5GVW0rk71ilXGiBsGeUBPIlMAQ1O
         DxuhQjKVSfTAsYnkgRs7ThL7GNt6kI8rSHZaYfYOp2c4kfKZCLVmdkfV7GJi8pohaRxN
         l2ruqo7JZQ5gLpkw9tZdeacpE4aaWf4OzG0PKmK30COn1jgvbgV3BMnRpA4bOpzuYb6N
         s9/ls/8iyxFBhi7pTI1TM7bVuCi3ZXvnlP2bKc5soXZwA61oFhhrh1g6zD28zB2Yk09T
         Yu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=57tFU5aZMvEcsdtOajnyK5QOO6YhaHEgpEWgyiTJUvg=;
        b=ApJnjLVc7XOlVns/VHQLAXYzvAdkeiRlyYfSQRpArSdAxsL2IXQ7Oo35yczrMGsfJw
         7fjijsm3ohF0TPmuPP2gass6gxCtUhiMeE+4m2FHyr0wws4tToNbZ/T26hoRNiVzivjd
         Tk2Dn026DgAAc5lcgogDOO4ddCktIP6CE00Gt/1rMiyU2gPD3nm9LeZXAuIF0tp5M8YT
         MfbM1WyuOSG6oO/Q7njdP66vraV/Blx7ftd/WagUhGgNV4QllxlhTCzTcMPvUgyttYuc
         tajdjuoI48JKWr4LZXNRhE25CqjGX6ubwOSHPtlT/sKFH0x8oWzEdksM+zBfXodsfrn4
         gIVg==
X-Gm-Message-State: AD7BkJKe85xDnDzLzL3Dr1XGdYcDgo+/rwQS1VBDFBIGWO/3RTwaCwrG2a9kOs5/c7ik6auyVwgjs3qGGyfo1w==
X-Received: by 10.112.150.133 with SMTP id ui5mr4365813lbb.12.1456706045594;
 Sun, 28 Feb 2016 16:34:05 -0800 (PST)
Received: by 10.112.51.99 with HTTP; Sun, 28 Feb 2016 16:33:36 -0800 (PST)
In-Reply-To: <xmqq7fhofyt0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287794>

On Mon, Feb 29, 2016 at 1:57 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  builtin/blame.c | 58 ++++++++++++++++++++++++++++------------------=
-----------
>>  1 file changed, 29 insertions(+), 29 deletions(-)
>
> I think most of the strings we see here are not new ones introduced
> in this cycle.  I doubt it is a good idea to disturb the codebase,
> distract ourselves and adding last-minute workload to translators
> with this during the pre-release period.

Yes, it's ok to consider this series a new topic, to be graduated after=
 2.8.0.
--=20
Duy
