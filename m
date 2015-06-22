From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/7] Raw gpg output support for verify-commit and verify-tag
Date: Sun, 21 Jun 2015 17:38:36 -0700
Message-ID: <CAPc5daVX0CE0VeAp-gv6nj_tGp5JKS4kZGLojv-AYXSSkD38EA@mail.gmail.com>
References: <1434928483-105916-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Alex Zepeda <alex@inferiorhumanorgans.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Jun 22 02:39:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6plN-0004PN-6n
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 02:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121AbbFVAi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 20:38:57 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33458 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbbFVAi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 20:38:56 -0400
Received: by obpn3 with SMTP id n3so20846886obp.0
        for <git@vger.kernel.org>; Sun, 21 Jun 2015 17:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=vocuKwqAU7UEhQwP2WeVleAgHAW3VAMwRMRII4MkZsE=;
        b=seNiFovcGooX7Xoo4FtTgMRfF9/ocEsFFVA0h6+XBGSaZBLePW780YNsZxrkI71QTW
         TbZph0uYw0xExQoYEc4te+kbQAOf/04eNyGwLNfbwP3jIfzHPUPZDsEev2mj7KU27kw5
         TYmXbRSznfc4/KrbH4hKfhGfWoFIPP0+MdSTCKFDolEkQZkOqCPcSqfvbkpNofGr+6hZ
         OZKNwveD4sOP5xlF4rtXxDfXMHTCb2vldv/BLQPxgzBmprEFgf7bMPKDKZU4azTXlUMv
         A7+ilsnsoMVVRwD9Tm4rmMDjwLt5KgB3vTcljtD8W/AWYh/QE3y6vAYz1/hKOuGDuHsW
         7nhA==
X-Received: by 10.202.186.132 with SMTP id k126mr21715735oif.60.1434933535488;
 Sun, 21 Jun 2015 17:38:55 -0700 (PDT)
Received: by 10.202.202.129 with HTTP; Sun, 21 Jun 2015 17:38:36 -0700 (PDT)
In-Reply-To: <1434928483-105916-1-git-send-email-sandals@crustytoothpaste.net>
X-Google-Sender-Auth: cGI8juWt9bfeSj3SLZZhMihBpm4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272308>

On Sun, Jun 21, 2015 at 4:14 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> This series introduces a --raw option for verify-commit and verify-tag.
> If it's used, they provide the gpg --status-fd output on standard error
> instead of the human-readable output.  The series also adds tests for
> verify-tag, since there were none; these are based off the ones for
> verify-commit.

The series was a logical and gradual progression that was pleasant to read.

Thanks.
