From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] attr: support quoting pathname patterns in C style
Date: Thu, 4 Nov 2010 18:21:04 +0100
Message-ID: <AANLkTik1We+3C7okfXuOL7m54M+H1O6jY7nOdxx_G14T@mail.gmail.com>
References: <AANLkTinNctmWpshBeSTzZRm6+EJ=Cjdpoaj4Aon+52_b@mail.gmail.com> <1288878944-14066-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marc Strapetz <marc.strapetz@syntevo.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 18:21:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE3VS-0006E7-TP
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 18:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982Ab0KDRV2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 13:21:28 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:45818 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab0KDRVZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 13:21:25 -0400
Received: by gxk23 with SMTP id 23so1600181gxk.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 10:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=K4NNzuJbRX3f0dxGlra77Dy3d4BkVVx8jZL7tWhKhhg=;
        b=dFQ1Wvj+2F+puNDgQ5wUerVcQCZvRa/wR2Ng/uMdGIFBKbdyFEht3dBHS7dfsKyTMH
         h4n5qDVWFhN4uXOsUzxy8OBFcWH2NwgKmhUWdlQNU4cxXWD7ObvSEZ2xXTQ7Gnlq4bzT
         BU9whrhqQRGuds5BmUFNsgei1wr9Gy+z5Zm5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ZwU5L3kpdWKsUKVGdCUOjI3p4RUW/oIoOdhBy/SrFNwiIcGaA845QchKzLaWxEANas
         B3Pn5INFSP/BPSOzmh8vgv69E8f4hFXg8aS/yMY8U3thMk8Hs+9WIr5H3GJ/Yv9okgum
         WDY0m/mw/WETrSDT3N8U5/N/1l/qiT6WCkjSE=
Received: by 10.150.217.7 with SMTP id p7mr1672313ybg.312.1288891284789; Thu,
 04 Nov 2010 10:21:24 -0700 (PDT)
Received: by 10.150.58.11 with HTTP; Thu, 4 Nov 2010 10:21:04 -0700 (PDT)
In-Reply-To: <1288878944-14066-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160736>

Heya,

2010/11/4 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> =C2=A0Obvious regression: patterns that begin with double quote will
> =C2=A0now work differently.

It's a behavior change, not a regression (a regression is an
_unintended_ behavior change).

--=20
Cheers,

Sverre Rabbelier
