From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH/RFC] l10n: de.po: translate 2 new messages
Date: Fri, 7 Sep 2012 19:12:30 +0200
Message-ID: <CAN0XMOLUpt+fdT-=wsTg_+m_VGaKpvHuC8H-h7rBozN+iFfVMQ@mail.gmail.com>
References: <1346865100-10908-1-git-send-email-ralf.thielow@gmail.com>
	<CANYiYbFBoK7D+9oZ2YGsrHYafOETLRUWUmHzfnAyA7RRhqgEkA@mail.gmail.com>
	<CAN0XMOL+2RV3wxp0nCAJzBBVF2vRNsK6H=MFYEqvKTw+nkcuXw@mail.gmail.com>
	<CAN0XMOL9cxy8noicF-P-cjLkw76Zf3Uyu4C2RqbcTYrug5+w8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Fri Sep 07 19:12:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA26h-0005AA-72
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 19:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249Ab2IGRMc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Sep 2012 13:12:32 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:54121 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332Ab2IGRMb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2012 13:12:31 -0400
Received: by wibhq12 with SMTP id hq12so806072wib.1
        for <git@vger.kernel.org>; Fri, 07 Sep 2012 10:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=lqJjGqziNOJY6g7KYjfddnqvVtiGcjsFugfcH1oJkFk=;
        b=jJnOcSjPxqFILTxwwqRVwNUiEzxDp6YT+wQGizCs5P9eyWradxjBFFQOfUkdmq2Kla
         LdctDBuZuVXOF35p+54CyqyeNnoX2jpDg19kOZ80OYYxs14PskxgAn7+/ijCuN5+p0bA
         PkR3UOBF158py7lW4ax+LdXBmUL8OAUyF7u8Krlza8EfyuHTRH0UvCL+ykkcpgNyukqR
         LT6r+2a8ClV7NswEAVACcUzfOPqxuZqUOyMyRIdoMx5JiBUcFBCbrRdx1YojC1VP/xFb
         KtILiHfgmlpLNXTjfiJ7FvyB6HRdbqRntxskdFyewk4VTnL5gdHccfXXonmCE7QXK9mk
         Ol1w==
Received: by 10.216.255.146 with SMTP id j18mr3399261wes.163.1347037950070;
 Fri, 07 Sep 2012 10:12:30 -0700 (PDT)
Received: by 10.194.23.201 with HTTP; Fri, 7 Sep 2012 10:12:30 -0700 (PDT)
In-Reply-To: <CAN0XMOL9cxy8noicF-P-cjLkw76Zf3Uyu4C2RqbcTYrug5+w8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204978>

On Fri, Sep 7, 2012 at 7:05 PM, Ralf Thielow <ralf.thielow@gmail.com> w=
rote:
> On Fri, Sep 7, 2012 at 6:36 PM, Ralf Thielow <ralf.thielow@gmail.com>=
 wrote:
>> On Fri, Sep 7, 2012 at 12:31 PM, Jiang Xin <worldhello.net@gmail.com=
> wrote:
>>> I just notice that the 1st line of the orignal message below has
>>> only 56  characters, much shorter than other lines. It is because
>>> this is a warning message, and would add a prefix: "warning: ".
>>>
>>> #: builtin/push.c:151
>>> msgid ""
>>> "push.default is unset; its implicit value is changing in\n"
>>> "Git 2.0 from 'matching' to 'simple'. To squelch this message\n"
>>> "and maintain the current behavior after the default changes, use:\=
n"
>>> "\n"
>>> "  git config --global push.default matching\n"
>>>
>>> For this reason, translations as follows are not well-formed.
>>> So I rewind git-po, and your commits may need a bit amend.
>>>
>>
>> I admit that I don't really understand what you mean. I can't
>> see a big difference in line lengths. It's not more than others
>
> I got it. This "warning: " is added automatically.
> Sorry

The update would looks like this:

msgstr ""
"'push.default' ist nicht gesetzt; der implizit gesetzte Wert\n"
"wird in Git 2.0 von 'matching' nach 'simple' ge=C3=A4ndert. Um diese M=
eldung zu\n"
"unterdr=C3=BCcken und das aktuelle Verhalten nach =C3=84nderung des St=
andardwertes\n"
=2E..
