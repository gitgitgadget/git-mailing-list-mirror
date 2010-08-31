From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/3 v2] tests: factor HOME=$(pwd) in test-lib.sh
Date: Tue, 31 Aug 2010 07:42:53 +0000
Message-ID: <AANLkTik7d9Rhx5NudeKvVMFAYvVhGxoYzK2y+g3CP=Zj@mail.gmail.com>
References: <vpqhbibbthi.fsf@bauges.imag.fr>
	<1283210123-19752-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Aug 31 09:43:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqLUr-0001Qj-Hv
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 09:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756882Ab0HaHm7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 03:42:59 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61483 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756096Ab0HaHm7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 03:42:59 -0400
Received: by iwn5 with SMTP id 5so5638604iwn.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 00:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BLhhaA62SI37kx6NhxJjA7zhEfKIyE5g4gM3kZ8yX+0=;
        b=cIwFFYrTxnG2c1VhsYESfq2cCI6OOwMuikCBGRoCUr2sUNgeUYzGBtREArTw0zd0aN
         XjH9ewk9oCCwGiMvPUfWKOsEmVvjaUMmnduw5syHtjJu4GWxUaXm+zMuOZ2iIubv5PdP
         7sUXrXakEXcFR4nJA+pjXkvWI/Zko35xOVN3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Y+7VmBSt8cDWN8uiPjyJvw1zxwpBDsFXtGzxbypYh9vqq6/fDxA1BekToAb52Rl6di
         WvVnu/YCkmYQTFnmYv3IcGh37RLK6hORHnF7JM8htJfyt3JeA1J72+y7ECjTi690+wL9
         IUvDpfKV6/dnS7eXT/B3jeaJ2RCtjKtBwyILg=
Received: by 10.231.33.73 with SMTP id g9mr6413484ibd.117.1283240574783; Tue,
 31 Aug 2010 00:42:54 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Tue, 31 Aug 2010 00:42:53 -0700 (PDT)
In-Reply-To: <1283210123-19752-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154884>

On Mon, Aug 30, 2010 at 23:15, Matthieu Moy <Matthieu.Moy@imag.fr> wrot=
e:
> The same pattern is used in many tests, and makes it easy for new one=
s to
> rely on $HOME being a trashable, clean, directory.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> Just re-ordered the patch to make this one the first.
>
> I took =C3=86var's suggestion of using $TRASH_DIRECTORY instead of $(=
pwd).

Thanks,

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
