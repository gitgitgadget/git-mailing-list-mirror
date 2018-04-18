Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCEF31F404
	for <e@80x24.org>; Wed, 18 Apr 2018 12:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753071AbeDRMb2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 08:31:28 -0400
Received: from mout.gmx.net ([212.227.17.22]:41107 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752617AbeDRMb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 08:31:27 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MVrQS-1exmq0261o-00X4lU; Wed, 18
 Apr 2018 14:31:20 +0200
Date:   Wed, 18 Apr 2018 14:31:04 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Clemens Buchacher <drizzd@gmx.net>,
        Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH 01/11] t9902-completion: add tests demonstrating issues
 with quoted pathnames
In-Reply-To: <20180416224113.16993-2-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804181421590.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180318012618.32691-1-szeder.dev@gmail.com> <20180416224113.16993-1-szeder.dev@gmail.com> <20180416224113.16993-2-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-988917701-1524054680=:4241"
X-Provags-ID: V03:K1:icgK9lYa13QeyEmv+ypwQHLQOxMYKYBpa5AVbqufWKsbU3/E2qM
 a5T5vtv8FwYgFgMnOdlfN74iS1VRcs9NanrslUm6ki3PorUCQcbdqaFmsRk6h/LQbB9lKxG
 yHtLh9zJRwD5vPIolvNFr9p7WU6V64RkCYTzJ11GbF54EEyNGfXmZPsHUWrAtQKCw7e7yY4
 8vq1WM6IT8G3L5ogXkq8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:h6M/xKi9FwQ=:Qs+2SDui7Y/d77whNh1y/Z
 Xxf1tChEdUX0unGR2CTIlCfKbjRPiszVGRMenotqzJ61b76gh7acF6vEVQSYJROYZklYi8exz
 J/+Io9E+Jm6DYAVW/c+98cGX548HqkquEKWZ9rZDBM2ma982Ci0MuLMX/ab5gG3bUIsMjVdLs
 CV/cQ4BD3J5yA+z8rpISBqf+X9U6TyhOuABgSPUXLKh9lhfjUylo/Dg1L+Nl7f3DGFvW27Mnr
 IteC+l39U0F6OMHD1WfNMXHCjIwIcmup3vLkmMsdN5eQ4XjYgb+Ug8dsSymTHzM+hu3oDzabr
 LxIcThD54RUtmSWu7xsJ+p+zyy99ClO+tHOTMDEiI226c6gb+GCu0RBDhv+jYAEMqzuQ1wJLT
 2YpMZ/9gORNuymrhRXgQYZF2CPp2tuhkaBSK7B9rnSFiBz7FMc3XP42J1VmjI1OvDjxJmvEX/
 8xghYWlp6lHs2PQkF4HrfzaYZoCIKR5g+rO7APmN/1Flw0QB+JV+M0Y5Er1g+EKCtiD5E64Kl
 F7SKyE66ZBAmScakUI3vkE43LpGR5kKQ/QjutU5HATPpYvSR4R58fI4IQTAXv6HeM/uZEF+Em
 aLKf0pQTqx/gAHOmGB1tSY+w/cTlUEW2UHP34iu6yHTPTRHCg0M579s8/v3RIKQ4Cp65qmtEQ
 qUtD5Q2qPyeWk2Hyp3gLnAqS/HzB+TBfwxfS527jV7v90/K20jJK/N2GuoUoON9uPL/Qf7w90
 KKqlRCl5JQwf+/gJT0vFx6UH2e183dqIvK3ejomhlpr9b4NnwDB2r4DqoNMxjT59rTUSczosS
 7wxhOTnaUnSDygyXj6XIP5cm46+P4aKr6rN/uj9BkabMMPKu54=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-988917701-1524054680=:4241
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi G=C3=A1bor,

On Tue, 17 Apr 2018, SZEDER G=C3=A1bor wrote:

> Completion functions see all words on the command line verbatim,
> including any backslash-escapes, single and double quotes that might
> be there.  Furthermore, git commands quote pathnames if they contain
> certain special characters.  All these create various issues when
> doing git-aware path completion.
>=20
> Add a couple of failing tests to demonstrate these issues.
>=20
> Later patches in this series will discuss these issues in detail as
> they fix them.
>=20
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>=20
> Notes:
>     Do any more new tests need FUNNYNAMES* prereq?

Yes.

>  t/t9902-completion.sh | 91 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>=20
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index b7f5b1e632..ff2e4a8f5f 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -1427,6 +1427,97 @@ test_expect_success 'complete files' '
>  =09test_completion "git add mom" "momified"
>  '
> =20
> +# The next tests only care about how the completion script deals with
> +# unusual characters in path names.  By defining a custom completion
> +# function to list untracked files they won't be influenced by future
> +# changes of the completion functions of real git commands, and we
> +# don't have to bother with adding files to the index in these tests.
> +_git_test_path_comp ()
> +{
> +=09__git_complete_index_file --others
> +}
> +
> +test_expect_failure 'complete files - escaped characters on cmdline' '
> +=09test_when_finished "rm -rf \"New|Dir\"" &&
> +=09mkdir "New|Dir" &&
> +=09>"New|Dir/New&File.c" &&
> +
> +=09test_completion "git test-path-comp N" \
> +=09=09=09"New|Dir" &&=09# Bash will turn this into "New\|Dir/"
> +=09test_completion "git test-path-comp New\\|D" \
> +=09=09=09"New|Dir" &&
> +=09test_completion "git test-path-comp New\\|Dir/N" \
> +=09=09=09"New|Dir/New&File.c" &&=09# Bash will turn this into
> +=09=09=09=09=09=09# "New\|Dir/New\&File.c "
> +=09test_completion "git test-path-comp New\\|Dir/New\\&F" \
> +=09=09=09"New|Dir/New&File.c"
> +'

This fails with:

2018-04-18T11:12:55.0436371Z expecting success:=20
2018-04-18T11:12:55.0436665Z =09test_when_finished "rm -rf \"New|Dir\"" &&
2018-04-18T11:12:55.0436799Z =09mkdir "New|Dir" &&
2018-04-18T11:12:55.0436904Z =09>"New|Dir/New&File.c" &&
2018-04-18T11:12:55.0436972Z=20
2018-04-18T11:12:55.0437158Z =09test_completion "git test-path-comp N" \
2018-04-18T11:12:55.0437296Z =09=09=09"New|Dir" &&=09# Bash will turn this =
into "New\|Dir/"
2018-04-18T11:12:55.0437413Z =09test_completion "git test-path-comp New\\|D=
" \
2018-04-18T11:12:55.0437522Z =09=09=09"New|Dir" &&
2018-04-18T11:12:55.0437629Z =09test_completion "git test-path-comp New\\|D=
ir/N" \
2018-04-18T11:12:55.0437767Z =09=09=09"New|Dir/New&File.c" &&=09# Bash will=
 turn this into
2018-04-18T11:12:55.0438040Z =09=09=09=09=09=09# "New\|Dir/New\&File.c "
2018-04-18T11:12:55.0438152Z =09test_completion "git test-path-comp New\\|D=
ir/New\\&F" \
2018-04-18T11:12:55.0438504Z =09=09=09"New|Dir/New&File.c"
2018-04-18T11:12:55.0438742Z=20
2018-04-18T11:12:55.0590984Z ++ test_when_finished 'rm -rf "New|Dir"'
2018-04-18T11:12:55.0591722Z ++ test 0 =3D 0
2018-04-18T11:12:55.0592001Z ++ test_cleanup=3D'{ rm -rf "New|Dir"
2018-04-18T11:12:55.0592290Z =09=09} && (exit "$eval_ret"); eval_ret=3D$?; =
:'
2018-04-18T11:12:55.0592472Z ++ mkdir 'New|Dir'
2018-04-18T11:12:55.0717255Z ++ test_completion 'git test-path-comp N' 'New=
|Dir'
2018-04-18T11:12:55.0717680Z ++ test 2 -gt 1
2018-04-18T11:12:55.0718062Z ++ printf '%s\n' 'New|Dir'
2018-04-18T11:12:55.0718275Z ++ run_completion 'git test-path-comp N'
2018-04-18T11:12:55.0718447Z ++ local -a COMPREPLY _words
2018-04-18T11:12:55.0718631Z ++ local _cword
2018-04-18T11:12:55.0718806Z ++ _words=3D($1)
2018-04-18T11:12:55.0718965Z ++ test N =3D ' '
2018-04-18T11:12:55.0719124Z ++ ((  _cword =3D 3 - 1  ))
2018-04-18T11:12:55.0719286Z ++ __git_wrap__git_main
2018-04-18T11:12:55.0719467Z ++ __git_func_wrap __git_main
2018-04-18T11:12:55.0719633Z ++ local cur words cword prev
2018-04-18T11:12:55.0719801Z ++ _get_comp_words_by_ref -n =3D: cur words cw=
ord prev
2018-04-18T11:12:55.0720074Z ++ '[' 6 -gt 0 ']'
2018-04-18T11:12:55.0720239Z ++ case "$1" in
2018-04-18T11:12:55.0720406Z ++ shift
2018-04-18T11:12:55.0720584Z ++ '[' 5 -gt 0 ']'
2018-04-18T11:12:55.0720742Z ++ case "$1" in
2018-04-18T11:12:55.0720899Z ++ shift
2018-04-18T11:12:55.0721054Z ++ '[' 4 -gt 0 ']'
2018-04-18T11:12:55.0721240Z ++ case "$1" in
2018-04-18T11:12:55.0721392Z ++ cur=3DN
2018-04-18T11:12:55.0721547Z ++ shift
2018-04-18T11:12:55.0721717Z ++ '[' 3 -gt 0 ']'
2018-04-18T11:12:55.0721879Z ++ case "$1" in
2018-04-18T11:12:55.0722040Z ++ words=3D("${_words[@]}")
2018-04-18T11:12:55.0722201Z ++ shift
2018-04-18T11:12:55.0722396Z ++ '[' 2 -gt 0 ']'
2018-04-18T11:12:55.0722931Z ++ case "$1" in
2018-04-18T11:12:55.0723070Z ++ cword=3D2
2018-04-18T11:12:55.0723221Z ++ shift
2018-04-18T11:12:55.0723357Z ++ '[' 1 -gt 0 ']'
2018-04-18T11:12:55.0723575Z ++ case "$1" in
2018-04-18T11:12:55.0723735Z ++ prev=3Dtest-path-comp
2018-04-18T11:12:55.0723874Z ++ shift
2018-04-18T11:12:55.0724009Z ++ '[' 0 -gt 0 ']'
2018-04-18T11:12:55.0724397Z ++ __git_main
2018-04-18T11:12:55.0724984Z ++ local i c=3D1 command __git_dir __git_repo_=
path
2018-04-18T11:12:55.0725183Z ++ local __git_C_args C_args_count=3D0
2018-04-18T11:12:55.0725353Z ++ '[' 1 -lt 2 ']'
2018-04-18T11:12:55.0725537Z ++ i=3Dtest-path-comp
2018-04-18T11:12:55.0725712Z ++ case "$i" in
2018-04-18T11:12:55.0725882Z ++ command=3Dtest-path-comp
2018-04-18T11:12:55.0726057Z ++ break
2018-04-18T11:12:55.0726270Z ++ '[' -z test-path-comp ']'
2018-04-18T11:12:55.0726446Z ++ __git_complete_command test-path-comp
2018-04-18T11:12:55.0726621Z ++ local command=3Dtest-path-comp
2018-04-18T11:12:55.0726816Z ++ local completion_func=3D_git_test_path_comp
2018-04-18T11:12:55.0726992Z ++ declare -f _git_test_path_comp
2018-04-18T11:12:55.0727353Z ++ declare -f _git_test_path_comp
2018-04-18T11:12:55.0727547Z ++ _git_test_path_comp
2018-04-18T11:12:55.0727716Z ++ __git_complete_index_file --others
2018-04-18T11:12:55.0727890Z ++ local dequoted_word pfx=3D cur_
2018-04-18T11:12:55.0728234Z ++ __git_dequote N
2018-04-18T11:12:55.0728418Z ++ local rest=3DN len ch
2018-04-18T11:12:55.0728869Z ++ dequoted_word=3D
2018-04-18T11:12:55.0729020Z ++ test -n N
2018-04-18T11:12:55.0729152Z ++ len=3D0
2018-04-18T11:12:55.0729309Z ++ dequoted_word=3DN
2018-04-18T11:12:55.0729440Z ++ rest=3D
2018-04-18T11:12:55.0729666Z ++ case "${rest:0:1}" in
2018-04-18T11:12:55.0729822Z ++ test -n ''
2018-04-18T11:12:55.0729993Z ++ case "$dequoted_word" in
2018-04-18T11:12:55.0730133Z ++ cur_=3DN
2018-04-18T11:12:55.0782504Z +++ __git_index_files --others '' N
2018-04-18T11:12:55.0782805Z +++ local root=3D match=3DN
2018-04-18T11:12:55.0845235Z +++ __git_ls_files_helper '' --others N
2018-04-18T11:12:55.0845440Z +++ '[' --others =3D=3D --committable ']'
2018-04-18T11:12:55.0845567Z +++ __git -C '' -c core.quotePath=3Dfalse ls-f=
iles --exclude-standard --others -- 'N*'
2018-04-18T11:12:55.0845706Z +++ git -C '' -c core.quotePath=3Dfalse ls-fil=
es --exclude-standard --others -- 'N*'
2018-04-18T11:12:55.0907632Z +++ awk -F / -v pfx=3D '{
2018-04-18T11:12:55.0907806Z =09=09paths[$1] =3D 1
2018-04-18T11:12:55.0908985Z =09}
2018-04-18T11:12:55.0942839Z =09END {
2018-04-18T11:12:55.0943072Z =09=09for (p in paths) {
2018-04-18T11:12:55.0949175Z =09=09=09if (substr(p, 1, 1) !=3D "\"") {
2018-04-18T11:12:55.0949458Z =09=09=09=09# No special characters, easy!
2018-04-18T11:12:55.0949659Z =09=09=09=09print pfx p
2018-04-18T11:12:55.0949823Z =09=09=09=09continue
2018-04-18T11:12:55.0949999Z =09=09=09}
2018-04-18T11:12:55.0950121Z=20
2018-04-18T11:12:55.0950335Z =09=09=09# The path is quoted.
2018-04-18T11:12:55.0950829Z =09=09=09p =3D dequote(p)
2018-04-18T11:12:55.0951171Z =09=09=09if (p =3D=3D "")
2018-04-18T11:12:55.0951555Z =09=09=09=09continue
2018-04-18T11:12:55.0951672Z=20
2018-04-18T11:12:55.0951856Z =09=09=09# Even when a directory name itself d=
oes not contain
2018-04-18T11:12:55.0952038Z =09=09=09# any special characters, it will sti=
ll be quoted if
2018-04-18T11:12:55.0952213Z =09=09=09# any of its (stripped) trailing path=
 components do.
2018-04-18T11:12:55.0952407Z =09=09=09# Because of this we may have seen th=
e same direcory
2018-04-18T11:12:55.0952583Z =09=09=09# both quoted and unquoted.
2018-04-18T11:12:55.0952762Z =09=09=09if (p in paths)
2018-04-18T11:12:55.0952948Z =09=09=09=09# We have seen the same directory =
unquoted,
2018-04-18T11:12:55.0953117Z =09=09=09=09# skip it.
2018-04-18T11:12:55.0953276Z =09=09=09=09continue
2018-04-18T11:12:55.0953441Z =09=09=09else
2018-04-18T11:12:55.0953613Z =09=09=09=09print pfx p
2018-04-18T11:12:55.0953766Z =09=09}
2018-04-18T11:12:55.0953914Z =09}
2018-04-18T11:12:55.0954461Z =09function dequote(p,    bs_idx, out, esc, es=
c_idx, dec) {
2018-04-18T11:12:55.0954650Z =09=09# Skip opening double quote.
2018-04-18T11:12:55.0954813Z =09=09p =3D substr(p, 2)
2018-04-18T11:12:55.0954935Z=20
2018-04-18T11:12:55.0955237Z =09=09# Interpret backslash escape sequences.
2018-04-18T11:12:55.0955415Z =09=09while ((bs_idx =3D index(p, "\\")) !=3D =
0) {
2018-04-18T11:12:55.0955533Z =09=09=09out =3D out substr(p, 1, bs_idx - 1)
2018-04-18T11:12:55.0955638Z =09=09=09esc =3D substr(p, bs_idx + 1, 1)
2018-04-18T11:12:55.0955743Z =09=09=09p =3D substr(p, bs_idx + 2)
2018-04-18T11:12:55.0955830Z=20
2018-04-18T11:12:55.0955939Z =09=09=09if ((esc_idx =3D index("abtvfr\"\\", =
esc)) !=3D 0) {
2018-04-18T11:12:55.0956079Z =09=09=09=09# C-style one-character escape seq=
uence.
2018-04-18T11:12:55.0956513Z =09=09=09=09out =3D out substr("\a\b\t\v\f\r\"=
\\",
2018-04-18T11:12:55.0956631Z esc_idx, 1)
2018-04-18T11:12:55.0956745Z =09=09=09} else if (esc =3D=3D "n") {
2018-04-18T11:12:55.0956853Z =09=09=09=09# Uh-oh, a newline character.
2018-04-18T11:12:55.0956973Z =09=09=09=09# We cant reliably put a pathname
2018-04-18T11:12:55.0957086Z =09=09=09=09# containing a newline into COMPRE=
PLY,
2018-04-18T11:12:55.0957193Z =09=09=09=09# and the newline would create a m=
ess.
2018-04-18T11:12:55.0957300Z =09=09=09=09# Skip this path.
2018-04-18T11:12:55.0957413Z =09=09=09=09return ""
2018-04-18T11:12:55.0957510Z =09=09=09} else {
2018-04-18T11:12:55.0957808Z =09=09=09=09# Must be a \nnn octal value, then=
=2E
2018-04-18T11:12:55.0958070Z =09=09=09=09dec =3D esc * 64 + \
2018-04-18T11:12:55.0958184Z =09=09=09=09      substr(p, 1, 1) * 8  + \
2018-04-18T11:12:55.0958274Z =09=09=09=09      substr(p, 2, 1)
2018-04-18T11:12:55.0958369Z =09=09=09=09out =3D out sprintf("%c", dec)
2018-04-18T11:12:55.0958587Z =09=09=09=09p =3D substr(p, 3)
2018-04-18T11:12:55.0958692Z =09=09=09}
2018-04-18T11:12:55.0958769Z =09=09}
2018-04-18T11:12:55.0958862Z =09=09# Drop closing double quote, if there is=
 one.
2018-04-18T11:12:55.0958969Z =09=09# (There isnt any if this is a directory=
, as it was
2018-04-18T11:12:55.0959153Z =09=09# already stripped with the trailing pat=
h components.)
2018-04-18T11:12:55.0959256Z =09=09if (substr(p, length(p), 1) =3D=3D "\"")
2018-04-18T11:12:55.0959356Z =09=09=09out =3D out substr(p, 1, length(p) - =
1)
2018-04-18T11:12:55.0959441Z =09=09else
2018-04-18T11:12:55.0959541Z =09=09=09out =3D out p
2018-04-18T11:12:55.0959598Z=20
2018-04-18T11:12:55.0959682Z =09=09return out
2018-04-18T11:12:55.0959763Z =09}'
2018-04-18T11:12:55.1182135Z ++ __gitcomp_file_direct $'New=E2=88=A9\201=E2=
=95=9DDir'
2018-04-18T11:12:55.1182355Z ++ local 'IFS=3D
2018-04-18T11:12:55.1182439Z '
2018-04-18T11:12:55.1182518Z ++ COMPREPLY=3D($1)
2018-04-18T11:12:55.1182622Z ++ compopt -o filenames +o nospace
2018-04-18T11:12:55.1182877Z ++ compgen -f /non-existing-dir/
2018-04-18T11:12:55.1182979Z ++ return 0
2018-04-18T11:12:55.1183055Z ++ return
2018-04-18T11:12:55.1183147Z ++ print_comp
2018-04-18T11:12:55.1183224Z ++ local 'IFS=3D
2018-04-18T11:12:55.1183300Z '
2018-04-18T11:12:55.1183398Z ++ echo $'New=E2=88=A9\201=E2=95=9DDir'
2018-04-18T11:12:55.1183508Z ++ sort out
2018-04-18T11:12:55.1183605Z ++ /usr/bin/sort out
2018-04-18T11:12:55.1306331Z ++ test_cmp expected out_sorted
2018-04-18T11:12:55.1306825Z ++ mingw_test_cmp expected out_sorted
2018-04-18T11:12:55.1307024Z ++ local test_cmp_a=3D test_cmp_b=3D
2018-04-18T11:12:55.1307233Z ++ local stdin_for_diff=3D
2018-04-18T11:12:55.1307401Z ++ test -s expected
2018-04-18T11:12:55.1307568Z ++ test -s out_sorted
2018-04-18T11:12:55.1307742Z ++ mingw_read_file_strip_cr_ test_cmp_a
2018-04-18T11:12:55.1308083Z ++ local line
2018-04-18T11:12:55.1308424Z ++ :
2018-04-18T11:12:55.1308566Z ++ IFS=3D$'\r'
2018-04-18T11:12:55.1308717Z ++ read -r -d '
2018-04-18T11:12:55.1308852Z ' line
2018-04-18T11:12:55.1317521Z ++ line=3D'New|Dir
2018-04-18T11:12:55.1317784Z '
2018-04-18T11:12:55.1318257Z ++ eval 'test_cmp_a=3D$test_cmp_a$line'
2018-04-18T11:12:55.1318424Z +++ test_cmp_a=3D'New|Dir
2018-04-18T11:12:55.1318569Z '
2018-04-18T11:12:55.1318724Z ++ :
2018-04-18T11:12:55.1318871Z ++ IFS=3D$'\r'
2018-04-18T11:12:55.1319027Z ++ read -r -d '
2018-04-18T11:12:55.1319170Z ' line
2018-04-18T11:12:55.1319334Z ++ test -z ''
2018-04-18T11:12:55.1319476Z ++ break
2018-04-18T11:12:55.1319628Z ++ mingw_read_file_strip_cr_ test_cmp_b
2018-04-18T11:12:55.1319797Z ++ local line
2018-04-18T11:12:55.1319939Z ++ :
2018-04-18T11:12:55.1320081Z ++ IFS=3D$'\r'
2018-04-18T11:12:55.1320240Z ++ read -r -d '
2018-04-18T11:12:55.1320384Z ' line
2018-04-18T11:12:55.1320555Z ++ line=3D'New=E2=88=A9=C3=BC=E2=95=9DDir
2018-04-18T11:12:55.1320915Z '
2018-04-18T11:12:55.1321099Z ++ eval 'test_cmp_b=3D$test_cmp_b$line'
2018-04-18T11:12:55.1321266Z +++ test_cmp_b=3D'New=E2=88=A9=C3=BC=E2=95=9DD=
ir
2018-04-18T11:12:55.1321422Z '
2018-04-18T11:12:55.1321570Z ++ :
2018-04-18T11:12:55.1321705Z ++ IFS=3D$'\r'
2018-04-18T11:12:55.1321859Z ++ read -r -d '
2018-04-18T11:12:55.1321994Z ' line
2018-04-18T11:12:55.1322219Z ++ test -z ''
2018-04-18T11:12:55.1322361Z ++ break
2018-04-18T11:12:55.1322497Z ++ test -n 'New|Dir
2018-04-18T11:12:55.1322649Z '
2018-04-18T11:12:55.1322828Z ++ test -n 'New=E2=88=A9=C3=BC=E2=95=9DDir
2018-04-18T11:12:55.1322977Z '
2018-04-18T11:12:55.1323109Z ++ test 'New|Dir
2018-04-18T11:12:55.1323397Z ' =3D 'New=E2=88=A9=C3=BC=E2=95=9DDir
2018-04-18T11:12:55.1323540Z '
2018-04-18T11:12:55.1323680Z ++ eval 'diff -u "$@" '
2018-04-18T11:12:55.1323840Z +++ diff -u expected out_sorted
2018-04-18T11:12:55.1454977Z --- expected=092018-04-18 11:12:55.065444100 +=
0000
2018-04-18T11:12:55.1455785Z error: last command exited with $?=3D1
2018-04-18T11:12:55.1456722Z +++ out_sorted=092018-04-18 11:12:55.127568400=
 +0000
2018-04-18T11:12:55.1457211Z @@ -1 +1 @@
2018-04-18T11:12:55.1457408Z -New|Dir
2018-04-18T11:12:55.1457752Z +New=E2=88=A9=C3=BC=E2=95=9DDir
2018-04-18T11:12:55.1457975Z not ok 111 - complete files - escaped characte=
rs on cmdline
2018-04-18T11:12:55.1645995Z #=09
2018-04-18T11:12:55.1646221Z #=09=09test_when_finished "rm -rf \"New|Dir\""=
 &&
2018-04-18T11:12:55.1646380Z #=09=09mkdir "New|Dir" &&
2018-04-18T11:12:55.1646487Z #=09=09>"New|Dir/New&File.c" &&
2018-04-18T11:12:55.1646583Z #=09
2018-04-18T11:12:55.1646865Z #=09=09test_completion "git test-path-comp N" =
\
2018-04-18T11:12:55.1646986Z #=09=09=09=09"New|Dir" &&=09# Bash will turn t=
his into "New\|Dir/"
2018-04-18T11:12:55.1647108Z #=09=09test_completion "git test-path-comp New=
\\|D" \
2018-04-18T11:12:55.1647212Z #=09=09=09=09"New|Dir" &&
2018-04-18T11:12:55.1647346Z #=09=09test_completion "git test-path-comp New=
\\|Dir/N" \
2018-04-18T11:12:55.1647510Z # "New|Dir/New&File.c" &&=09# Bash will turn t=
his into
2018-04-18T11:12:55.1647636Z # # "New\|Dir/New\&File.c "
2018-04-18T11:12:55.1647775Z #=09=09test_completion "git test-path-comp New=
\\|Dir/New\\&F" \
2018-04-18T11:12:55.1647886Z # "New|Dir/New&File.c"

I suspect that the culprit is once again Cygwin's trick where illegal
characters are mapped into a private Unicode page. Cygwin (and therefore
MSYS2 runtime, and therefore the Bash used to run the test script) can use
those filenames all right, but Git cannot.

So even testing whether you could write an illegal file name via shell
script is *not* enough to determine whether the file system supports funny
characters.

As far as I can tell from a *really* cursory glance, this is the only
affected test case. Apparently your prereq catches, somehow, on Windows:

2018-04-18T11:12:43.0459702Z     Your filesystem does not allow \ and " in =
filenames.
2018-04-18T11:12:43.0459823Z     skipped: complete files - C-style escapes =
in ls-files output (missing FUNNYNAMES_BS_DQ)

Ciao,
Dscho
--8323329-988917701-1524054680=:4241--
