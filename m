From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: [PATCH 3/8] git-p4: add missing newline in initial import message
Date: Tue, 8 Feb 2011 09:48:50 +0100
Message-ID: <AANLkTikAqDNwGbFfZ=kNyJ4rxdTmesaOmtPYmM3bLf_6@mail.gmail.com>
References: <20110205224848.GA30963@arf.padd.com>
	<20110205225155.GD30963@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Feb 08 09:48:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmjFo-0006GB-RG
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 09:48:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418Ab1BHIsv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Feb 2011 03:48:51 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35516 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341Ab1BHIsu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Feb 2011 03:48:50 -0500
Received: by ywo7 with SMTP id 7so1846707ywo.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 00:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=za0f7FnoObZBO/5kQ9MMUqzoajFfFrIvu4Mf0FQtIyc=;
        b=K4TFytfEM8X3IhJv72CAcrui8cpAJDVw7qKfq31dsA3GcGpEdkIdq4FbCeSSNLB+Dc
         JDkfM0p0Qhw+16Afs3BXw8TAkxJ8NRhepL6ocRKUKIwNACI6JZ8Yw+oRhyFXTVUz7H+b
         x/Z+wvZssOVMqSg3OPmqRtJNa6TQ6zJ0Mm+vY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k95khBj0nZ21zHsMFwG+ddQNsKpo0nyvTVKDB3fj9VYwYXazVvvS3TYH/YVMKPDrWI
         GWNEXq1oBwJ7B926GADFdX81HDCjjiarZDjiQcJANITCom8N7wL0tgG36ROBNK6EXeBw
         P7WXEUzQPZM0A7JITnm8GtFd7qtfo44bbSo+o=
Received: by 10.101.6.12 with SMTP id j12mr10530404ani.46.1297154930138; Tue,
 08 Feb 2011 00:48:50 -0800 (PST)
Received: by 10.101.1.19 with HTTP; Tue, 8 Feb 2011 00:48:50 -0800 (PST)
In-Reply-To: <20110205225155.GD30963@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166338>

On Sat, Feb 5, 2011 at 11:51 PM, Pete Wyckoff <pw@padd.com> wrote:
> The commit message looks wrong without the newline.
>
> Signed-off-by: Pete Wyckoff <pw@padd.com>

Acked-By: Tor Arvid Lund <torarvid@gmail.com>

> ---
> =C2=A0contrib/fast-import/git-p4 | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 2fefea4..d2ba215 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -1429,7 +1429,7 @@ class P4Sync(Command):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 print "Doing initial import of %s from re=
vision %s into %s" % (' '.join(self.depotPaths), revision, self.branch)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 details =3D { "user" : "git perforce impo=
rt user", "time" : int(time.time()) }
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0details["desc"] =3D ("Initial import of =
%s from the state at revision %s"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0details["desc"] =3D ("Initial import of =
%s from the state at revision %s\n"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0% (' '.join(self.depotPaths), revision))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 details["change"] =3D revision
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 newestRevision =3D 0
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
