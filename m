From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [L10N] Startup of Git 2.3.0 l10n round 2
Date: Mon, 19 Jan 2015 00:18:34 +0800
Message-ID: <CANYiYbGL4A+ut8NjKmq6U8ADVf2M9Lq-5DOG3qxbKBp5srtrJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 17:18:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCsYi-0002qY-IU
	for gcvg-git-2@plane.gmane.org; Sun, 18 Jan 2015 17:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423AbbARQSg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jan 2015 11:18:36 -0500
Received: from mail-we0-f175.google.com ([74.125.82.175]:64695 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbbARQSf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jan 2015 11:18:35 -0500
Received: by mail-we0-f175.google.com with SMTP id k11so27605629wes.6
        for <git@vger.kernel.org>; Sun, 18 Jan 2015 08:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fGDln/BgdPtmCqlNPbIj9yxEHGkh35z9sXk4vD/x7Yc=;
        b=O9tM2G/mW8olbneVpKLj7e7G08bePEluBN6UYH5/FsJkyQK6mJp+hSg05MIDox70qR
         QmUC1c1PcPXXrg4FLtElFgEik8RuqW5JW8fCr28xQTIilM5TfzlpBZNH5sa3HciIEe/h
         J6PXV//c+vAij9Js2zOHip/WRPcLlA2rvZVE1i9CWHIJgDXuKI7FOuK2hM1zB2wDZLoL
         Uevj0IM+aiPNT8emQkHgjYPzM4M8cPloTAEf5IW5Yw2ivCPTuTftqeI8tr3D5955eKTu
         TsplqOZzkknaZsTQlzgCzJUU1lSyXoWNrBe4vErTtQr2z9Gs0jYYkmh6CKl/peqo9QMH
         LTdA==
X-Received: by 10.180.104.98 with SMTP id gd2mr26676775wib.53.1421597914761;
 Sun, 18 Jan 2015 08:18:34 -0800 (PST)
Received: by 10.194.80.131 with HTTP; Sun, 18 Jan 2015 08:18:34 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262603>

2015-01-18 23:53 GMT+08:00 Jean-No=C3=ABl AVILA <jn.avila@free.fr>:
> Hi,
>
> One of the new strings mixes tabs and spaces at begining of lines. Is=
 it
> really to be applied?
>
> Jean-No=C3=ABl

Yes, it's wrong to using mixed tabs and spaces in the message. It comes
from commit v2.0.5-5-g9990273, and it should be fixed.

    commit 99902739174be82851143d4be2a0f85727a9efe0
    Author: Alexander Kuleshov <kuleshovmail@gmail.com>
    Date:   Fri Jan 9 00:08:36 2015 +0600

        show-branch: line-wrap show-branch usage

        Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
        Signed-off-by: Junio C Hamano <gitster@pobox.com>


--=20
Jiang Xin
