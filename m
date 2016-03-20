From: Renato Botelho <garga@FreeBSD.org>
Subject: Re: [ANNOUNCE] Git v2.7.4 (and updates to older maintenance tracks)
Date: Sun, 20 Mar 2016 12:32:51 -0300
Message-ID: <680C4CDE-233E-4603-B3F1-D68EB126620F@FreeBSD.org>
References: <xmqqlh5gzuc8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 16:33:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahfLp-0003pv-OT
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 16:33:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755862AbcCTPc6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Mar 2016 11:32:58 -0400
Received: from mail-qg0-f68.google.com ([209.85.192.68]:35586 "EHLO
	mail-qg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755600AbcCTPc4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Mar 2016 11:32:56 -0400
Received: by mail-qg0-f68.google.com with SMTP id 51so4949749qgy.2
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 08:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ALx77R5d4LwJoqlzHNTwNzCSJh4pM/a63gpUN2xx9/Q=;
        b=h7JSy4AROSxYHEcw1vs9iysJ/2qJsndS/b4TjwfpjZwd2wUvTcMrhya/ECGjX/hzlV
         18GsD7XWmzEhvY+Xe6D9T29xVXs7UP8qk7Xj7q3N/zMUlZfE+YhvkSJn29ycv0X13zbb
         xRaxL/Knar2xfAW/sYbpk78cQ4jmtwFvgvFRmRE71PVrUy0E+LycveYEA9MTSkRtpafj
         OFWdR1vxFBPNLJZUmZ7auibGbyUpwthh9eTwvb3yIjOirwePxyEq++nSefo+pYXy+CCq
         RxJwYTKK4Ef2DVHPFFBrlaFAJDI4d7RweUqB8lHdb+KQx4TEIavl3auLHT7nSmlv+3SH
         ukxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:mime-version:subject:from:in-reply-to
         :date:cc:content-transfer-encoding:message-id:references:to;
        bh=ALx77R5d4LwJoqlzHNTwNzCSJh4pM/a63gpUN2xx9/Q=;
        b=Ckt3gpXURih9VexFQOeJ+uza7ZuDdOUiqLRceWFidsyhWljKnvg8KYnvdF1agc3bqR
         SD0BL2fx60OIHKDHRnEM3S6kb+qIP9gNgmXN4y0SYnTtjYlq9qReSZX/Q3ZBJdIui5QV
         kk0rCq5DBEhH0Zd6EZkQdRuL8XGePzEAT4pMPJQfKKOVQrLfQp782GfYbalivVpSgkcV
         Qq03iO94e4Prfj0tULoV0eb0zxIzLGmTM8TEESTv9jab/dd+auHf76EKYXjOwystaqwD
         zkYxBvqgA+ucVk0DTKUEmapW28pgTwRFQFB0cxHaFkTykpSQvHqfzzGmntARD0xipfkf
         ftiw==
X-Gm-Message-State: AD7BkJIQbaXY28JC9LQKbGDpUgKW/a749AqkTZiBuohb+wfHLhKnrlmNqeOY1zj6sMPUpg==
X-Received: by 10.140.254.9 with SMTP id z9mr36944468qhc.5.1458487975454;
        Sun, 20 Mar 2016 08:32:55 -0700 (PDT)
Received: from mbp.home (179-125-143-18.desktop.com.br. [179.125.143.18])
        by smtp.gmail.com with ESMTPSA id q94sm10342437qgq.14.2016.03.20.08.32.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Mar 2016 08:32:54 -0700 (PDT)
In-Reply-To: <xmqqlh5gzuc8.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289357>

> On Mar 17, 2016, at 18:07, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> The latest maintenance release Git v2.7.4 is now available at the
> usual places.  The same set of bugfix patches from the current
> 'master' have been backported to older maintenance tracks and are
> available as v2.4.11, v2.5.5 and v2.6.6.  These are to fix a heap
> corruption / buffer overflow bug and users are strongly encouraged
> to upgrade.  The fix has already been in the release candidate
> v2.8.0-rc3 as well.
>=20
> The tarballs are found at:
>=20
>    https://www.kernel.org/pub/software/scm/git/
>=20
> The following public repositories all have a copy of the 'v2.7.4'
> tag and the 'maint' branch that the tag points at:
>=20
>  url =3D https://kernel.googlesource.com/pub/scm/git/git
>  url =3D git://repo.or.cz/alt-git.git
>  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
>  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
>  url =3D https://github.com/gitster/git
>=20
> ----------------------------------------------------------------
>=20
> Git v2.7.4 Release Notes
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>=20
> Fixes since v2.7.3
> ------------------
>=20
> * Bugfix patches were backported from the 'master' front to plug heap
>   corruption holes, to catch integer overflow in the computation of
>   pathname lengths, and to get rid of the name_path API.  Both of
>   these would have resulted in writing over an under-allocated buffer
>   when formulating pathnames while tree traversal.
>=20
> ----------------------------------------------------------------
>=20
> Changes since v2.7.3 are as follows:
>=20
> Jeff King (7):
>      add helpers for detecting size_t overflow
>      tree-diff: catch integer overflow in combine_diff_path allocatio=
n
>      http-push: stop using name_path
>      show_object_with_name: simplify by using path_name()
>      list-objects: convert name_path to a strbuf
>      list-objects: drop name_path entirely
>      list-objects: pass full pathname to callbacks
>=20
> Junio C Hamano (4):
>      Git 2.4.11
>      Git 2.5.5
>      Git 2.6.6
>      Git 2.7.4

=46YI,

2.7.4 fails to build on FreeBSD 9.x, that uses by default gcc 4.2.1. I=E2=
=80=99ve fixed it adding an extra dependency to make force it to requir=
e gcc 4.8+. Here is the output:

cc -o combine-diff.o -c -MF ./.depend/combine-diff.o.d -MQ combine-diff=
=2Eo -MMD -MP -isystem/usr/local/include -O2 -pipe -fstack-protector -f=
no-strict-aliasing -I. -I/usr/local/include -I/usr/local/include -DUSE_=
CURL_FOR_IMAP_SEND -I/usr/include -DUSE_ST_TIMESPEC -pthread -DHAVE_PAT=
HS_H -DHAVE_STRINGS_H -DGMTIME_UNRELIABLE_ERRORS -DHAVE_CLOCK_GETTIME -=
DHAVE_CLOCK_MONOTONIC -DHAVE_BSD_SYSCTL -DHAVE_GETDELIM -DSHA1_HEADER=3D=
'<openssl/sha.h>'  -DDIR_HAS_BSD_GROUP_SEMANTICS -DSHELL_PATH=3D'"/bin/=
sh"'  combine-diff.c
combine-diff.c: In function 'diff_tree_combined':
combine-diff.c:1391: internal compiler error: Segmentation fault: 11
Please submit a full bug report,
with preprocessed source if appropriate.
See <URL:http://gcc.gnu.org/bugs.html> for instructions.
Makefile:1924: recipe for target 'combine-diff.o' failed
gmake: *** [combine-diff.o] Error 1
*** [do-build] Error code 1

--
Renato Botelho
