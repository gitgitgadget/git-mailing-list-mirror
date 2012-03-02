From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] Update l10n guide
Date: Fri, 2 Mar 2012 15:30:51 +0800
Message-ID: <CANYiYbE7bxz5=h9gaKf6+N6k5cn6mEKnuf_7KPFAnDrC31UL_w@mail.gmail.com>
References: <CANYiYbGS_cFTHT1Pkafi9dmzedqezTq8k1tPkYur0b2St_c43Q@mail.gmail.com>
	<7v1upew6d0.fsf@alter.siamese.dyndns.org>
	<7vfwduujxw.fsf_-_@alter.siamese.dyndns.org>
	<CANYiYbE5rcnD_VGJyL2CjS-R5E0pyNSd5TetvH849W6wC5JiAA@mail.gmail.com>
	<7vk434q4eg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 08:30:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3Mx7-0007EX-Fj
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 08:30:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755475Ab2CBHax convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Mar 2012 02:30:53 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38017 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754689Ab2CBHaw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Mar 2012 02:30:52 -0500
Received: by yenl12 with SMTP id l12so665358yen.19
        for <git@vger.kernel.org>; Thu, 01 Mar 2012 23:30:51 -0800 (PST)
Received-SPF: pass (google.com: domain of worldhello.net@gmail.com designates 10.236.184.129 as permitted sender) client-ip=10.236.184.129;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of worldhello.net@gmail.com designates 10.236.184.129 as permitted sender) smtp.mail=worldhello.net@gmail.com; dkim=pass header.i=worldhello.net@gmail.com
Received: from mr.google.com ([10.236.184.129])
        by 10.236.184.129 with SMTP id s1mr12085669yhm.21.1330673451920 (num_hops = 1);
        Thu, 01 Mar 2012 23:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=VX0F65NrMW2xBFu/o/T0UrGU+VEtGmSIrum8G96iYLQ=;
        b=ti7Ewl0gPQ3iYSYpPDnQATPGcILP0+eZOs8Gl0MZ8/v0xCn/th3r9EZYiczGeg8aA1
         z6bVO0QyUwfQjz2HgafbJxQHxUV/wBPa4iW8avwUGq9mm2W5NwyVJ2lGb7WQOVpePqVM
         6JLaGgAJ0eYXWfYLgtz1UEu3nhS/OJd2W7VtPCsciVnG51oto7DnMDHokjhel1W2ayEZ
         IiPMl/bKyBi82cmgAe0J8vh36vSCwcuI048m6Uw/uX6cBMAofuIV9oYFmwG4MdVBJFhd
         kMt1mxRQMs/B68iWH0WJsWJ6t1BhyIQ3vB/NqZbGfWZHqIFLFGSNoYD98EySGfezp+NS
         nWaA==
Received: by 10.236.184.129 with SMTP id s1mr9545454yhm.21.1330673451876; Thu,
 01 Mar 2012 23:30:51 -0800 (PST)
Received: by 10.236.182.5 with HTTP; Thu, 1 Mar 2012 23:30:51 -0800 (PST)
In-Reply-To: <7vk434q4eg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192011>

2012/3/1 Junio C Hamano <gitster@pobox.com>:
>>
>> Shall we remind the contributors for l10n to write commit log in Eng=
lish,
>> but not language XX? It's a common mistake for translators.
>
> I would prefer to see the subject line (the first line summary) in En=
glish
> to say something like "Update zh_CN translation for 1.7.12". =A0That =
much of
> English shouldn't be too much burden for language teams.

I noticed that all i18n related commit logs all have prefix "i18n:".
It would be nice to add a prefix "l10n:" to the l10n related commit log=
,
such as: "l10n: Update zh_CN translation for 1.7.12".

>
> On the other hand, the body of the log that describes the change _may=
_ be
> hurt if you forbid the use of language XX. =A0The translators may wan=
t to
> write something like:
>

Git does not handle multi-bytes character well. Multi-bytes characters
not convert to UTF-8 when git write tree objects and commit objects.
I think allow multi-bytes characters in commit log would hurt git.git u=
ntil
git gives full support UTF-8 (are there any plans for this?).
I just tested several versions of msysgit:

 - Only Git-1.7.8-preview20111229-unicode.exe saves commit objects
   with utf-8 encode.

 - Other versions such as Git-1.7.9-preview20120201.exe and
   Git-1.7.8-preview20111206.exe will not convert multi-bytes character=
s
   in commit log into UTF-8.

--=20
Jiang Xin
