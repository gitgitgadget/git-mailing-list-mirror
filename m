From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [Alt. PATCH] format-patch: do not use diff UI config
Date: Thu, 9 Sep 2010 14:13:13 -0500
Message-ID: <AANLkTinNJtRUxZTvizVnY9Xe0Yew4s-hnbNtQTKyekd6@mail.gmail.com>
References: <1284019625-14096-1-git-send-email-ods15@ods15.dyndns.org> <2a6b8c51903fd6a22606b8f592b1a2e11ea68741.1284020917.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Oded Shimon <ods15@ods15.dyndns.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Jan_Kr=C3=BC?= =?UTF-8?Q?ger?= <jk@jk.gs>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Sep 09 21:13:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtmZ2-0007IR-DZ
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 21:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108Ab0IITNg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Sep 2010 15:13:36 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63225 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab0IITNe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Sep 2010 15:13:34 -0400
Received: by yxp4 with SMTP id 4so770563yxp.19
        for <git@vger.kernel.org>; Thu, 09 Sep 2010 12:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=7M6IDtXY7jbSoWqRDHjw7p48yqQCb/jtZ4MumnKAMHc=;
        b=SZ2SiAS/f0+/OPnXdqyltfCIfUeEHT0sS7SGolnO1LBBUI91OJ5aCOmPT6+jxWNDh2
         L6UKu6Wz9F93TQB0weESZL3x9ktgdFUWHzWKriv3xT3ub0ncW1ve03UNk69Fj10nt/AS
         lF68fOPh3FZa3SMNuwBlVegyXrtDC5t/wLr8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=A1Hn+Bc74CcNEzbq6F+hfwBHYiePq+/Lk7qyRe7npB5pY46sp16mBaDFlpuQghXwzS
         cVV/woCoz8yllV72dWcVqN+TfI8urpr03Db+sNxRl4lBdMKgR/CsSG++6JPR/d4mHoHr
         jTMIfUx4qXtLN9pS3p/iYSn8iYG5k5KJWqj+M=
Received: by 10.150.200.8 with SMTP id x8mr548506ybf.408.1284059613829; Thu,
 09 Sep 2010 12:13:33 -0700 (PDT)
Received: by 10.150.204.21 with HTTP; Thu, 9 Sep 2010 12:13:13 -0700 (PDT)
In-Reply-To: <2a6b8c51903fd6a22606b8f592b1a2e11ea68741.1284020917.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155884>

Heya,

On Thu, Sep 9, 2010 at 03:36, Thomas Rast <trast@student.ethz.ch> wrote=
:
> +test_expect_success 'rebase is not broken by diff.noprefix' '
> + =C2=A0 =C2=A0 =C2=A0 git config diff.noprefix true &&
> + =C2=A0 =C2=A0 =C2=A0 test_when_finished "git config --unset diff.no=
prefix" &&
> + =C2=A0 =C2=A0 =C2=A0 git checkout -b noprefix side &&
> + =C2=A0 =C2=A0 =C2=A0 GIT_TRACE=3D1 git rebase master
> +'
> +

Can we have one for 'git config diff.color true' too?

--=20
Cheers,

Sverre Rabbelier
