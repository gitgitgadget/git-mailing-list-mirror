From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Please pull l10n updates for 1.8.4 round 1
Date: Sat, 3 Aug 2013 15:27:16 +0800
Message-ID: <CANYiYbH-y6X0XD6fCtC2k=cmtigZTLSzoWF1Q_rAeg7g=KWFog@mail.gmail.com>
References: <CANYiYbHb7VLuf4PG+CW3aKyt2nyMPuf4AgaZmmc40nX2ggRK8g@mail.gmail.com>
	<51FCA8D9.1080804@gmail.com>
	<CANYiYbFLOTk24SJFb9dmR6wT+xG_7+PXU3B928PM0tfy4ua6dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 03 09:27:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5WFG-0007p1-LG
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 09:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254Ab3HCH1T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Aug 2013 03:27:19 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:63943 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228Ab3HCH1S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Aug 2013 03:27:18 -0400
Received: by mail-wi0-f182.google.com with SMTP id hi8so124325wib.15
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 00:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ONnczqlnMPEjyUQtRrDIFmcYPljpeAwySuz9CtRo8z4=;
        b=adZrlouoCUV9ksjTC226HeYoYXLxiwRc51y3C8c2mrN/WNOc/74GLhcdNqq0IQN6uy
         M+Uc33xiRDgftTlUJc8ccrBi3gcmp2BAOdY0BkI+pPE9b0M/9GTXyB2g6DDTypCIfT5z
         BGX/k1SCuCC/Pd1gshZ3GXYfBgs2msfsEBWTmL00W3RqmfUR245sxFbx/v3go3iAW2r1
         INN7p/+gKgv0vd4oJpFM9SHAhJIhqsH3QsJ0cAU5KbvaMmtA+s79n8OLQt6k2XknV95q
         HkHp3bA7PfW+kJBZ/nlktLWAD6fq2jh6LoEAzwlim1WGZFvMQEdh5ggn7O8+ybZtnZdw
         dj7g==
X-Received: by 10.194.133.106 with SMTP id pb10mr7149901wjb.62.1375514836622;
 Sat, 03 Aug 2013 00:27:16 -0700 (PDT)
Received: by 10.194.176.129 with HTTP; Sat, 3 Aug 2013 00:27:16 -0700 (PDT)
In-Reply-To: <CANYiYbFLOTk24SJFb9dmR6wT+xG_7+PXU3B928PM0tfy4ua6dA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231570>

2013/8/3 Jiang Xin <worldhello.net@gmail.com>:
>>> are available in the git repository at:
>>>
>>>    git://github.com/gotgit/git-po
>>
>>
>> git://github.com/git-l10n/git-po
>>
>
> Thanks Tr=E1=BA=A7n. Should be git-l10n/got-po, and gotgit/git-po doe=
s not exist.
>

In order to prevent this, next time when I generate this pull request t=
ext,
I will use the following command:

    $ git request-pull kernel/master origin

"kernel" is a remote points to git://git.kernel.org/pub/scm/git/git.git=
,
while "origin" should have two urls, one for fetch and one for push.

    $ git config --get-regexp remote.origin..*url
    remote.origin.url git://github.com/git-l10n/git-po
    remote.origin.pushurl jiangxin.github.com:git-l10n/git-po  # ssh pr=
otocol

The url for fetch will be used when generate pull request.

--
Jiang Xin
