From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [ANNOUNCE] Git v2.7.4 (and updates to older maintenance tracks)
Date: Fri, 18 Mar 2016 09:29:38 +0100
Message-ID: <56EBBC72.7000201@web.de>
References: <xmqqlh5gzuc8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 18 09:29:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agpnB-00034j-I5
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 09:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbcCRI3u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2016 04:29:50 -0400
Received: from mout.web.de ([212.227.15.14]:57664 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751680AbcCRI3r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 04:29:47 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MYZ8c-1aKIwi48Qc-00VS6U; Fri, 18 Mar 2016 09:29:39
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
In-Reply-To: <xmqqlh5gzuc8.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:RDp91ujRuukflkO49Gi7BPsv8F4rbt6u0r12g2s0WGdS8A71SRw
 nZzTA0jztc216kQaFDoBRhbxwbhDwtunfpeFCtmOA1QIB8l64P4/VufsJmChrROw0IgyWvN
 22ddGBU16QBr7BNOcRWTSU4COm51Oy49GpsqlXoakJqjlm3r5zP5cbqqCTO4yV9vPzEXy9o
 WpQBJjERibm8u1w689TQg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vttiQhk+1lw=:+PlKcFk5yQIx1Z9cEPXYkh
 I5Yz14nNIbj1Wv4afWbrU45wkxXmoSS3QYVQgcYNsH0OfYYeBeEXFC2z+qTzAuiL7Wxjm4dVd
 cGrSusgQ0cZvaxtNUFD/bjKxifttEeITylX/5BtbnrXh+gmcxaw76lbg5PohwZP6yGTFltLOl
 mlILb6bqcN2aQ3T+IUzxPIeQIP9SRkUkWPZ68eCFSecdZFcApTnRq9ZwRNNbGKbovLRIvR+iP
 94VutQNJ8ny8TKKGCRzUlB6F+brOmlCRPuJoc53K54jy1MplXGX9i+WJluesuVXBQimKyYPxu
 MtiVTEZA/IdRPHEfmkWTNxk556s+k54AxiP8fuBxVWEpkZA0jWZSz88F8DJGtgoTazp3vub9A
 yPbRAsNFJDQui4bolD+BBvD1R6P/Hk7VdL8guG5ICpR1Rv1O/WPwvxOJK9erWO0GUYvLQtC+0
 43lim3IxD1NOi7NitdfhdhuIsaHR0yCjEdG0r8a9Tdf6nQKiFUyzRSLgQeaa4Wm1aya9LrBv0
 1lDdkWey5CJRG+Ku17RBGbaxqNdv1xhnhLTbQ3i13LSRuVUj551cjV47c8FSHQFoXAb32tRvO
 fFpLtE0Qewo2ZCATllpmJ+UlUWW3qwVPYqG4MGO9soE2Wa1z4zvCwDzcMNAHqJ22KR3KXFmBJ
 S0As5IB6QYl4zDPxIFdI9sXuyOSCRBU3SxAtbGPlXm7ZBgNtZ6vtKRm50L9yvcNLgABJE0dMK
 YDXhwSPZYBB3kfum58s6Pu2Rk6poLWstCReuuiQ7yYXChpsLvF60ZNeTdPjP47hKwEQBDOlF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289212>

> Git v2.7.4 Release Notes
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>=20
> Fixes since v2.7.3
> ------------------
>=20
>  * Bugfix patches were backported from the 'master' front to plug hea=
p
>    corruption holes, to catch integer overflow in the computation of
>    pathname lengths, and to get rid of the name_path API.  Both of
>    these would have resulted in writing over an under-allocated buffe=
r
>    when formulating pathnames while tree traversal.
>=20
> ----------------------------------------------------------------
>=20
> Changes since v2.7.3 are as follows:
>=20
> Jeff King (7):
>       add helpers for detecting size_t overflow
>       tree-diff: catch integer overflow in combine_diff_path allocati=
on
>       http-push: stop using name_path
>       show_object_with_name: simplify by using path_name()
>       list-objects: convert name_path to a strbuf
>       list-objects: drop name_path entirely
>       list-objects: pass full pathname to callbacks
>=20
If there is a new 2.7.x release, does it make sense to cherry-pick this=
 one:

commit 7b6daf8d2fee1a9866b1d4eddbfaa5dbc42c5dbb
Author: Torsten B=C3=B6gershausen <tboegi@web.de>
Date:   Sun Feb 28 21:09:44 2016 +0100

    config.mak.uname: use clang for Mac OS X 10.6
   =20
