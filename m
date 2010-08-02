From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2] t/README: Document the Smoke testing
Date: Mon, 2 Aug 2010 17:05:50 -0500
Message-ID: <AANLkTinNwUsYuB0Wb3aT5ZpnzT24YpmphCEE_TwTPgsG@mail.gmail.com>
References: <1280780684-26344-1-git-send-email-avarab@gmail.com> 
	<1280780684-26344-3-git-send-email-avarab@gmail.com> <AANLkTim2EY7AACe=UzbG-k7oteV6UMmfPAQMEOFn0iZ7@mail.gmail.com> 
	<4C5732CE.10906@gmail.com> <AANLkTi=EuTD0M3eNo+PXW7Z2Ra2yzf-i+L4DFQVg8JZ7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitzilla@gmail.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 03 00:06:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og39F-0006jt-Os
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 00:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499Ab0HBWGM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 18:06:12 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33456 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893Ab0HBWGK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 18:06:10 -0400
Received: by ywh1 with SMTP id 1so1392054ywh.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 15:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=TcI+CieIKv/K5WfxcgIn1MIm59sC5N7tiKCVO8zdIjQ=;
        b=kIJ3Y3nvE4tzZC0YrliaKICM+KS+h+I1EHdxNptG1y5CnJWv9D3YuM1wFRd3i84mKp
         YFBLt2gRUQ5xlD62p21SRntntHMf5r31yGHL2R35Ib2JBb+0iFw7LHTc971jA8nxe+OW
         /bm3tSl429032+ry0OXLZsC7BY6U1b6NMBs4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xX1Y0uVFl3ELqBLdxnH5wMjuyZZE4GYT8VrVChpDW4c8HBaApn+IhrQiBUzuo+bg2d
         L5i5Idw5AxBWdacZJq0nywjWrbhMRGCnU8YQOoUFfBQKYpsZ6dxL+NZ78jf9GwNVFoew
         EyYXBUodqtFV5/2JvgNHIkDBkF7g5f/K2H/6c=
Received: by 10.150.63.14 with SMTP id l14mr7856737yba.155.1280786770168; Mon, 
	02 Aug 2010 15:06:10 -0700 (PDT)
Received: by 10.150.66.12 with HTTP; Mon, 2 Aug 2010 15:05:50 -0700 (PDT)
In-Reply-To: <AANLkTi=EuTD0M3eNo+PXW7Z2Ra2yzf-i+L4DFQVg8JZ7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152469>

Heya,

[+Warthog9]

On Mon, Aug 2, 2010 at 17:00, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> Do you not like the domain, that the domain's A record points to a
> Linode box, or both?

The former.

> I don't mind where a smoke server gets hosted, I just want it to be
> there. But someone's going to have to host it and maintain it.

Agreed.

> Of course just changing the domain would be trivial, just a matter of
> someone setting up an A record somewhere, or delegating a zone to me.

John, is it possible to have smoke.git.kernel.org (or such a domain)
either point at a server =C3=86var controls, or to give him a shell acc=
ount
there? The point is to have http://smoke.git.nix.is/ hosted on a more
"Gitty" domain.

> An alternative would be to change how this works, e.g. making
> submissions go by E-Mail to a public list, or having smokers push the=
m
> to public Git repositories which would be registered somewhere.

I like the idea of having it be a public Git repo since that would
probably make it easier to do maintenance on the repo (e.g., revert
"vandalism"), but there still needs to be a frontend of sorts
somewhere :).

--=20
Cheers,

Sverre Rabbelier
