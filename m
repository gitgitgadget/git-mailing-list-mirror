From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] rebase: pass --signoff option to git am
Date: Sun, 28 Nov 2010 01:32:54 +0100
Message-ID: <AANLkTi=qAus_w18sYXP7m+jtQOGtgkNrsxgiNcbHevC7@mail.gmail.com>
References: <1290856542-6070-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 28 01:44:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMVNM-0003we-IF
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 01:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753857Ab0K1AdQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Nov 2010 19:33:16 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58410 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846Ab0K1AdP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Nov 2010 19:33:15 -0500
Received: by gyb11 with SMTP id 11so1464582gyb.19
        for <git@vger.kernel.org>; Sat, 27 Nov 2010 16:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=5x5KoZ5YrB92SJq6ZDwogKrD1m/iWdUn2m3gSN1UI34=;
        b=N7UErKvVpdhiS3VbkKz9FiUawywIGCOk5mXoc1rvtO9lCxAgFex+9EJ/RMudTOr0iu
         4T3TwRSPdOEWH7G4GuKQjATmo0BsF/Afx4G55RZlmoYNoipii8PhMhp26IS0G4ssZDav
         zdrJJvCkzquekOxQZ8ClihTFYWkBxRHTLUBTM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=hEz0gU+dTgqMTu+lfaW/6gNqsz+CQCiUX/0JuOqrcNqW93ee8CzHDdd3WXj6zqX2mh
         yaAXnj3459dCJFzcxrJ3ztwhWOpgR0ghPvJ3UvC4ZQHDvzfjugnLY1EhMZ7UuGOf6YOv
         EMWL5/T/bNoELgB1Z+9OH2rzDcYqRwVNHFCNc=
Received: by 10.150.97.1 with SMTP id u1mr7806614ybb.74.1290904394491; Sat, 27
 Nov 2010 16:33:14 -0800 (PST)
Received: by 10.151.100.19 with HTTP; Sat, 27 Nov 2010 16:32:54 -0800 (PST)
In-Reply-To: <1290856542-6070-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162330>

Heya,

On Sat, Nov 27, 2010 at 12:15, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> =C2=A0-p::
> =C2=A0--preserve-merges::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Instead of ignoring merges, try to recreat=
e them.
> +
> +--signoff::
> + =C2=A0 =C2=A0 =C2=A0 This flag is passed to 'git am' to sign off al=
l the rebased
> + =C2=A0 =C2=A0 =C2=A0 commits (see linkgit:git-am[1]).
> + =C2=A0 =C2=A0 =C2=A0 Incompatible with the --interactive option.

The one above that does have a shorthand (-p), why should we (not?)
give --signoff it's customary -s shorthand here?

--=20
Cheers,

Sverre Rabbelier
