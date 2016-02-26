From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Feb 2016, #07; Thu, 25)
Date: Fri, 26 Feb 2016 17:10:27 +0100
Message-ID: <56D078F3.9070905@web.de>
References: <xmqqfuwgmlgy.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 17:10:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZKyh-00007N-1S
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 17:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbcBZQKq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Feb 2016 11:10:46 -0500
Received: from mout.web.de ([212.227.15.14]:59098 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753896AbcBZQKq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 11:10:46 -0500
Received: from macce.local ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MHpOP-1acuPJ2vHR-003beb; Fri, 26 Feb 2016 17:10:36
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
In-Reply-To: <xmqqfuwgmlgy.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:+ADnREyALi3jExt9DcDy8aHh1t9bNcXGGV9RL7ZoMJPRsgQjh6B
 mIjtqvYNdYcTkMoLYFa1zHP2lhls7b9yB89tDdwskFHswWF4CfvANdpBBAh/N1IM+gZGym3
 hCyQBY8ZH8MsfMQiL93kVRqOJ25vWkI6dK6pFs5+aUi5zbP7S3bmW+brifPZQFD1niUEa7H
 ZFSOuT6r4ZeQ6mfbHiYNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OfQUiNdser8=:esR4rQNbOYkQA127+RbH9M
 1l9d3vAQhGijaJLzKgCz2SY50bJMMlgknKGH0cPR3UompihSlc4YDNM2H64/zFyHyLYLborMU
 L3F+HEI5qeVed0dR2003w457Gpgkpesza24WiIgk9u8uS9kJ8WdYSExa4XCDKy2RLEN0F+41q
 Z7fqvN+H+2i+RMd2FhbK3hOzxNSI3E/1CD+Jx5XNy39L+l5z621HnFmYB6keihF78BMy4eXK8
 t9hNvWRY7aI+2sPSISSESxYwR2qGsOOe5PDAj8uuUwMU9PB2DFBQQqbpRkqYUFGHJNCOWRpEg
 INtM8GoLgR/JWz9AYqiAlymgq5MzXRAEz5cPucAL4Qfo0pPO4pXTVvc67CS66MZwOAY3C41+e
 v1q0t+vuXV75xHQp8jeoLnlhTgeE3YhNNyMojYIkp5AaIdvlSj8zxaGMwEJ0rKza3bARRyQOX
 d2h+h1HTsuue9x+EE3iAuj0uzsm6U1kU/SlPDgjb11CMGh0VrQWXdzczsSvkqfV6rwne547jS
 mvEzzyfrCImcfQmpz/a2SNi+H4DCeUtALU7+m5roRhb5J2reNvaaOYENxZcpBMa1kQb+e6kBU
 1eqwu8bltReR0nNy2F/wkD1Q2E2E/btzYLJw3qn3SCu3gcTkFMit6YgQl1he6Ar0tyTXebJ2O
 Ja7anvY5Luj9aKDdJ2PEw5h6rYJhIrYaMFRg8GlrPrWFh6/ZHp91S0ReTCOriPhbKR6xfkUhA
 xXx28ZvR/f3gSE9flbIHR/SPtp7CjFSZZ1Q09dZyF02aP4YvF7ac2dGFineNBGX2vGQ5O9vR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287581>


> * jk/tighten-alloc (2016-02-22) 22 commits
>   (merged to 'next' on 2016-02-24 at 78b3251)
>  + ewah: convert to REALLOC_ARRAY, etc
>  + convert ewah/bitmap code to use xmalloc
>  + diff_populate_gitlink: use a strbuf
>  + transport_anonymize_url: use xstrfmt
>  + git-compat-util: drop mempcpy compat code
>  + sequencer: simplify memory allocation of get_message
>  + test-path-utils: fix normalize_path_copy output buffer size
>  + fetch-pack: simplify add_sought_entry
>  + fast-import: simplify allocation in start_packfile
>  + write_untracked_extension: use FLEX_ALLOC helper
>  + prepare_{git,shell}_cmd: use argv_array
>  + use st_add and st_mult for allocation size computation
>  + convert trivial cases to FLEX_ARRAY macros
>  + use xmallocz to avoid size arithmetic
>  + convert trivial cases to ALLOC_ARRAY
>  + convert manual allocations to argv_array
>  + argv-array: add detach function
>  + add helpers for allocating flex-array structs
>  + harden REALLOC_ARRAY and xcalloc against size_t overflow
>  + tree-diff: catch integer overflow in combine_diff_path allocation
>  + add helpers for detecting size_t overflow
>  + reflog_expire_cfg: NUL-terminate pattern field
>=20
>  Update various codepaths to avoid manually-counted malloc().
>=20
>  Will merge to 'master'.
>=20

Sorry being late,
but this is what my older test system says:

CC combine-diff.o
combine-diff.c: In function =91diff_tree_combined=92:
combine-diff.c:1391: internal compiler error: Segmentation fault
Please submit a full bug report,
with preprocessed source if appropriate.
See <URL:http://developer.apple.com/bugreporter> for instructions.
make: *** [combine-diff.o] Error 1

Revert "use st_add and st_mult for allocation size computation" didn't =
fix it.
I haven't digged deeper yet.
