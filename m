Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81D331F462
	for <e@80x24.org>; Fri, 26 Jul 2019 14:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388786AbfGZOBS (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 10:01:18 -0400
Received: from mout.gmx.net ([212.227.15.15]:59755 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387737AbfGZOBR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 10:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564149665;
        bh=37JldIZBN914To00Bseqmdga0izgLY4IIrsRrPhCCck=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=IydEUfzMxCM4G9vr5gSVXdZKox7EPsCRCvLZCduMgX1/YeiqAZ63c6idnKCIpnCYH
         xt8HxzLOD0Kd1Fnj6lKrZzp5P04yoTWIMLezI8s16B6GAatZhG16fhKAsIFy9QopiM
         zkyi2HIl50vatuVEtP58zRPKrArjqFVVr1iZk8bA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lw2Sj-1iTUk826Sj-017irA; Fri, 26
 Jul 2019 16:01:05 +0200
Date:   Fri, 26 Jul 2019 16:01:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/12] t/lib-rebase: prepare for testing `git rebase
 --rebase-merges`
In-Reply-To: <20190726074317.GD9319@genre.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.1907261555410.21907@tvgsbejvaqbjf.bet>
References: <pull.294.git.gitgitgadget@gmail.com> <ae9e72b73bf2da0de3a5369748ebd358656588d9.1564049474.git.gitgitgadget@gmail.com> <20190726074317.GD9319@genre.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1113360017-1564149511=:21907"
Content-ID: <nycvar.QRO.7.76.6.1907261558560.21907@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:C/MrD6yEjs1bL6bRgF4HHHMO1ZLQADFbN0s6VAOv+MJFnRM9Lno
 ya41f6F99693+/xNkZFDnEu36hLDffkd2pSN7QD1omWEH0McLlWhNE1edW8ViMjrhNrI9J7
 HjG+GeLvQFMrjeeB10J7eE13AheOAZlbRDyX/cvS/shiHh2zl+Yv/J/FY670J3oBB0iR4kx
 a9mUvfwtxpeAVkR5ziskg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BgMwOg7mg38=:3CKhYEHEh2ztpoEH6Qns05
 cJFD2PDtLwM6mv3X4wchYfKLuam9hlf28CO/2YDM+mbH6NfSlfOGSkcuSDEcTdP9lDt5dSQbA
 D/xMIllzgtSxq0sstBSRLc+clHf6IeNORvK14IH0ilSGlmkEvL2ItNJY3MUgu+lH6IBWsXL9z
 Xqd7h42wsiES/DwfO8IxjcJ93Ph3xMKmwZtCfK6o39EM9kfT4IYimlOvNf+BsyxSfcI1eevU8
 AupYmAsi/Gr3FJ6THIlKLn0WkLOs9VQ5c3e5jgLVOFWrPdrGQv2PUEJ9mQh3m+Jsycqt0LCil
 uKbEUyyBX+7p9wwf30QelFOJkMxoMtv1lUWF4W55D6fxVXV5QPEY7QitAWgclVNRKydhFjqWU
 vbxxLYypVIZuuuq1QayC0y+irCfkZLVr7Tb/jTocOV04kOhQuA3O9uMBQPX3BGhInD+nYRqlb
 kZeNWbU2DxDyCLZGv51ejyRwfynHL5hAfAWVI7M90pQL02xA4BPcJt2N/4Vgsn+Wk9YKJTSHt
 UfJQ5EJOBsLhkrtL9dP+1oJ0+7z93r0vumdAor33Woij2xAJSiVUlFvfdu0f2swAFzIWS6NPU
 zNEdwM2NQof3pJELzESKQplUHN89ANGgiPQQ+gxGiJaLWZgiOGiZN2Sc0XgScICt3lkKwVcWj
 A/3rxsv4v6sc0iyayYKttVBYgd/+Rhdw22APIKz82rRZhXhAmULOQTdE2FwDhwLzavaG39pjD
 uqvcytZnlfOWLF081Fv8cxYfV1y36iyN/gEnI9LBo+kiJEnyYnFAhe1j7WscO3ATHa6fDQQCk
 zR4R4y4ML75YClVmP21HoVfaFpY2kzHZ479MSE6lgbIhOR0wV/TP8jhqQNvwy8PnrhQkY5fPY
 LKbWxXgkigmTJNEo/L8cNWdseMv3uejdikE9Ommn1gHGbw045jrCrA2soqAnn5ErEmpa3U4D6
 kco57Iu/6+GFkAqNYgyTdT1kCQvSDFrDTNgjBF1HzprrXrbgMsR+DBrH8EzcbCv6YyYrE0seh
 Gv6qmPn0BvzXraJFMwwewD2y4YuuvBR7aC/wF4QVDJ6pGdnVmF8zdrIiTJCzPk12Ri2hLGQmo
 P3mOBacNaIP2vvka7ZGms1SK0m+g17xWHQH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1113360017-1564149511=:21907
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.1907261558561.21907@tvgsbejvaqbjf.bet>

Hi brian,

On Fri, 26 Jul 2019, brian m. carlson wrote:

> On 2019-07-25 at 10:11:22, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The format of the todo list is quite a bit different in the
> > `--rebase-merges` mode; Let's prepare the fake editor to handle those
> > todo lists properly, too.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/lib-rebase.sh | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
> > index 7ea30e5006..662a958575 100644
> > --- a/t/lib-rebase.sh
> > +++ b/t/lib-rebase.sh
> > @@ -44,10 +44,10 @@ set_fake_editor () {
> >  	rm -f "$1"
> >  	echo 'rebase -i script before editing:'
> >  	cat "$1".tmp
> > -	action=3Dpick
> > +	action=3D\&
>
> So we set action to "&" so we can use it as the result in the sed
> expression below=E2=80=A6
>
> >  	for line in $FAKE_LINES; do
> >  		case $line in
> > -		pick|p|squash|s|fixup|f|edit|e|reword|r|drop|d)
> > +		pick|p|squash|s|fixup|f|edit|e|reword|r|drop|d|label|l|reset|r|merg=
e|m)
> >  			action=3D"$line";;
> >  		exec_*|x_*|break|b)
> >  			echo "$line" | sed 's/_/ /g' >> "$1";;
> > @@ -61,8 +61,8 @@ set_fake_editor () {
> >  			echo "$action XXXXXXX False commit" >> "$1"
>
> but then here it doesn't look like "&" is a thing we'd want to use. Is
> there something I'm missing about this particular case?

Actually, the part that uses it is not shown in the patch (one of the
many, many reasons why I try to discourage patch review and encourage
code review instead). The relevant section currently looks somewhat like
this:

=2D- snip --
set_fake_editor () {
	write_script fake-editor.sh <<-\EOF
	case "$1" in
	*/COMMIT_EDITMSG)
		test -z "$EXPECT_HEADER_COUNT" ||
			test "$EXPECT_HEADER_COUNT" =3D "$(sed -n '1s/^# This is a combination =
of \(.*\) commits\./\1/p' < "$1")" ||
			test "# # GETTEXT POISON #" =3D "$(sed -n '1p' < "$1")" ||
			exit
		test -z "$FAKE_COMMIT_MESSAGE" || echo "$FAKE_COMMIT_MESSAGE" > "$1"
		test -z "$FAKE_COMMIT_AMEND" || echo "$FAKE_COMMIT_AMEND" >> "$1"
		exit
		;;
	esac
	test -z "$EXPECT_COUNT" ||
		test "$EXPECT_COUNT" =3D $(sed -e '/^#/d' -e '/^$/d' < "$1" | wc -l) ||
		exit
	test -z "$FAKE_LINES" && exit
	grep -v '^#' < "$1" > "$1".tmp
	rm -f "$1"
	echo 'rebase -i script before editing:'
	cat "$1".tmp
	action=3Dpick
	for line in $FAKE_LINES; do
		case $line in
		pick|p|squash|s|fixup|f|edit|e|reword|r|drop|d)
			action=3D"$line";;
		exec_*|x_*|break|b)
			echo "$line" | sed 's/_/ /g' >> "$1";;
		"#")
			echo '# comment' >> "$1";;
		">")
			echo >> "$1";;
		bad)
			action=3D"badcmd";;
		fakesha)
			echo "$action XXXXXXX False commit" >> "$1"
			action=3Dpick;;
		*)
			sed -n "${line}s/^pick/$action/p" < "$1".tmp >> "$1"
			action=3Dpick;;
		esac
	done
	echo 'rebase -i script after editing:'
	cat "$1"
	EOF

	test_set_editor "$(pwd)/fake-editor.sh"
}
=2D- snap --

Most importantly, `action` is used here:

                        sed -n "${line}s/^pick/$action/p" < "$1".tmp >> "$=
1"

and I changed it to

			sed -n "${line}s/^[a-z][a-z]*/$action/p" < "$1".tmp >> "$1"

In other words, rather than expecting the lines that are used by the
fake editor to start with `pick`, after this patch, the tests expect the
todo lists to start with a command consisting of lower-case ASCII
letters (which catches `pick`, of course, but also `label`, `reset` and
`merge`).

After this patch, the fake editor also does not try to replace whatever
command it finds by `pick`, but it keeps it as-is instead.

Ciao,
Dscho

--8323328-1113360017-1564149511=:21907--
