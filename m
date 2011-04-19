From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC/PATCH] git add: notice removal of tracked paths by default
Date: Tue, 19 Apr 2011 21:46:29 +0200
Message-ID: <BANLkTin4iVLzga6gFAh+x8nRTKuVTTFPqA@mail.gmail.com>
References: <7v1v0y59tv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 21:47:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCGtH-00043m-S2
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 21:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731Ab1DSTrL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Apr 2011 15:47:11 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:49373 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753489Ab1DSTrK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2011 15:47:10 -0400
Received: by qyg14 with SMTP id 14so25808qyg.19
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 12:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=e8SxOBh5SiNZxJXEWlTkJc9uBJIrgMymgSB6diMyBe0=;
        b=EdjgA6908Ta4lZv2raau/sszDa7Ad4HF36wB3X/1hUl2m7u38r7K43Pi+6mE6vB19W
         Ye9cLEt/D0yd7mBOX3BSqO0t4DwmLRISxoNzRdS0+FNx/hx+CtQLDJoyVbFHUojkMJUC
         RMnJRo7zYZXmpqdOxHePVbVB24y9od90mhHy0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=MDmZ72N/EurSmr9YjXgegwhNL8x2rxLrNxe5ny34d75/rKScySugikpalLxzS6kXM0
         ZjCgFGxurPt5NMWgKGziN3GyMfnNDmxiuofDTzmXQudM3V+mK+YATglJOHdf/pmKL+R2
         o6LzOhsEBbJSCu7x1XTQW7yWbv+h4K+Y/B1ko=
Received: by 10.229.43.232 with SMTP id x40mr4849233qce.32.1303242429157; Tue,
 19 Apr 2011 12:47:09 -0700 (PDT)
Received: by 10.229.49.198 with HTTP; Tue, 19 Apr 2011 12:46:29 -0700 (PDT)
In-Reply-To: <7v1v0y59tv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171813>

Heya,

On Tue, Apr 19, 2011 at 21:18, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C2=A0Having "git add ." notice removals might lead to mistakes ("oh,=
 I only
> =C2=A0meant to record additions, and didn't want to record the remova=
ls"), but
> =C2=A0at the same time, leaving it not notice removals would lead to =
mistakes
> =C2=A0by the other people ("I added, removed and edited different pat=
hs, but
> =C2=A0why only removals are ignored?").

Is there a way to add disable this somehow? I don't think we have a
'--no-update', do we?

--=20
Cheers,

Sverre Rabbelier
