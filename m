From: Thomas Adam <thomas@xteddy.org>
Subject: Re: [PATCH] pack-refs: remove all empty dirs under .git/{refs,logs/refs}
Date: Sat, 11 Feb 2012 11:27:56 +0000
Message-ID: <CA+39Oz5CCxgM3s804VgnvvTYC2Yynt5YOdswD0cuZ8WWXTcqwA@mail.gmail.com>
References: <1328946907-31650-1-git-send-email-pclouds@gmail.com> <1328958484-4202-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 12:28:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwB7p-0004gk-Sy
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 12:28:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755825Ab2BKL2M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 06:28:12 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:42418 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755293Ab2BKL2M convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 06:28:12 -0500
Received: by obcva7 with SMTP id va7so4775824obc.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 03:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=UCR6ctuswHrwzBme2MumkH2UFd5KfmZzd7gGrPS5gmo=;
        b=J3h16zEO1LdGnCKXQQRlzlXkyOPTUDkCI69ZtM+7X4DgWHzYI79RuNxOXgLaOjeGOt
         jE9H8wN6AXrnpWB7oiu+XKBcOablkwgHfCYNtPKZaXwc2XiKtsk5XYXkLy5C16HRzz26
         sIsbzM8zEQQVo3nGx7iPF8w7VnOAIIOVX51bU=
Received: by 10.182.139.104 with SMTP id qx8mr6269657obb.69.1328959691244;
 Sat, 11 Feb 2012 03:28:11 -0800 (PST)
Received: by 10.182.236.67 with HTTP; Sat, 11 Feb 2012 03:27:56 -0800 (PST)
In-Reply-To: <1328958484-4202-1-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 1qnJpIrSyf2dBpHF7SNlrvDjGdk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190510>

2012/2/11 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> =C2=A0static void prune_refs(struct ref_to_prune *r)
> =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0 struct string_list *list =3D get_empty_ref_dir=
ectories();;

Double ";;" at end of line.

-- Thomas Adam
