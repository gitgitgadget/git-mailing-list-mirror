From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 3/6] git-reset.txt: reset --soft is not a no-op
Date: Mon, 13 Sep 2010 18:13:55 -0400
Message-ID: <AANLkTin1Ht+2Q4v5pyt8p11VmQ275C41rJLMLLuLkEfA@mail.gmail.com>
References: <cover.1284365021.git.git@drmicha.warpmail.net> <f30121dda2c44d2a87f2d2bf651d6a0adfa8c955.1284365021.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 14 00:14:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvHIG-0000BP-9h
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 00:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551Ab0IMWO1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 18:14:27 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39641 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011Ab0IMWO0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Sep 2010 18:14:26 -0400
Received: by iwn5 with SMTP id 5so5478668iwn.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 15:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=yHdI6tKBe24fyEyqFyAgkR73OlHysamawMrIIgHw7Ls=;
        b=qqYLIOmOwnY+yYMtCokGRRjJ2rWA6hPo9qoejBtraiR4L/Pye27qpqfByEXOmZEDk0
         fkfEjQ08K6IwwYDguYcSkYg4yghEvuVWUX7io40cj5oQmKHIBS4fCrLEbhazPNphWQmX
         iVQmF3eo15FYhgbUvw4evWQmy7nDI+xXkPij0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=BJ0xMn38makCO6kHRPmrtN3o+3/+E5aeKTcvfrj2dDseQA+jp8DZGghkhl07xQmIGB
         ICrE7CDbEgKIEe6SEalQnAjsixB4R8D+T3YvDTsHWcRw1UsL7A7HCJdCXxpe6iZoPtAA
         /phg9BzLOXesxfEx8hrDyqISoXUrugzYnBJ3c=
Received: by 10.231.11.72 with SMTP id s8mr6344392ibs.110.1284416065577; Mon,
 13 Sep 2010 15:14:25 -0700 (PDT)
Received: by 10.231.11.11 with HTTP; Mon, 13 Sep 2010 15:13:55 -0700 (PDT)
In-Reply-To: <f30121dda2c44d2a87f2d2bf651d6a0adfa8c955.1284365021.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156146>

On Mon, Sep 13, 2010 at 4:06 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Make it clearer that git reset --soft actually does something (changi=
ng
> HEAD). While it is meantioned in the previous paragraph already it ca=
n
> be easily overlooked otherwise.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> =C2=A0Documentation/git-reset.txt | =C2=A0 =C2=A03 ++-
> =C2=A01 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.tx=
t
> index 8fb871c..65f5d07 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -43,7 +43,8 @@ linkgit:git-add[1]).
> =C2=A0--
> =C2=A0--soft::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Does not touch the index file nor the work=
ing tree at all, but
> - =C2=A0 =C2=A0 =C2=A0 requires them to be in a good order. This leav=
es all your changed
> + =C2=A0 =C2=A0 =C2=A0 requires them to be in good order (and sets th=
e head to <commit>,
> + =C2=A0 =C2=A0 =C2=A0 just like all modes do). This leaves all your =
changed
> =C2=A0 =C2=A0 =C2=A0 =C2=A0files "Changes to be committed", as 'git s=
tatus' would
> =C2=A0 =C2=A0 =C2=A0 =C2=A0put it.

What does "requires them to be in good order" mean anyway?

j.
