From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC PATCHv2 15/16] t7800 (difftool): add missing &&
Date: Fri, 24 Sep 2010 23:02:29 +0000
Message-ID: <AANLkTikW8DBGybpE_+_zhqFi2XM0bu3YcqBkx3oZNhdB@mail.gmail.com>
References: <1285366976-22216-1-git-send-email-newren@gmail.com>
	<1285366976-22216-16-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 01:02:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzHHo-0004ey-2r
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 01:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755538Ab0IXXCb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 19:02:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62593 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748Ab0IXXCa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 19:02:30 -0400
Received: by iwn5 with SMTP id 5so2747114iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 16:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=o1aZ1cO/dfsOznOmWh5e/CAytxK/qus5xC3O0TfcnOk=;
        b=aBB+qfNB4IfdfDkvYotP8vSwq1g19X+UJ0vH5CJmkVtdtadDU03NzLs7ZgUr7G9teu
         4s88bb40rY/w9v4+OwyI07euc8dvd4GNDxhteJMmlMuCZ1NzQ3Yn+az/GFPzE5VTnTNt
         Py2O8DkZ7cmk4G0vJqwbmHMgTqK3KB5NBqIDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uMhWaKP2Oy4TXydNjimuI90svZkK2CpXLVSBLFRbl4/ZZ7sZEt1kBfehr1C7W8coU+
         +5/qQn376mdfWwjFfOUF06ZfYcTgf5x72w2MfetlCLGX9hXqSxR698Dz9QimUmLcTaMZ
         dstvFppKBM+MhB6cDja4Y7qsVsNr0sWog+RgE=
Received: by 10.231.190.75 with SMTP id dh11mr4458501ibb.189.1285369349941;
 Fri, 24 Sep 2010 16:02:29 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Fri, 24 Sep 2010 16:02:29 -0700 (PDT)
In-Reply-To: <1285366976-22216-16-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157100>

On Fri, Sep 24, 2010 at 22:22, Elijah Newren <newren@gmail.com> wrote:

> =C2=A0test_expect_success PERL 'difftool --extcmd echo arg1' '
> - =C2=A0 =C2=A0 =C2=A0 diff=3D$(git difftool --no-prompt --extcmd sh\=
 -c\ \"echo\ \$1\" branch)
> + =C2=A0 =C2=A0 =C2=A0 diff=3D$(git difftool --no-prompt --extcmd sh\=
 -c\ \"echo\ \$1\" branch) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test "$diff" =3D file
> =C2=A0'
>
> =C2=A0test_expect_success PERL 'difftool --extcmd cat arg1' '
> - =C2=A0 =C2=A0 =C2=A0 diff=3D$(git difftool --no-prompt --extcmd sh\=
 -c\ \"cat\ \$1\" branch)
> + =C2=A0 =C2=A0 =C2=A0 diff=3D$(git difftool --no-prompt --extcmd sh\=
 -c\ \"cat\ \$1\" branch) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test "$diff" =3D master
> =C2=A0'
>
> =C2=A0test_expect_success PERL 'difftool --extcmd cat arg2' '
> - =C2=A0 =C2=A0 =C2=A0 diff=3D$(git difftool --no-prompt --extcmd sh\=
 -c\ \"cat\ \$2\" branch)
> + =C2=A0 =C2=A0 =C2=A0 diff=3D$(git difftool --no-prompt --extcmd sh\=
 -c\ \"cat\ \$2\" branch) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test "$diff" =3D branch
> =C2=A0'

Maybe better to change these all to:

    echo branch >expect &&
    git difftool ... >actual &&
    test_cmp expect actual

Or maybe do that in a later series, since it's not on-topic for this
one.
