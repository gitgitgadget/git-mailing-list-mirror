From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/5] revert: make commit subjects in insn sheet optional
Date: Fri, 9 Dec 2011 11:42:35 +0530
Message-ID: <CALkWK0mEE_v_Frm-N0ErsUY4vJ8rX1Fi1Wx_70a72j9EY+mmCA@mail.gmail.com>
References: <1323239877-24101-1-git-send-email-artagnon@gmail.com>
 <1323239877-24101-3-git-send-email-artagnon@gmail.com> <20111207070223.GC11737@elie.hsd1.il.comcast.net>
 <CALkWK0nkPB5WptJ9nSkSOif5_0R_f39Dg_HR3Rmg02hG_4Q1Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 07:13:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYthe-00012w-H0
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 07:13:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737Ab1LIGM5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 01:12:57 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39163 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab1LIGM5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 01:12:57 -0500
Received: by wgbdr13 with SMTP id dr13so5000437wgb.1
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 22:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=nVqKSNnx6XHSUdMxJCLozmklvDYF3pjuI3kGxG8l30Y=;
        b=iZzf+Jcu/ERq27zBrAgTTrIHJYRCVfDyZPHwB716PZOl1dhmn5EbMKlEzJqTMevxWM
         ALd8VDfF7ppb32SV8YcXR/G0uS8u+JyCgwD6eQ9BABFyo444Yy4IhGosIa9Q7+6SEwle
         +kMkwXCIQ6QNCXGV5pxFDC5AEnZaQjFq8j8Us=
Received: by 10.216.136.223 with SMTP id w73mr381203wei.112.1323411176214;
 Thu, 08 Dec 2011 22:12:56 -0800 (PST)
Received: by 10.216.51.141 with HTTP; Thu, 8 Dec 2011 22:12:35 -0800 (PST)
In-Reply-To: <CALkWK0nkPB5WptJ9nSkSOif5_0R_f39Dg_HR3Rmg02hG_4Q1Tg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186611>

Hi,

Ramkumar Ramachandra wrote:
> 1. Implement the strscpn() using two strchrnul() calls.
> 2. Drop this patch and use strbuf to replace the fixed-size buffer.
>
> I think I'll go with the second option. =C2=A0What do you think?
> [...]


Er, I have an 'eol' which I'm not using.  Making sure that 'eol' is
valid is good enough to avoid unexpected failures: if strchrnul() is
able to find a '\n', strcspn() should have no trouble finding either a
' ' or '\n' (whichever comes first).

Sorry for the nonsense.

-- Ram
