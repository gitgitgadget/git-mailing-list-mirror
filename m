From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] git-gui: support for underline styles
Date: Sun, 27 Feb 2011 21:04:05 +0100
Message-ID: <AANLkTimnX-OJYzSvot-yUMGKXmqJw9deTGS-6mzywoEe@mail.gmail.com>
References: <1289815498-12287-1-git-send-email-bert.wesarg@googlemail.com>
	<87oc9lhbjx.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O . Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sun Feb 27 21:04:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptmqj-0005cA-M6
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 21:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755Ab1B0UEJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Feb 2011 15:04:09 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63412 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658Ab1B0UEH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Feb 2011 15:04:07 -0500
Received: by wyg36 with SMTP id 36so3063563wyg.19
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 12:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vBr5UcsDDLRm9qwVWftS7ya1yV5J4QfwnOSw10x4gyg=;
        b=xSkU3WptFODHOhIZYQh1ucgSSFsCFuAlMj+zeOgcx4aBpSELylMJXQqqfzYYLqNZKi
         LUdOUTGXfdPV2aSXFZPlGpRPo8gA8Dqji5dTHqzZE2QIkDi0uK0qgl5W8wOnqeLFkSHr
         qFJ7q51fpH1D4bZR7m5uLy8r/eZQXtSr84Reg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AnkV4NU+dtcgFF9piIYb8iPZE5cmWMpIjjHyPccr+QADU0wD7IBBw3tuA95p3hocnm
         +FJdl6uPgNgmRyw7JEHyJn7cyb9jyIh0Nu/DP4+vwNr3obXdWMXbHp6DV2t9ri0fXHMr
         ifzFz3uJD3sPlOKgIpdSgOol2yo1zWUJdXtcw=
Received: by 10.227.23.207 with SMTP id s15mr722832wbb.197.1298837045610; Sun,
 27 Feb 2011 12:04:05 -0800 (PST)
Received: by 10.227.132.137 with HTTP; Sun, 27 Feb 2011 12:04:05 -0800 (PST)
In-Reply-To: <87oc9lhbjx.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168052>

On Fri, Nov 19, 2010 at 11:00, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:
>
> Suggested-by: Bert Wesarg <bert.wesarg@googlemail.com>
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> ---
>
> I left underline out because I reckon it would just make text harder =
to
> read on a gui display. It seems like the option would only be useful =
on
> monochrome terminals.
>
> If we do want to support underlines in the diff view window then we c=
an
> have a different tag rather than replicating each color to get a
> underlined version of the same color.
> Something like the following should do it:

I miss this in git-gui.git.

Thanks,
Bert

>
>
> =C2=A0git-gui.sh =C2=A0 | =C2=A0 =C2=A01 +
> =C2=A0lib/diff.tcl | =C2=A0 =C2=A02 +-
> =C2=A02 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/git-gui.sh b/git-gui.sh
> index d3acf0d..137cd72 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -3330,6 +3330,7 @@ foreach {n c} {0 black 1 red4 2 green4 3 yellow=
4 4 blue4 5 magenta4 6 cyan4 7 gr
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ui_diff tag configure clri3$n -background=
 $c
> =C2=A0}
> =C2=A0$ui_diff tag configure clr1 -font font_diffbold
> +$ui_diff tag configure clr4 -underline 1
>
> =C2=A0$ui_diff tag conf d_cr -elide true
> =C2=A0$ui_diff tag conf d_@ -font font_diffbold
> diff --git a/lib/diff.tcl b/lib/diff.tcl
> index 0579fa6..203ab07 100644
> --- a/lib/diff.tcl
> +++ b/lib/diff.tcl
> @@ -473,7 +473,7 @@ proc read_diff {fd cont_info} {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0set prefix clr
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0foreach style [split $colbegin ";"] {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if {$style eq "7"} {append pr=
efix i; continue}
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if {$style < 30 || $style > 47} {co=
ntinue}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if {$style !=3D 4 && ($style < 30 |=
| $style > 47)} {continue}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set a "$mark linestart + $pos=
begin chars"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set b "$mark linestart + $pos=
end chars"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0catch {$ui_diff tag add $pref=
ix$style $a $b}
> --
> 1.7.3.1.msysgit.0
>
>
