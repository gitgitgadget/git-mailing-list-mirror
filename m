From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH 3/6] tg-files: list files changed by the topic branch
Date: Mon, 4 Oct 2010 08:43:52 +0200
Message-ID: <AANLkTimLgWKPBjVAni=t6EK4Yr9FyJZa=Yk01SeMcwA1@mail.gmail.com>
References: <AANLkTim3gnU+_krD2QM0BAMf9DZi2_4hva6dq4WXcatH@mail.gmail.com>
	<1286141157-30422-1-git-send-email-bert.wesarg@googlemail.com>
	<1286141157-30422-2-git-send-email-bert.wesarg@googlemail.com>
	<1286141157-30422-3-git-send-email-bert.wesarg@googlemail.com>
	<20101003220330.GE28679@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Peter Simons <simons@cryp.to>, pasky@suse.cz,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Mon Oct 04 08:43:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2emE-00042f-DH
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 08:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565Ab0JDGny convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 02:43:54 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48028 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304Ab0JDGnx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 02:43:53 -0400
Received: by mail-iw0-f174.google.com with SMTP id 5so6527658iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 23:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OBvmhPCKU65W8V5ChggGxjMKfLCRCNy7NL66EjAl8DY=;
        b=x6WuuwdI1Izx2/2tI5BHG6G/5hO7egynD6uH16A8Dy3hbASMtFmH+leros84Jbpdsc
         zxu/DtCy2pUYI/BdtWMQUBl9owsvwnc0FCHLkBbsRNNHFeCHK4Ez9llQeNNS3FwaXAcg
         aDXviuC1HGkWIZOdOpgo+7iSbmMSz3BMGgX9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OJ94xiPVY4s7j4QEqJ3YShiKxGTYs20j8hb6yKc9vxAD52dAAPVUo6bfWlerHFDzzd
         NtS3XbNjVj9UAgRTYQRPrjVicaPZgGhaFqxentpPy8hOlxURt1/WnWm5LAHUIwnp7WMX
         MRDJAen1NcstIRM6UHZyotfW0GF3mACCRy1xc=
Received: by 10.231.35.8 with SMTP id n8mr9667721ibd.78.1286174632947; Sun, 03
 Oct 2010 23:43:52 -0700 (PDT)
Received: by 10.231.171.149 with HTTP; Sun, 3 Oct 2010 23:43:52 -0700 (PDT)
In-Reply-To: <20101003220330.GE28679@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157985>

Hi,

2010/10/4 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> Hi Bert,
>
> On Sun, Oct 03, 2010 at 11:25:54PM +0200, Bert Wesarg wrote:
>> this could also be a --name-only option to tg-patch. But I Like the
>> similarity to 'quilt files'.
>>
>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>>
>> ---
>> =C2=A0.gitignore =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A02 +
>> =C2=A0README =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | =C2=A0 =C2=A08 ++++++
>> =C2=A0contrib/tg-completion.bash | =C2=A0 =C2=A01 +
>> =C2=A0tg-files.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 52 ++++++++++++++++++++++++++++++++++++++++++++
>> =C2=A04 files changed, 63 insertions(+), 0 deletions(-)
>>
>> diff --git a/.gitignore b/.gitignore
>> index 0342e09..0dc4d0e 100644 .gitignore
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -22,6 +22,8 @@
>> =C2=A0/tg-depend.txt
>> =C2=A0/tg-export
>> =C2=A0/tg-export.txt
>> +/tg-files
>> +/tg-files.txt
>> =C2=A0/tg-import
>> =C2=A0/tg-import.txt
>> =C2=A0/tg-info
>> diff --git a/README b/README
>> index f103d92..46f564a 100644 README
>> --- a/README
>> +++ b/README
>> @@ -272,6 +272,14 @@ tg depend
>>
>> =C2=A0 =C2=A0 =C2=A0 TODO: Subcommand for removing dependencies, obv=
iously
>>
>> +tg files
>> +~~~~~~~~
>> + =C2=A0 =C2=A0 List files changed by the current or specified topic=
 branch.
>> +
>> + =C2=A0 =C2=A0 Options:
>> + =C2=A0 =C2=A0 =C2=A0 -i =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0l=
ist files based on index instead of branch
>> + =C2=A0 =C2=A0 =C2=A0 -w =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0l=
ist files based on working tree instead of branch
>> +
>> =C2=A0tg info
>> =C2=A0~~~~~~~
>> =C2=A0 =C2=A0 =C2=A0 Show a summary information about the current or=
 specified
>> diff --git a/contrib/tg-completion.bash b/contrib/tg-completion.bash
>> index 0ee233c..38567d0 100755 contrib/tg-completion.bash
>> --- a/contrib/tg-completion.bash
>> +++ b/contrib/tg-completion.bash
>> @@ -467,6 +467,7 @@ _tg ()
>> =C2=A0 =C2=A0 =C2=A0 delete) =C2=A0 =C2=A0 =C2=A0_tg_delete ;;
>> =C2=A0 =C2=A0 =C2=A0 depend) =C2=A0 =C2=A0 =C2=A0_tg_depend ;;
>> =C2=A0 =C2=A0 =C2=A0 export) =C2=A0 =C2=A0 =C2=A0_tg_export ;;
>> + =C2=A0 =C2=A0 files) =C2=A0 =C2=A0 =C2=A0 _tg_patch ;;
>> =C2=A0 =C2=A0 =C2=A0 help) =C2=A0 =C2=A0 =C2=A0 =C2=A0_tg_help ;;
>> =C2=A0 =C2=A0 =C2=A0 import) =C2=A0 =C2=A0 =C2=A0_tg_import ;;
>> =C2=A0 =C2=A0 =C2=A0 info) =C2=A0 =C2=A0 =C2=A0 =C2=A0_tg_info ;;
>> diff --git a/tg-files.sh b/tg-files.sh
>> new file mode 100644
>> index 0000000..0723bf1 tg-files.sh
>> --- /dev/null
>> +++ b/tg-files.sh
>> @@ -0,0 +1,52 @@
>> +#!/bin/sh
>> +# TopGit - A different patch queue manager
>> +# (c) Petr Baudis <pasky@suse.cz> =C2=A02008
>> +# GPLv2
>> +
>> +name=3D
>> +
>> +topic=3D
>> +diff_opts=3D
>> +diff_committed_only=3Dyes =C2=A0 =C2=A0 =C2=A0# will be unset for i=
ndex/worktree
>> +
>> +
>> +## Parse options
>> +
>> +while [ -n "$1" ]; do
>> + =C2=A0 =C2=A0 arg=3D"$1"; shift
>> + =C2=A0 =C2=A0 case "$arg" in
>> + =C2=A0 =C2=A0 -i)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 topic=3D'(i)'
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diff_opts=3D"$diff_opts =
--cached";
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diff_committed_only=3D;;
>> + =C2=A0 =C2=A0 -w)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 topic=3D'(w)'
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diff_committed_only=3D;;
>> + =C2=A0 =C2=A0 -*)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "Usage: tg [...] fi=
les [-i | -w] [NAME]" >&2
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit 1;;
>> + =C2=A0 =C2=A0 *)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [ -z "$name" ] || die "n=
ame already specified ($name)"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D"$arg";;
>> + =C2=A0 =C2=A0 esac
>> +done
>> +
>> +
>> +[ -n "$name" =C2=A0-a =C2=A0-z "$diff_committed_only" ] =C2=A0&&
>> + =C2=A0 =C2=A0 die "-i/-w are mutually exclusive with NAME"
>> +
>> +[ -n "$name" ] || name=3D"$(git symbolic-ref HEAD | sed 's#^refs/\(=
heads\|top-bases\)/##')"
>> +base_rev=3D"$(git rev-parse --short --verify "refs/top-bases/$name"=
 2>/dev/null)" ||
>> + =C2=A0 =C2=A0 die "not a TopGit-controlled branch"
>> +
>> +# if not index/worktree, topic is current branch
>> +[ -z "$topic" ] && topic=3D"$name"
>> +
>> +
>> +
>> +# Evil obnoxious hack to work around the lack of git diff --exclude
>> +git diff --name-only $diff_opts "$base_rev" ${diff_committed_only:+=
"$name"} -- |
>> + =C2=A0 =C2=A0 fgrep -vx ".topdeps" |
>> + =C2=A0 =C2=A0 fgrep -vx ".topmsg" || : # fgrep likes to fail rando=
mly?
> Instead of using fgrep you could export the branch and call git diff
> --name-only $diff_opts on the resulting commit?

If you mean using tg-export, than I think this is a bad idea. The
operation will than be O(n), with n the total number of depending
branches.

I think a pretty_tree on the base and the branch with git diff-tree
should suffice:

git diff-tree --name-only $(pretty_tree refs/top-bases/$name)
$(pretty_tree $name)

Bert

>
> Best regards
> Uwe
>
> --
> Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Uwe Kleine-K=C3=B6nig =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
> Industrial Linux Solutions =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | http://www.pengutronix.de/ =C2=A0|
>
