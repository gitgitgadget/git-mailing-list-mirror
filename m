From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] tg-files: list files changed by the topic branch
Date: Mon, 4 Oct 2010 18:02:09 +0200
Message-ID: <AANLkTinv40O_gdMdEbTOV6LQKBNjksAGKMOtewwauMjP@mail.gmail.com>
References: <20101004065918.GL28679@pengutronix.de>
	<1286198194-12873-1-git-send-email-bert.wesarg@googlemail.com>
	<20101004135200.GD11737@pengutronix.de>
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
X-From: git-owner@vger.kernel.org Mon Oct 04 18:02:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2nUa-0006cc-P8
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 18:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756402Ab0JDQCM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 12:02:12 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44219 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756051Ab0JDQCL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 12:02:11 -0400
Received: by gye5 with SMTP id 5so1590029gye.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 09:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=v6bpqSREinvJZmR7QH+2mK4WMvIG/mEOi7UWE3b7lPU=;
        b=EHJH9D+zc37XgueSXNrzI3l0TPwzyQppCQShLmC/jnAoC/JUpWZOtEaU1fQyfJgzIk
         fLIRXsWyIM6ZjWHpbwnsxwB2H4U/LNGqy1Nz/dFUrl/mpxeA3uDwR7JfzcUQZ0xindVE
         SPn+3BfhWyV2d/dGUy9kVlSTzshJEeHaXtSFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZfW0FJuDyQ6FqrYGgfQTdJACGdslYXettkQKX4C3o87cvqA9pIf1JLa1skY/Y2xrPr
         mlhS9tOr6gyeENu933dbvN6saIJ/JK4VI+TsIpNbjYQYko91dePBJ0QbLACpzP++ifln
         508Rjn7l2ISwWJT7XEg/qrIgmVVXn5JzjLJkw=
Received: by 10.231.30.68 with SMTP id t4mr10384253ibc.129.1286208130024; Mon,
 04 Oct 2010 09:02:10 -0700 (PDT)
Received: by 10.231.171.149 with HTTP; Mon, 4 Oct 2010 09:02:09 -0700 (PDT)
In-Reply-To: <20101004135200.GD11737@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158061>

2010/10/4 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> On Mon, Oct 04, 2010 at 03:16:34PM +0200, Bert Wesarg wrote:
>> this could also be a --name-only option to tg-patch. But I Like the
>> similarity to 'quilt files'.
>>
>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>>
>> ---
>>
>> > For these we need pretty_tree -i and pretty_tree -w?!
>> Done and moved to tg.sh. tg-patch should now be updated.
>>
>> Regards,
>> Bert
>>
>> =C2=A0.gitignore =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A02 +
>> =C2=A0README =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | =C2=A0 =C2=A08 +++++++
>> =C2=A0contrib/tg-completion.bash | =C2=A0 =C2=A01 +
>> =C2=A0tg-export.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
| =C2=A0 =C2=A09 --------
>> =C2=A0tg-files.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 43 ++++++++++++++++++++++++++++++++++++++
>> =C2=A0tg.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| =C2=A0 49 +++++++++++++++++++++++++++++++++++++++=
+++++
>> =C2=A06 files changed, 103 insertions(+), 9 deletions(-)
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
>> diff --git a/tg-export.sh b/tg-export.sh
>> index 6d82d55..4b0148c 100644 tg-export.sh
>> --- a/tg-export.sh
>> +++ b/tg-export.sh
>> @@ -63,15 +63,6 @@ trap 'rm -rf "$playground"' EXIT
>>
>> =C2=A0## Collapse driver
>>
>> -# pretty_tree NAME
>> -# Output tree ID of a cleaned-up tree without tg's artifacts.
>> -pretty_tree()
>> -{
>> - =C2=A0 =C2=A0 git ls-tree --full-tree "$1" \
>> - =C2=A0 =C2=A0 | awk -F ' =C2=A0 =C2=A0 =C2=A0' '$2 !~ /^.top/' \
>> - =C2=A0 =C2=A0 | git mktree
>> -}
>> -
>> =C2=A0create_tg_commit()
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 name=3D"$1"
>> diff --git a/tg-files.sh b/tg-files.sh
>> new file mode 100644
>> index 0000000..4e9c5cd tg-files.sh
>> --- /dev/null
>> +++ b/tg-files.sh
>> @@ -0,0 +1,43 @@
>> +#!/bin/sh
>> +# TopGit - A different patch queue manager
>> +# (c) Petr Baudis <pasky@suse.cz> =C2=A02008
>> +# GPLv2
>> +
>> +name=3D
>> +topic=3D
>> +
>> +
>> +## Parse options
>> +
>> +while [ -n "$1" ]; do
>> + =C2=A0 =C2=A0 arg=3D"$1"; shift
>> + =C2=A0 =C2=A0 case "$arg" in
>> + =C2=A0 =C2=A0 -i)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [ -z "$topic" ] || die "=
-i and -w are mutually exclusive"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 topic=3D-i;;
>> + =C2=A0 =C2=A0 -w)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [ -z "$topic" ] || die "=
-i and -w are mutually exclusive"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 topic=3D-w;;
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
>> +[ -n "$name" -a -n "$topic" ] &&
>> + =C2=A0 =C2=A0 die "-i/-w are mutually exclusive with NAME"
>> +
>> +[ -n "$name" ] || name=3D"$(git symbolic-ref HEAD | sed 's#^refs/\(=
heads\|top-bases\)/##')"
>> +base_rev=3D"$(git rev-parse --short --verify "refs/top-bases/$name"=
 2>/dev/null)" ||
>> + =C2=A0 =C2=A0 die "not a TopGit-controlled branch"
>> +
>> +b_tree=3D$(prett_tree "$name" -b)
>> +t_tree=3D$(prett_tree "$name" $topic)
>> +
>> +git diff-tree --name-only -r $b_tree $t_tree
>> +
>> +# vim:noet
>> diff --git a/tg.sh b/tg.sh
>> index 9d08d63..ff39483 100644 tg.sh
>> --- a/tg.sh
>> +++ b/tg.sh
>> @@ -39,6 +39,55 @@ cat_file()
>> =C2=A0 =C2=A0 =C2=A0 esac
>> =C2=A0}
>>
>> +# get tree for topic
>> +get_tree_()
>> +{
>> + =C2=A0 =C2=A0 echo "$1"
>> +}
>> +
>> +# get tree for base
>> +get_tree_b()
>> +{
>> + =C2=A0 =C2=A0 echo "refs/top-bases/$1"
>> +}
>> +
>> +# get tree for index
>> +get_tree_i()
>> +{
>> + =C2=A0 =C2=A0 git write-tree
>> +}
>> +
>> +# get tree for worktree
>> +get_tree_w()
>> +{
>> + =C2=A0 =C2=A0 i_tree=3D$(git write-tree)
>> + =C2=A0 =C2=A0 (
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TMP_INDEX=3D"$(mktemp -t=
 tg-files-index.XXXXXX)"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f "$TMP_INDEX" &&
> why remove the temp file here?

This code block was from git-stash. Will remove that.

>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : ${GIT_DIR:=3D"$root_di=
r/.git"} &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cp -p ${GIT_INDEX_FILE-"=
$GIT_DIR/index"} "$TMP_INDEX" &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GIT_INDEX_FILE=3D"$TMP_I=
NDEX" &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 export GIT_INDEX_FILE &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git read-tree -m $i_tree=
 &&
> Couldn't the same be done by just doing:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git read-tree -m $i_tree --index-output=3D=
"$TMP_INDEX"

I don't know. Maybe. But the subsequent git commands need to operate
on $TMP_INDEX, so the only thing we safe is the cp.

>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git diff --name-only -z =
HEAD |
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 git update-index -z --add --remove --stdin &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git write-tree &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -f "$TMP_INDEX"
>> + =C2=A0 =C2=A0 )
>> +}
>> +
>> +# pretty_tree NAME [-b | -i | -w]
>> +# Output tree ID of a cleaned-up tree without tg's artifacts.
>> +# NAME will be ignored for -i and -w, but needs to be present
>> +prett_tree()
> Can we please have the y back? :-)

Sure.

Bert
