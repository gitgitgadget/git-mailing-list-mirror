From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: git status & seg.fault
Date: Tue, 26 Oct 2010 10:03:07 +0200
Message-ID: <AANLkTikhU+hBwsh24JYGmwHoNFGMseAx_+rUMYH4XGkT@mail.gmail.com>
References: <AANLkTinymMtDKt1V9xb+adJiSoOKT8YSy1qHuHc_=yVq@mail.gmail.com>
	<AANLkTinghepgdMRjEBhpAMz-Mr0g7szKyYEDfE=ttstS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Rado Dr." <radodr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 26 10:03:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAeV5-0002Ut-PO
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 10:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755803Ab0JZIDL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Oct 2010 04:03:11 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61309 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850Ab0JZIDJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Oct 2010 04:03:09 -0400
Received: by fxm16 with SMTP id 16so3798065fxm.19
        for <git@vger.kernel.org>; Tue, 26 Oct 2010 01:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=P2QKPaGNgyG7ezxvuKXqjFJoOPHi1YZU0ZRH8fgr3XU=;
        b=EOUOJmrJz7QrbwHY/hwdWtijNsEan9Od9m9BLDBwsEwk1R9mLl+3YI6dm/v1Gvp8PV
         Amd+oz5rFGP2GRKoufCNjNS/2WiGYnNkysXtFfJMyuplV5lO8/kSugKQlCTyZU+C/Zga
         KetWcp6rkvA4D1tUVDYklwKDuUU4aFE+2203A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=p15nNIqaRH3f/+uAjcCMhfZ5nrIvdvUKPX/e+qMoJ5Vtg6JgkKtEMfbSS5leA0seZ8
         XRJ1vOCm7JwCalsnEhOX3fSeaPf1f9W+m37CQG8LmyUZoFNN4nAD7MpMNvac1zNSBDx4
         8AP+RlcGb6gcZIW2Z7C+JA2EA+FvHRIuMkURQ=
Received: by 10.223.104.198 with SMTP id q6mr506491fao.13.1288080187818; Tue,
 26 Oct 2010 01:03:07 -0700 (PDT)
Received: by 10.223.115.5 with HTTP; Tue, 26 Oct 2010 01:03:07 -0700 (PDT)
In-Reply-To: <AANLkTinghepgdMRjEBhpAMz-Mr0g7szKyYEDfE=ttstS@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159984>

On Tue, Oct 26, 2010 at 08:44, Rado Dr. <radodr@gmail.com> wrote:
> I have "Segmentation fault" error after "git status" command in one o=
f
> my local repos. Just i one repo, other repos are OK. I can't find any
> clue how to fix it, and as usually I need work with that repo ;-)
>
> I tried this:
> =C2=A0- git gc =C2=A0-> OK
> =C2=A0- git fsck ->
> missing blob 0000000000000000000000000000000000000000
> dangling blob 2f1f0144f786ca887c4911a064bbb28a047f1f77
> dangling blob 7ffb0f4e430cd60261661138df61ecb50cf1d0a4
>
> Is this the reason of fault? If yes, how can=C2=A0I fix it.
>
> My system info:
> Linux 32bit,=C2=A0Ubuntu 10.04 LTS - Lucid Lynx,
> git version 1.7.0.4

Can you reproduce it on the latest version of git built from git.git?

Can you run it under gdb and provide a "bt full" backtrace?
