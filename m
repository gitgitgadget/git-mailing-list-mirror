From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] New commit option --fixup.
Date: Thu, 7 Oct 2010 10:09:22 +0200
Message-ID: <AANLkTi=c9zCKUnZp3B=m9C99FKOTtz+hY5-GvSXjozHD@mail.gmail.com>
References: <1286405901-13586-1-git-send-email-rodolfo.borges@gmail.com> <AANLkTimHz3sCDh-aicw1agi_mrL8pUztfi32vWv1pXUM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rodolfo Borges <rodolfo.borges@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Pat Notz <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 10:10:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3lYM-00027U-Cb
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 10:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760169Ab0JGIJr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 04:09:47 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45020 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757299Ab0JGIJo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 04:09:44 -0400
Received: by gwj17 with SMTP id 17so177772gwj.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 01:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Q1lfP9tLdn4CitLEsELaDSYP/ZUnIx2x0kBzcLcW4B4=;
        b=DsQMvrYDuPeZUWvxp9p7H8eYygqIycYgv0uERR9WFAV/75jOtW8BeHDh6i/nQhsg8d
         TeuBwk0ibBio51Qd+1K40S0JGj+Xp8YO+POnzrK535hYgxwI0Ti4zlbTGCZoPxGWGgKw
         pRiEocI10AJfL2/X7Y0pB6wuhNAPlwIgm6QJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=bFHuG5HvpW40WHk2Ry4g5Q7QwZpQOTUCymjQE/W8Q4CPf3Wtoys1ZA2neJ9VXUWmHY
         0O+/BrfDg4wxXJROuvZ+yzcNo1g2+yCUTgIBIZiB+FdCZKnpbqqTIzTUifIjccHnz25D
         CuTaN/1aesFuCgoD+XxgCh/gUNV3/nO+9egto=
Received: by 10.151.41.17 with SMTP id t17mr557770ybj.443.1286438983229; Thu,
 07 Oct 2010 01:09:43 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Thu, 7 Oct 2010 01:09:22 -0700 (PDT)
In-Reply-To: <AANLkTimHz3sCDh-aicw1agi_mrL8pUztfi32vWv1pXUM@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158383>

Heya,

On Thu, Oct 7, 2010 at 02:38, Pat Notz <patnotz@gmail.com> wrote:
> Why not just use an alias for this? =C2=A0I do:
>
> git config alias.fixup "commit --amend -C HEAD"

I have a similar alias:

git config alias.amendall "commit --amend -a -C HEAD"

I don't think we need a command to do this, but I'm starting to think
we really should have a list of aliases either ship with git itself,
or with the git documentation.

--=20
Cheers,

Sverre Rabbelier
