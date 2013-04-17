From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH/RFC] l10n: de.po: translate 39 new messages
Date: Wed, 17 Apr 2013 07:18:30 +0200
Message-ID: <CAN0XMOJUXi_nV71k=K6jSTBTd9C+qJYKqm4-bqvV-A0nOVQeGw@mail.gmail.com>
References: <1366043260-3131-1-git-send-email-ralf.thielow@gmail.com>
	<1906942.3yyCMUNxTB@cs-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>, git <git@vger.kernel.org>
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Wed Apr 17 07:18:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USKlP-0006Vd-Q1
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 07:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757223Ab3DQFSc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Apr 2013 01:18:32 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:51178 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757143Ab3DQFSb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Apr 2013 01:18:31 -0400
Received: by mail-we0-f181.google.com with SMTP id r6so903648wey.40
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 22:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=RunCVknauXf7xvk1K3I89DT4MUHI1FeTsnEyypW7gwM=;
        b=ThY78I/I4iFHo0XuLXRz9C9ZQRhv9iSHgN30c8gGPm7XycJce6TfKpwZ0Lnb3+63/t
         SK11F+DiaYX4W+zWwdM6tgyCG6mQSAGWuTH3JrgZ2K7B3c9lJnjhtxceqg2tK+Ey0bG4
         IR0m8rfkwsTyxYJIa6fesYCvV+Bq1c6GpM0swUGcpHJd42LIQ+va/wamTvgL7iNN4by0
         Gq2mnwuDq1vRYyzxlhArU7goS4SqJvcK60xN0BmJI0heIy6g/Lpd5sovrWeUNl6GD7bt
         pAf7JfsZRFYTJNa7rmqdWHkj+j2CO+RcZ5bm16ZC1jMTFixCKeme4ICp657GvEMrdN5s
         PY4w==
X-Received: by 10.194.157.138 with SMTP id wm10mr8388351wjb.28.1366175910215;
 Tue, 16 Apr 2013 22:18:30 -0700 (PDT)
Received: by 10.194.31.137 with HTTP; Tue, 16 Apr 2013 22:18:30 -0700 (PDT)
In-Reply-To: <1906942.3yyCMUNxTB@cs-pc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221507>

Hi,

Thanks for Review!

2013/4/15 Christian Stimming <stimming@tuhh.de>:
> Thanks for the regular update! This is great work.
>
> One issue with the plural form messages, though:
>
> Am Montag, 15. April 2013, 18:27:40 schrieb Ralf Thielow:
>>  #: bundle.c:186
>> -#, fuzzy, c-format
>> +#, c-format
>>  msgid "The bundle contains this ref:"
>>  msgid_plural "The bundle contains these %d refs:"
>> -msgstr[0] "Das Paket enth=C3=A4lt %d Referenz"
>> -msgstr[1] "Das Paket enth=C3=A4lt %d Referenzen"
>> +msgstr[0] "Das Paket enth=C3=A4lt diese Referenz:"
>> +msgstr[1] "Das Paket enth=C3=A4lt diese %d Referenzen:"
>
> The msgstr[0] must still contain a %d conversion specifier (which wil=
l be
> filled with the number 1) even though the translated sentence wouldn'=
t need
> the 1 anymore. The previous msgstr[0] was correct; the English singul=
ar msgid
> is not.
>

That made me wonder, too. I've played around a bit with this, and it se=
ems
to be OK as long as one of those strings contain at least one format sp=
ecifier.

> Technical background: The ngettext function chooses only the string i=
tself,
> which will then be fed to printf() as a second step. If the printf se=
es more
> variadic arguments than conversion specifiers in the string, it will =
be
> unhappy. At least that's what I remembered about the ngettext things.=
=2E.
>
> http://www.gnu.org/software/libc/manual/html_node/Advanced-gettext-
> functions.html
>
> Regards,
>
> Christian
>
