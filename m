From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/9] i18n: add PO files to po/
Date: Wed, 5 Oct 2011 09:09:27 +1100
Message-ID: <CACsJy8DxwWgzOEubkZwz_ihcvHpSqDyhoii3Pxwobc_RxfLHUg@mail.gmail.com>
References: <1317668297-2702-1-git-send-email-avarab@gmail.com> <20111003220659.GA19537@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?Q?Marcin_Cie=C5=9Blak?= <saper@saper.info>,
	Sam Reed <sam@reedyboy.net>,
	Jan Engelhardt <jengelh@medozas.de>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 00:10:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBDBb-0004Vp-TN
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 00:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933258Ab1JDWJ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Oct 2011 18:09:59 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52078 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932820Ab1JDWJ6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2011 18:09:58 -0400
Received: by bkbzt4 with SMTP id zt4so1254511bkb.19
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 15:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=jdRD6fL7IVYQ/rsLcRTyVlytGXwjjsKSQyNJqTUuQ2s=;
        b=UvHlhSQ0dfE/UPZrMyUV9AkxJZWin/n4TOmdTpNFCPlzpz8QygN/JsFqAydI6BzoF6
         w/DVL825yA7hk48p856O3lXqSBZ9yGvIZ9MXVS73gSnPYs2Jq5tDMCDAkqzygeYSn4KN
         KSMEl354iuI5FnDO09iKltjQ4lYpdYLSCSC2s=
Received: by 10.204.6.210 with SMTP id a18mr1107351bka.303.1317766197134; Tue,
 04 Oct 2011 15:09:57 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Tue, 4 Oct 2011 15:09:27 -0700 (PDT)
In-Reply-To: <20111003220659.GA19537@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182808>

On Tue, Oct 4, 2011 at 9:06 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> 3. Maybe some hero will implement
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git log -p --exclude=3Dpo/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# or
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git log -p -- :(not)po/
>
> to complement "git log -p -- po/". ;-)

Meanwhile, how about keeping po in its own repository? Translations
usually lag behind anyway. This keeps main repo "clean". Junio can
declare string freeze 1-2 weeks before a new release, so that
translations can be updated, then he can make a tarball containing
both git.git and git-translations.git.
--=20
Duy
