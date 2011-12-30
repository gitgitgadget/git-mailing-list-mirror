From: Christian Couder <christian.couder@gmail.com>
Subject: Re: What's the best way to push/fetch replace refs?
Date: Fri, 30 Dec 2011 15:51:43 +0100
Message-ID: <CAP8UFD3KSjdZz1q+QYsH4JpRkiavtTbT1WqQSdxqCaxc24j=Rg@mail.gmail.com>
References: <CAA61mJgCjt0O5LE5OQ=aNbtUHCZeZdZ=3dXYTNv_AhFi7JXwkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Slawomir Testowy <slawomir.testowy@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 30 15:52:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RgdoW-0006qz-8F
	for gcvg-git-2@lo.gmane.org; Fri, 30 Dec 2011 15:52:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710Ab1L3Ovq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Dec 2011 09:51:46 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51733 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382Ab1L3Ovo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Dec 2011 09:51:44 -0500
Received: by pbdu13 with SMTP id u13so7202737pbd.19
        for <git@vger.kernel.org>; Fri, 30 Dec 2011 06:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=5E9qUsOUbP2xMr9MPXBZLZtSQnF5xH7IyMCLTGQhJhc=;
        b=TfEvp52Bv2plJpYyBpPYrUnHmUy0IXxrQDy6izMTjIsvwvPR51FuixFGtHkxKApQZd
         GVJwNi+6Tmp9aXJiiVsq3kXlN88nv9PacEd+1Sju843dDZ/Xs75ogR90wLrn8pkxBArg
         I1uhp9KvM7o5/NbKnogBRQlIwCXq9orO5vhwQ=
Received: by 10.68.213.138 with SMTP id ns10mr96919729pbc.53.1325256704086;
 Fri, 30 Dec 2011 06:51:44 -0800 (PST)
Received: by 10.143.141.8 with HTTP; Fri, 30 Dec 2011 06:51:43 -0800 (PST)
In-Reply-To: <CAA61mJgCjt0O5LE5OQ=aNbtUHCZeZdZ=3dXYTNv_AhFi7JXwkA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187804>

On Fri, Dec 30, 2011 at 12:59 PM, Slawomir Testowy
<slawomir.testowy@gmail.com> wrote:
>
> # I also added "fetch =3D +refs/replace/*:refs/replace/*" to [remote
> "origin"] in "b" and this also seems to work.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html

Yeah, the simplest is probably to just add "fetch =3D
+refs/replace/*:refs/replace/*" to the remote(s) you want to get the
replace refs from, and "push =3D +refs/replace/*:refs/replace/*" to the
remote(s) you want to push the replace refs to.

Regards,
Christian.
