From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/6] nd/worktree-cleanup-post-head-protection update
Date: Sun, 22 May 2016 21:09:23 -0400
Message-ID: <CAPig+cQ2NRO4yaFkcGmUpY3TZcWkdg-vu6d7Fq7JgHzYSkcRgg@mail.gmail.com>
References: <20160510141416.GA22672@lanh>
	<20160522093356.22389-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 03:09:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4eN6-0004JZ-Gm
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 03:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753AbcEWBJY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2016 21:09:24 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36721 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711AbcEWBJY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2016 21:09:24 -0400
Received: by mail-io0-f193.google.com with SMTP id a79so15858225ioe.3
        for <git@vger.kernel.org>; Sun, 22 May 2016 18:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=j802Fgs/qYbO/ChKxPYXBNZS8/WSO3DzxMHBjCclP2A=;
        b=JPFN7pqg7US9aOK4ZSTW50qGWA8cUVy5fPDIPiomvIEIzJe3W9QjWJAPoDpT+aLyux
         wA201rydwz6XZ+c5Cb49LbfxrHasNxTRoHagZs3uhHy2vzjn/uFiPZ7SBj1v+lw5wgVT
         hL2vHNh9Qis/fRDFpz8BhhVtcB5vYEYmvOzMPZPWxLH9a6Rtsq1/GKTpx4Q5cEDQthwt
         JHHKhXc7e+ejRalIhezR0HUdlLFB87VaCwXNuQ7hkBo19S2NfeQUhr2VrtqR/eY8owvz
         2Ok8Vyq39k+QQnFO57QR0Y04PDMXA08DQ7JW/7Fugs7V6JNqfN2tkkwwrgsfhlBK796x
         x96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=j802Fgs/qYbO/ChKxPYXBNZS8/WSO3DzxMHBjCclP2A=;
        b=P01GrkvlBnxSyGZ/XrZ1a2ASEceZUf/6vcGcboAczJG+8X9OV93y6HnMBF5MjlhpBS
         MsFdNhkNekTQNvWim8rLpHTX4R9DWCTaE/rXroJZQjcphUPiM1TkpF5vvM9Py7s8pvJi
         PgtOJuTxmXIJU33Oxg0xly+mJ34FH9GjLNLdZbIi7nXB8o9+dXZuKUq/mcOGl6lcdQwV
         TqZ3+lxjDC73fjz6XQM+w6fB2VDeRpzuXDccsNO31pU1wnT4XrQHeIj/hZsfwjuuS+Zw
         DCjo/M4lHXgIdC1uaLtmkOelYnSRRNE7NODJlg4arEgjafzMgujWVJfQXoeArljHiNSh
         fZhQ==
X-Gm-Message-State: AOPr4FU5i332lAfPPeRPLNVGlq4JoWC6ZTpie+X2LYt7+SPxoNX7Pt8dfCR6wnahKMsNSj6I2OK4lNFLzSYukQ==
X-Received: by 10.107.47.37 with SMTP id j37mr10082020ioo.168.1463965763083;
 Sun, 22 May 2016 18:09:23 -0700 (PDT)
Received: by 10.79.110.21 with HTTP; Sun, 22 May 2016 18:09:23 -0700 (PDT)
In-Reply-To: <20160522093356.22389-1-pclouds@gmail.com>
X-Google-Sender-Auth: gUcsLWQud3FJoll44heYFi6fWBY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295298>

On Sun, May 22, 2016 at 5:33 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> This is mostly commit message update plus
>
>  - dropping "--force" from the completion patch (a comment from Szede=
r
>    Gabor in a previous attempt of worktree completion support).
>
>  - the removal of clear_worktree() patch.
>
> I keep the completion patch anyway even though two versions of it wer=
e
> posted by Eric and Szeder (and didn't get discussed much) because I
> needed this for new commands and because I didn't aim high. It's mean=
t
> to provide very basic completion support. Fancy stuff like ref
> completion can be added later by people who are more experienced in
> bash completion stuff.

Thanks. Dropping the clear_worktree() patch does indeed seem like a
good idea. I've re-read the entire series, and aside from my minor
comments on 6/6, everything looks fine and the series is:

    Reviewed by: Eric Sunshine <sunshine@sunshineco.com>
