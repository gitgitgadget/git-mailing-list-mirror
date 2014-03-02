From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] rebase: accept -<number> as another way of saying HEAD~<number>
Date: Sun, 2 Mar 2014 03:55:01 -0500
Message-ID: <CAPig+cSFWT6kwZUFFUE3=TcfHRUJnx54+fcZCzJwmOSJKFsYeA@mail.gmail.com>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
	<1393728794-29566-1-git-send-email-pclouds@gmail.com>
	<1393728794-29566-3-git-send-email-pclouds@gmail.com>
	<CAPig+cSPKSsVG_yqaQfOCswaENKdUGrWt_YcQ3yZCpgG5jQ+JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 09:55:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WK2Ax-00058p-2U
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 09:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbaCBIzD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Mar 2014 03:55:03 -0500
Received: from mail-yh0-f43.google.com ([209.85.213.43]:63342 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbaCBIzC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Mar 2014 03:55:02 -0500
Received: by mail-yh0-f43.google.com with SMTP id b6so2100139yha.30
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 00:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=tgE5oo1V7V1pxEvXai4rXe9jJCVKQabj0SK9tBrxRs8=;
        b=Ws1rOft/mXjTcMeGiTs2/SKuQNV/omQUiDNawUz9UuwtGBg7XFzuVTGF8cPHp4XbJ5
         q9tfZvbQFOMzhwcZ1nTLB9Sh7n23T3Fv9dQbWnhfB09K79ycNCFvydH0FQOcjYs9Lsyw
         Abwo+ZaQCJatNNHRzrCr0eFWiTk/APpC/+TthSapM3xmjrQRUh6IBNk3LCgNgkuyQFzM
         vzCk0mu34i8gcZTlPLuHGhllUUkESqTNzHkteqXa3nNa7BdaFZMhupVezShmUDH/Mwkr
         xTbjZJvC0FyLu/CiR3eVA4duVHmf2Qt+TiXAdpXRjyIDI4aKhp9lwu+pSdJJ3E27tbfs
         eaWA==
X-Received: by 10.236.44.34 with SMTP id m22mr14778876yhb.9.1393750501434;
 Sun, 02 Mar 2014 00:55:01 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Sun, 2 Mar 2014 00:55:01 -0800 (PST)
In-Reply-To: <CAPig+cSPKSsVG_yqaQfOCswaENKdUGrWt_YcQ3yZCpgG5jQ+JQ@mail.gmail.com>
X-Google-Sender-Auth: gIw_3LK1o3ogf7ykxPy4MzNwybU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243143>

On Sun, Mar 2, 2014 at 3:53 AM, Eric Sunshine <sunshine@sunshineco.com>=
 wrote:
> On Sat, Mar 1, 2014 at 9:53 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy <pclouds@gmail.com> wrote:
>> This is "rev-list style", where people can do "git rev-list -3" in
>> addition to "git rev-list HEAD~3". A lot of commands are driven by t=
he
>> revision machinery and also accept this form. This addition to rebas=
e
>> is just for convenience.
>
> I'm seeing some pretty strange results with this. If I use -1, -2, or
> -3 then it rebases the expected commits, however, -4 gives me 9
> commits, and -5 rebases 35 commits. Am I misunderstanding how this
> works?

Nevermind. I wasn't paying attention to the fact that I was attempting
to rebase merges.
