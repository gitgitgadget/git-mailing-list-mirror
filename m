From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (May 2011, #13; Mon, 30)
Date: Mon, 30 May 2011 14:08:01 +0200
Message-ID: <BANLkTi=reSnAVgt6k-JaDDu27HP_DEGdhQ@mail.gmail.com>
References: <7v62osob67.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 30 14:08:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR1GT-0006B4-Kk
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 14:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756859Ab1E3MID convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2011 08:08:03 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61032 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754025Ab1E3MIC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2011 08:08:02 -0400
Received: by fxm17 with SMTP id 17so2411679fxm.19
        for <git@vger.kernel.org>; Mon, 30 May 2011 05:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=127JnQ9a17zG4GjhjtTXe2TNogL+pjCowej9jzsa9Sk=;
        b=iwGQuMLSHgSIVHVYklgqfnrVUg9lSGGK+96dDPd2kyZob+xqBdUSMdGAVhDPRlx89e
         6wyGu1ndy99QdRbngv5qM7wUK8lF6c8vKWoiCP/SHuO+AvqQabVjo0RFrkrHno+ISPAR
         RxNfuGMiKmHGv/o21nWO4pDkign4xqTbAvACk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Lv0M8eUbv7BN3DjwVT34HcGE4mOwsdS6d/WJT+9RBlhLkuByjrmXDn1E2S+MnhsL1Z
         WPbDPkJ6xMyR/qniqB5gze0+aEPx6mg1Sa9IcU+cH+MVFpc5bfN6MNZi16ThAmuEaeJQ
         uBPxU3GRVeUuIbZZB/Y9ci8dk5p+zMpdQWWrA=
Received: by 10.223.77.92 with SMTP id f28mr1465749fak.37.1306757281317; Mon,
 30 May 2011 05:08:01 -0700 (PDT)
Received: by 10.223.117.72 with HTTP; Mon, 30 May 2011 05:08:01 -0700 (PDT)
In-Reply-To: <7v62osob67.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174741>

On Mon, May 30, 2011 at 10:16, Junio C Hamano <gitster@pobox.com> wrote=
:

> * ab/i18n-scripts (2011-05-21) 48 commits
> =C2=A0(merged to 'next' on 2011-05-23 at 69164a3)
> [...]
> Rerolled.
> Will cook a bit longer.

This being ready for master is waiting on Johannes Sixt's patches to
supply a fallback getenv() on Win32.

Johannes, what's the status of that, and is there anything I can do to
help with that?
