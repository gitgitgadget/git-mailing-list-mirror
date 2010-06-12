From: Scott Chacon <schacon@gmail.com>
Subject: Re: [PATCH v2] Group the default git help message by topic
Date: Sat, 12 Jun 2010 09:17:29 -0700
Message-ID: <AANLkTikYIePjF-ZMKh4fS_Gs6AEcImbCY1X7M4FYaEwy@mail.gmail.com>
References: <AANLkTiloErvcWS1hW80cIV9SiWu_7CBdNSx_iAppcGOd@mail.gmail.com>
	<422F3619-25EC-4509-8EE3-78B6C765AB2A@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Jun 12 18:17:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONTOr-00083Y-Ty
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 18:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743Ab0FLQRc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jun 2010 12:17:32 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47514 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab0FLQRa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jun 2010 12:17:30 -0400
Received: by wyb40 with SMTP id 40so2090398wyb.19
        for <git@vger.kernel.org>; Sat, 12 Jun 2010 09:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iXrOy9qx3Su44GnX/FD8JTK19G6TeID5BmMXJc4ZIQI=;
        b=vUiQWhB1EUqu3ydbLt5BMKxjiaHv7pBBbClsMIQaXp4udo/kBIMRIrmyqEU2sLgL5p
         AthjzoSEqneVws/w6vo7Kjmb46nVcRHiJnh9B0D1A1dKj3kwFODbYnLQEUg/HEjr/HQ9
         PwAOm71++0Ry8WgDrUOz0EvA/uCC86zt139E4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mlihV6YuHiIqlDP0IlzhcjnynYpfNiQ/dBqu5VSgwMxYkAuTA+nXl+12BKmmXH+u3q
         KquAIKubNWoeEX4KSLLohX9ujokJrbVlGLdGZsaHw80nBVKzadrZ/nmX92rx+OuiDELA
         HBNKoE4zN7dw82yP+SewTIPPt8g6+IXW2ZB8I=
Received: by 10.216.154.7 with SMTP id g7mr538274wek.30.1276359449282; Sat, 12 
	Jun 2010 09:17:29 -0700 (PDT)
Received: by 10.216.23.71 with HTTP; Sat, 12 Jun 2010 09:17:29 -0700 (PDT)
In-Reply-To: <422F3619-25EC-4509-8EE3-78B6C765AB2A@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149010>

Hey,

On Fri, Jun 11, 2010 at 9:26 AM, Wincent Colaiuta <win@wincent.com> wro=
te:
>
> Nice. I'm sure the output will be a bit less intimidating, but I am n=
ot sure about some of the grouping choices you've made here.
>
> "git checkout" is almost certainly a "Basic" command, even though it'=
s used for creating and switching branches.

I wanted the basic commands to be commands that you had to know to use
git.  You really don't actually *have* to know 'checkout' - you only
need to know it if you're using branches, or in a more advanced case,
want to revert file contents.  To just commit snapshots, 'checkout' is
not a necessary command.

>
> "git tag" doesn't really seem to be a "Branch" command, as it's for t=
agging objects (usually commits), and not branches.

This is true - I suppose it probably actually fits better under
'history', since that's what you're doing is bookmarking a point in
history.

>
> "git reset" is the odd one out in the "History" commands group. The o=
ther three commands are about _inspecting_ history, whereas "git reset"=
 is about changing the current HEAD. I actually think "git reset" fits =
better with the "Branch" commands.
>

I guess - I suppose I put it there because I mainly use it to rewind
my history (reset HEAD~) but it could go under branches.  While we're
at it, I'm not sure 'show' is really necessary in this list at all.  I
rarely use it, which I guess means it's not *terribly* important for
day to day use.

> I think I'd be inclined to use more descriptive headings and group th=
e commands like this:
>
> =C2=A0Basic operation:
> =C2=A0 =C2=A0init
> =C2=A0 =C2=A0add
> =C2=A0 =C2=A0status
> =C2=A0 =C2=A0commit
> =C2=A0 =C2=A0checkout
>
> =C2=A0Inspecting repository state and history:
> =C2=A0 =C2=A0log
> =C2=A0 =C2=A0diff
> =C2=A0 =C2=A0show
>
> =C2=A0Working with branches:
> =C2=A0 =C2=A0branch
> =C2=A0 =C2=A0merge
> =C2=A0 =C2=A0reset
>
> =C2=A0Interacting with other repositories:
> =C2=A0 =C2=A0clone
> =C2=A0 =C2=A0fetch
> =C2=A0 =C2=A0pull
> =C2=A0 =C2=A0push
> =C2=A0 =C2=A0remote
>

I kind of like the more descriptive headings, but I still think
'clone' should be in the 'basics' section, because everyone needs to
know that, but I had it in the 'remotes' section at first too, so I
wouldn't be terribly opposed to moving it back down there.  I really
don't want 'checkout' in 'basic' - there is no good reason I can see
to not have it in 'branches'.

Scott
