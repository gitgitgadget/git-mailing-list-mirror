From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH v2 1/4] t4014: more tests about appending s-o-b lines
Date: Sun, 2 Dec 2012 00:03:54 -0800
Message-ID: <CA+sFfMd-yvQpsfVEWYBk+70_05Ov5aX4xg8nNY0HPwHTVAK60Q@mail.gmail.com>
References: <CACsJy8BiJRK7N3_HZ2WXpMd1YkDSW00AxuYqiCWJgij+Kq6AiQ@mail.gmail.com>
	<1353602289-9418-1-git-send-email-pclouds@gmail.com>
	<1353602289-9418-2-git-send-email-pclouds@gmail.com>
	<50BAFE04.4080100@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Dec 02 09:05:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tf4YZ-0006pj-MU
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 09:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918Ab2LBID4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Dec 2012 03:03:56 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:33850 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560Ab2LBID4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Dec 2012 03:03:56 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so1033346eek.19
        for <git@vger.kernel.org>; Sun, 02 Dec 2012 00:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=b/3bHuRVdRY6nG8CuWU5f5HVBw5M/VgBjjk556laUDg=;
        b=ON08n6GpK/JbZxsBZmT7tx1K+VItdke+nYTh/QaE5RZfbhrtDRljw697iWEERHXbAO
         2Kr1GDC907Savikw4cdWq27KoxFylM7c9iWmVKghmdKQgxrFlopteLfgbmyl4fjgkNe+
         59wDUMDNLxMU4W1dE6ybvo8yGEqH8m9Z/EeFKav2gUx+/ZxZCwOKystTidGHS5YhXtdw
         Qiu23V6F2/We4dFby3jVebav3AeL0LSPTMA0kAuJS7efXe+aq1Cc3AIh6OgFiNxD8FW3
         1pDjQOy7SxOZ5ZzWH1TyO8v7/QWDAmC/oheOPd98V1wDs4a4+elQlEPfD/Jy5RWrsdAh
         xuvw==
Received: by 10.14.198.67 with SMTP id u43mr23880304een.7.1354435434825; Sun,
 02 Dec 2012 00:03:54 -0800 (PST)
Received: by 10.223.1.129 with HTTP; Sun, 2 Dec 2012 00:03:54 -0800 (PST)
In-Reply-To: <50BAFE04.4080100@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211003>

On Sat, Dec 1, 2012 at 11:06 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> On 22.11.12 17:38, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  t/t4014-format-patch.sh | 145 +++++++++++++++++++++++++++++++++++++=
+++++++++++
>>  1 file changed, 145 insertions(+)
>> +     echo -n subject | append_signoff >actual &&
>
>
> "echo -n" is not portable, and we use printf everywhere.
> I found one "echo -n" in line  996.
>
> Can we squeeze that in, before going to next?

I got it.  I'll squash it into the next series.

-Brandon
