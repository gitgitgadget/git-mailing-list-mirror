From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 14/22] git-remote-mediawiki: Check return value of open
 + remove import of unused open2
Date: Sun, 9 Jun 2013 00:52:44 -0400
Message-ID: <CAPig+cQbTGGn8-cHySj4_rQ9dbtoLEhC+9RbJhDeHLpQ0L1xLw@mail.gmail.com>
References: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
	<1370641344-4253-15-git-send-email-celestin.matte@ensimag.fr>
	<CAPig+cQHPjjpt_JYHjua6VWzTjTFog9VzhpD0hOLKSPCrEnEdg@mail.gmail.com>
	<51B353A7.1090206@ensimag.fr>
	<vpqd2rwv40f.fsf@anie.imag.fr>
	<51B37BB0.7000504@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>, benoit.person@ensimag.fr
To: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Sun Jun 09 06:53:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlXcp-0002E6-CT
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 06:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931Ab3FIEws convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 00:52:48 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:34073 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817Ab3FIEws convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 00:52:48 -0400
Received: by mail-la0-f52.google.com with SMTP id fo12so2926735lab.11
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 21:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dIYlbNIHAhMqGgJGfEqg8ciFu4yKsKLBHYm2pwwPLzc=;
        b=d4aCf3JuSayWplOAl5jJR7IGaFj8ADgLCDVIUehK2eI98wy0U5IMo7DVe8M9aEeo2r
         UZTyKj/ZSCVGcPqEiool96VvixFBIaxxRYS31hCNm3t6LkkUEjoDF/S2a5G/CUS1nxo+
         O2UDD8PLsi/7cQgln6YpD1yX5LXFHnw6Wmsb9hLGJhcNPvILWc2pLRderERw+o8g+ZjE
         RYF2nx1AlxzN6ZEbSN0dasFEFtPSoNxuDcc3WAPbr5YCw78lhie4+I0oFjSA9Epskgld
         olLOTdk8q0n7zQ2Q+KvAtm+YtohhRnx6sMkH82aRNT6fAM7OmTioflo16B0jtqRXxsuL
         U0lQ==
X-Received: by 10.152.1.230 with SMTP id 6mr2428948lap.21.1370753564906; Sat,
 08 Jun 2013 21:52:44 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Sat, 8 Jun 2013 21:52:44 -0700 (PDT)
In-Reply-To: <51B37BB0.7000504@ensimag.fr>
X-Google-Sender-Auth: g4YHX-wCw-h4yeBZd_YnRJcudDE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226881>

On Sat, Jun 8, 2013 at 2:45 PM, C=E9lestin Matte
<celestin.matte@ensimag.fr> wrote:
> Le 08/06/2013 20:41, Matthieu Moy a =E9crit :
>> C=E9lestin Matte <celestin.matte@ensimag.fr> writes:
>>
>>> Le 08/06/2013 02:14, Eric Sunshine a =E9crit :
>>>> These two changes are unrelated and could be split into distinct
>>>> patches (IMHO, though others may disagree).
>>>
>>> Two distinct patches or two distinct commits?
>>
>> That's the same. You write commits locally, send them as patches, an=
d
>> Junio uses "git am" to turn the patches back into commits.
>>
>
> Oh, I thought a part of a patch was called a commit. So the question =
was
> rather: "Should it be sent to this list independently from this serie=
s
> of patches?".

Terms "patch" and "commit" tend to be used interchangeably, as Matthieu=
 notes.

There is no need to send the split up patches to the list
independently from this series.
