From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] For Real - Fixed pluralization in diff reports
Date: Mon, 1 Aug 2011 11:58:48 +0200
Message-ID: <CAGdFq_iwEvD_-hD63KeF45WuRhWrK6JuWWqzDpjHcZ+0gHDaqg@mail.gmail.com>
References: <4E362F8E.1050105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jon Forrest <nobozo@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 11:59:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnpHa-0000aH-VT
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 11:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753754Ab1HAJ7a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Aug 2011 05:59:30 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59090 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088Ab1HAJ73 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2011 05:59:29 -0400
Received: by vws1 with SMTP id 1so4298681vws.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 02:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=AjJjQIKc+vR1VxMLBH2RQ7RuIRtpwwZlBRt3HMMbWEM=;
        b=nxnQ3/gML0n9SBdJ3J9+JEbmqg1MimwufHc7tRKfeFxbcakCH6lMfyG6Kw45vzgSGx
         2dr26sia+kgGGzvSwFvjSy3oKM0tbIdXTBLhAH8ylPPapGZUja2P7xlnS8z7m/JqIY9A
         pMxeNPbyNKsfdZNSQWwBbvW3kv3hxk7dj80HI=
Received: by 10.52.68.164 with SMTP id x4mr4134942vdt.139.1312192768794; Mon,
 01 Aug 2011 02:59:28 -0700 (PDT)
Received: by 10.68.71.162 with HTTP; Mon, 1 Aug 2011 02:58:48 -0700 (PDT)
In-Reply-To: <4E362F8E.1050105@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178324>

Heya,

On Mon, Aug 1, 2011 at 06:46, Jon Forrest <nobozo@gmail.com> wrote:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(options->file, "%s", line_prefix);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(options->file,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0" %d files changed,=
 %d insertions(+), %d deletions(-)\n",
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0total_files, adds, =
dels);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0" %d file%s changed=
, %d insertion%s(+), %d deletion%s(-)\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0total_files, total_=
files =3D=3D 1 ? "" : "s", adds, adds =3D=3D 1 ?
> "" : "s", dels,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dels =3D=3D 1 ? ""=
 : "s");
> =C2=A0}

Also, this is rather detrimental to the i18n effort methinks?

--=20
Cheers,

Sverre Rabbelier
