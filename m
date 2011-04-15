From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCHv2] doc: Clarify that "cherry-pick -x" does not use "git notes"
Date: Fri, 15 Apr 2011 18:22:07 -0400
Message-ID: <BANLkTi=HecmdGbEX5inqUi4FZ5Ty+L1Ybg@mail.gmail.com>
References: <4DA7F73B.9050007@gmail.com> <7v7have8wo.fsf@alter.siamese.dyndns.org>
 <4DA8862F.5070102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 00:22:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QArPX-0005jq-Ls
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 00:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757407Ab1DOWWj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Apr 2011 18:22:39 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56929 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757215Ab1DOWWi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2011 18:22:38 -0400
Received: by ewy4 with SMTP id 4so879197ewy.19
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 15:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=Fnh0UU5JMJyvTuabVDgtOcVsY4ZY+44MDj5YZgwb5O0=;
        b=CJSeuSjceAWzad3kisUucu24IEtxqW2wXwGOk019By1EFz1QQWIxB3VRR5ii52p+FW
         Z0aWSh0PhYFrP7nNRVOWhjNRY3u/UwBLfxx0aZMphYJQA3zMHgVaXIkp8KYGxS2NpY6h
         Szq543V5dvloaYvmtOfVZlb1UoYSc9duxgOYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=LG3OB2BBn5L/SRYupunRKUzBK+xg8n9y30JKRVPGI34Zt8q1hvR/wT6k7xI5OQasI3
         Z9se0TyMuZBE28Yu1TwQgDtj4X6WmDxCUlVmIj4qwDNox8R9WB/aFtNx18aXA+x6VgaJ
         F0xod8SZRtq1tUDK0QojTQZ0ERfzShAbJ8A3s=
Received: by 10.213.20.220 with SMTP id g28mr1223266ebb.26.1302906157191; Fri,
 15 Apr 2011 15:22:37 -0700 (PDT)
Received: by 10.213.29.142 with HTTP; Fri, 15 Apr 2011 15:22:07 -0700 (PDT)
In-Reply-To: <4DA8862F.5070102@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171644>

On Fri, Apr 15, 2011 at 1:53 PM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> The documentation for "cherry-pick -x" could be misread in the way th=
at a
> "git notes" object is attached to the new commit, which is not the ca=
se.
>
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
> =C2=A0Documentation/git-cherry-pick.txt | =C2=A0 =C2=A07 ++++---
> =C2=A01 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-ch=
erry-pick.txt
> index 01db830..9d8fe0d 100644
> --- a/Documentation/git-cherry-pick.txt
> +++ b/Documentation/git-cherry-pick.txt
> @@ -51,9 +51,10 @@ OPTIONS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0message prior to committing.
>
> =C2=A0-x::
> - =C2=A0 =C2=A0 =C2=A0 When recording the commit, append to the origi=
nal commit
> - =C2=A0 =C2=A0 =C2=A0 message a note that indicates which commit thi=
s change
> - =C2=A0 =C2=A0 =C2=A0 was cherry-picked from. =C2=A0Append the note =
only for cherry
> + =C2=A0 =C2=A0 =C2=A0 When recording the commit, append a line that =
says
> + =C2=A0 =C2=A0 =C2=A0 "(cherry picked from commit ...)" to the origi=
nal commit
> + =C2=A0 =C2=A0 =C2=A0 message in order to indicate which commit this=
 change was
> + =C2=A0 =C2=A0 =C2=A0 cherry-picked from. =C2=A0This is done only fo=
r cherry
> =C2=A0 =C2=A0 =C2=A0 =C2=A0picks without conflicts. =C2=A0Do not use =
this option if
> =C2=A0 =C2=A0 =C2=A0 =C2=A0you are cherry-picking from your private b=
ranch because
> =C2=A0 =C2=A0 =C2=A0 =C2=A0the information is useless to the recipien=
t. =C2=A0If on the

As long as you're nearby, "This is done only for cherry=C2=A0picks with=
out
conflicts." can be dropped. It's no longer true.

j.
