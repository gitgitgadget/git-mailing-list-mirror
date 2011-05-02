From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] Documentation: clarify meaning of --html-path,
 --man-path, and --info-path
Date: Mon, 2 May 2011 16:49:21 +1000
Message-ID: <BANLkTika6j_Ja3LYLvq7aLFzD-hsqQQeWw@mail.gmail.com>
References: <1304237785-56101-1-git-send-email-jon.seymour@gmail.com>
	<20110502060745.GC14547@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 02 08:49:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGmwm-0007C9-27
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 08:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755556Ab1EBGtZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2011 02:49:25 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63024 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952Ab1EBGtW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2011 02:49:22 -0400
Received: by vws1 with SMTP id 1so4029994vws.19
        for <git@vger.kernel.org>; Sun, 01 May 2011 23:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6w2jzpgWENzmZmFfRXFHp+K4yqG8ZBSgCaQbpwRlBSM=;
        b=rdHucnswTnCygmx+EgGDYMQjJ4LjeoHmTrWLHFeq23qFZngrwA498vtvNd5O3F2oti
         qVaBAcMCtLUEW0pnSK3sAxdLqzNOWTZAFwTGfiW6RURvVR/Iq1VWLG5GNz2i8FKgvTCr
         MIx46Tp2q4r90ah4Tkjotplwlwfv/ETXzUgLM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dhNiW1gO0KWqicZiRpqMopppuBbsKspX+5bRLch9oygxPPKbdEpQE7m/L8P19ckRbp
         tSQgDzAcI+rGiM7kbAMAgpE+CXyhGDKa+WgXrMTsF/YHJ446AbLo3t67unmTZzf+d8mL
         bF7jsawLjCYaP0CQ2R5oLG6OTxwWeI8gTTsEc=
Received: by 10.52.177.196 with SMTP id cs4mr4210359vdc.279.1304318961123;
 Sun, 01 May 2011 23:49:21 -0700 (PDT)
Received: by 10.52.160.66 with HTTP; Sun, 1 May 2011 23:49:21 -0700 (PDT)
In-Reply-To: <20110502060745.GC14547@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172564>

Acked.

On Mon, May 2, 2011 at 4:07 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> These options tell UI programs where git put its documentation, so
> "Help" actions can show the documentation for *this* version of git
> without regard to how MANPATH and INFOPATH are set up. =C2=A0Details:
>
> . Each variable tells where documentation is expected to be. =C2=A0Th=
ey do
> =C2=A0not indicate whether documentation was actually installed.
>
> . The output of "git --html-path" is an absolute path and can be used
> =C2=A0in "file://$(git --html-path)/git-add.html" to name the HTML fi=
le
> =C2=A0documenting a particular command.
>
> . --man-path names a manual page hierarchy (e.g.,
> =C2=A0/home/user/share/man). =C2=A0Its output can be passed to "man -=
M" or put
> =C2=A0at the beginning of $MANPATH.
>
> . --info-path names a directory with info files (e.g.,
> =C2=A0/home/user/share/info). =C2=A0Its output is suitable as an argu=
ment to
> =C2=A0"info -d" or for inclusion in $INFOPATH.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Sorry for the long tangent. =C2=A0Maybe a summary can be useful.
>
> =C2=A0Documentation/git.txt | =C2=A0 12 ++++++------
> =C2=A01 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 7e9b521..5295315 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -287,16 +287,16 @@ help ...`.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0the current setting and then exit.
>
> =C2=A0--html-path::
> - =C2=A0 =C2=A0 =C2=A0 Print the path to wherever your git HTML docum=
entation is installed
> - =C2=A0 =C2=A0 =C2=A0 and exit.
> + =C2=A0 =C2=A0 =C2=A0 Print the path, without trailing slash, where =
git's HTML
> + =C2=A0 =C2=A0 =C2=A0 documentation is installed and exit.
>
> =C2=A0--man-path::
> - =C2=A0 =C2=A0 =C2=A0 Print the path to wherever your git man pages =
are installed
> - =C2=A0 =C2=A0 =C2=A0 and exit.
> + =C2=A0 =C2=A0 =C2=A0 Print the manpath (see `man(1)`) for the man p=
ages for
> + =C2=A0 =C2=A0 =C2=A0 this version of git and exit.
>
> =C2=A0--info-path::
> - =C2=A0 =C2=A0 =C2=A0 Print the path to wherever your git Info files=
 are installed
> - =C2=A0 =C2=A0 =C2=A0 and exit.
> + =C2=A0 =C2=A0 =C2=A0 Print the path where the Info files documentin=
g this
> + =C2=A0 =C2=A0 =C2=A0 version of git are installed and exit.
>
> =C2=A0-p::
> =C2=A0--paginate::
> --
> 1.7.5
>
>
