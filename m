From: =?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
Subject: Re: [PATCH] Documentation: add a new man page for "git-help" and
 -i|--info option.
Date: Wed, 05 Dec 2007 10:19:20 +0200
Message-ID: <178B37CE-9B28-4CE2-B8A0-FCA28CF85E12@pp.inet.fi>
References: <20071204064429.1b5007b2.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_0oVSiaYLE8eOqZoKk7FKtg)"
Cc: Junio Hamano <junkio@cox.net>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Dec 05 09:20:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzpUD-00035z-4X
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 09:20:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbXLEITk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 03:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbXLEITk
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 03:19:40 -0500
Received: from astana.suomi.net ([82.128.152.18]:47149 "EHLO astana.suomi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896AbXLEITj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 03:19:39 -0500
Received: from taku.suomi.net ([82.128.154.66])
 by astana.suomi.net (Sun Java System Messaging Server 6.2-3.04 (built Jul 15
 2005)) with ESMTP id <0JSK003VJHOJRI40@astana.suomi.net> for
 git@vger.kernel.org; Wed, 05 Dec 2007 10:17:07 +0200 (EET)
Received: from spam2.suomi.net (spam2.suomi.net [212.50.131.166])
 by mailstore.suomi.net
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSK008RJHSP5UE0@mailstore.suomi.net> for git@vger.kernel.org;
 Wed, 05 Dec 2007 10:19:38 +0200 (EET)
Received: from Kaalimaa.fudeco.com
 (addr-213-139-166-27.baananet.fi [213.139.166.27])
	by spam2.suomi.net (Postfix) with ESMTP id 3A5FB1A715C; Wed,
 05 Dec 2007 10:19:20 +0200 (EET)
In-reply-to: <20071204064429.1b5007b2.chriscool@tuxfamily.org>
X-Mailer: Apple Mail (2.915)
X-OPOY-MailScanner-Information: Please contact the OPOY for more information
X-OPOY-MailScanner: Found to be clean
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,	score=-0.778,
 required 5, autolearn=not spam, AWL 0.09,	BAYES_00 -1.00,
 FORGED_RCVD_HELO 0.14)
X-OPOY-MailScanner-From: v@pp.inet.fi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67122>


--Boundary_(ID_0oVSiaYLE8eOqZoKk7FKtg)
Content-type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Content-transfer-encoding: quoted-printable

Patch attached to fix header error in this patch.

(Attached because Mail.app mangles inline patches)

--
V=E4in=F6

On Dec 4, 2007, at 07:44, Christian Couder wrote:

> Option -i|--info for "git-help" is documented only in the new
> "git-help.txt" man page, but this new man page is referenced
> from the "--help" option documentation in the "git.txt" man page.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> Documentation/git-help.txt |   53 +++++++++++++++++++++++++++++++++++=20=

> +++++++++
> Documentation/git.txt      |   11 ++++++--
> 2 files changed, 61 insertions(+), 3 deletions(-)
> create mode 100644 Documentation/git-help.txt
>
> 	This is a first documentation patch in my git-help
> 	improvement series.
>
> diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
> new file mode 100644
> index 0000000..232daae
> --- /dev/null
> +++ b/Documentation/git-help.txt
> @@ -0,0 +1,53 @@
> +git-help(1)
> +=3D=3D=3D=3D=3D=3D
> +
> +NAME
> +----
> +git-help - display help information about git
> +
> +SYNOPSIS
> +--------
> +'git help' [-a|--all|-i|--info] [COMMAND]
> +
> +DESCRIPTION
> +-----------
> +
> +With no options and no COMMAND given, the synopsis of the 'git'
> +command and a list of the most commonly used git commands are printed
> +on the standard output.
> +
> +If the option '--all' or '-a' is given, then all available commands =20=

> are
> +printed on the standard output.
> +
> +If a git command is named, a manual page for that command is brought
> +up. The 'man' program is used by default for this purpose, but this
> +can be overriden by other options.
> +
> +Note that 'git --help ...' is identical as 'git help ...' because the
> +former is internally converted into the latter.
> +
> +OPTIONS
> +-------
> +-a|--all::
> +
> +	Prints all the available commands on the standard output. This
> +	option superseeds any other option.
> +
> +-i|--info::
> +	Use the 'info' program to display the manual page, instead of
> +	the 'man' program that is used by default.
> +
> +Author
> +------
> +Written by Junio C Hamano <gitster@pobox.com> and the git-list
> +<git@vger.kernel.org>.
> +
> +Documentation
> +-------------
> +Initial documentation was part of the gitlink:git[7] man page.
> +Christian Couder <chriscool@tuxfamily.org> extracted and rewrote it a
> +little. Maintenance is done by the git-list <git@vger.kernel.org>.
> +
> +GIT
> +---
> +Part of the gitlink:git[7] suite
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 5460201..f8d1eef 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -100,9 +100,14 @@ OPTIONS
>
> --help::
> 	Prints the synopsis and a list of the most commonly used
> -	commands.  If a git command is named this option will bring up
> -	the man-page for that command. If the option '--all' or '-a' is
> -	given then all available commands are printed.
> +	commands. If the option '--all' or '-a' is given then all
> +	available commands are printed. If a git command is named this
> +	option will bring up the manual page for that command.
> +
> +	Other options are available to control how the manual page is
> +	displayed. See gitlink:git-help[1] for more information,
> +	because 'git --help ...' is converted internally into 'git
> +	help ...'.
>
> --exec-path::
> 	Path to wherever your core git programs are installed.
> --=20
> 1.5.3.6.1993.g154f-dirty
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--Boundary_(ID_0oVSiaYLE8eOqZoKk7FKtg)
Content-type: application/octet-stream; x-unix-mode=0644;
 name=0001-Fixed-git-help.txt-header-error.patch
Content-transfer-encoding: quoted-printable
Content-disposition: attachment;
 filename=0001-Fixed-git-help.txt-header-error.patch

=46rom=206d9fa82be1074a9fe6bf3fad36a838c1142966ca=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20=
=3D?utf-8?q?V=3DC3=3DA4in=3DC3=3DB6=3D20J=3DC3=3DA4rvel=3DC3=3DA4?=3D=20=
<v@pp.inet.fi>=0ADate:=20Wed,=205=20Dec=202007=2010:05:48=20+0200=0A=
Subject:=20[PATCH]=20Fixed=20git-help.txt=20header=20error=0A=
MIME-Version:=201.0=0AContent-Type:=20text/plain;=20charset=3Dutf-8=0A=
Content-Transfer-Encoding:=208bit=0A=0ASigned-off-by:=20V=C3=A4in=C3=B6=20=
J=C3=A4rvel=C3=A4=20<v@pp.inet.fi>=0A---=0A=20Documentation/git-help.txt=20=
|=20=20=20=202=20+-=0A=201=20files=20changed,=201=20insertions(+),=201=20=
deletions(-)=0A=0Adiff=20--git=20a/Documentation/git-help.txt=20=
b/Documentation/git-help.txt=0Aindex=20232daae..c94e27b=20100644=0A---=20=
a/Documentation/git-help.txt=0A+++=20b/Documentation/git-help.txt=0A@@=20=
-1,5=20+1,5=20@@=0A=20git-help(1)=0A-=3D=3D=3D=3D=3D=3D=0A+=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=0A=20=0A=20NAME=0A=20----=0A--=20=0A=
1.5.3.7.2115.geb80=0A=0A=

--Boundary_(ID_0oVSiaYLE8eOqZoKk7FKtg)
Content-type: text/plain; charset=US-ASCII; format=flowed
Content-transfer-encoding: 7BIT



--Boundary_(ID_0oVSiaYLE8eOqZoKk7FKtg)--
