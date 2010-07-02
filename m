From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [WIP/PATCH] Teach fast-import to print the id of each imported 
	commit
Date: Fri, 2 Jul 2010 06:29:36 +0200
Message-ID: <AANLkTiksZygUvp-9jK_qZ9bvjETg-V3-uoZnRZFgYI1n@mail.gmail.com>
References: <20100701031819.GA12524@burratino> <20100701054849.GA14972@burratino> 
	<AANLkTim2DnettF2gNTQVaJvrpzwrTP_-HWTp8l6R5TVc@mail.gmail.com> 
	<20100702034125.GA7209@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 06:30:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUXt7-0000QL-Rg
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 06:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428Ab0GBE36 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 00:29:58 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47305 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab0GBE35 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jul 2010 00:29:57 -0400
Received: by gye5 with SMTP id 5so234544gye.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 21:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=d1L8aSpmQbhHoc+eEUqrCrmJ/71yoA625TN0mLyph5Q=;
        b=jGDXnQK3r+WM9erLjNw9h/cGIkZirPPZ7K6GHugeOkUPMauZFhCgmGCyskcr/HdaPc
         f86X+9IW6kStmHk66EvkGPuVsxxXFzVvnDkprDiOUsOTPfDSrhQvUy3gAalhz53Y5sU8
         +Bj4VRfXysdyxwXK2sXErGROXr7+lYLTpF+3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=uUN9JsX4stkiZ19YmhF7Ly/LWZs/KorXF/5KBeqTzbBMcZknOfjQNqIAt/FAu4K+PG
         datF3ZGcYCqVJNnwG9vIe6HE41cDHFbwOzrjYdK/xSV9keK36gxkWeVX70OXcznt7JtN
         k//BBa5ZYF3dNJfiSQK2E6YV5cDJtKUUJ1ZqE=
Received: by 10.90.88.20 with SMTP id l20mr971288agb.7.1278044996199; Thu, 01 
	Jul 2010 21:29:56 -0700 (PDT)
Received: by 10.150.184.8 with HTTP; Thu, 1 Jul 2010 21:29:36 -0700 (PDT)
In-Reply-To: <20100702034125.GA7209@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150105>

Heya,

On Fri, Jul 2, 2010 at 05:41, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> fast-import writes objects directly to pack --- part of the secret to
> its speed.

Aah, so only after a 'checkpoint', I see.

> See store_object() in fast-import.c, or you can play around with the
> test from my WIP patch to try it out (removing the =E2=80=98sleep 1=E2=
=80=99).

Okay, in that case I think your other patch is made of even more win :)

--=20
Cheers,

Sverre Rabbelier
