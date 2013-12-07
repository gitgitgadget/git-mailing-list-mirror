From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: What's cooking in git.git (Dec 2013, #02; Fri, 6)
Date: Sat, 07 Dec 2013 18:03:22 +0100
Message-ID: <87ppp8h9ut.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
References: <xmqqk3fh1qrc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 07 18:03:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpLI2-0004Lv-V3
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 18:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758733Ab3LGRDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 12:03:34 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:52392 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758258Ab3LGRDe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 12:03:34 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 189B84D6510;
	Sat,  7 Dec 2013 18:03:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id IS0bD2cDrl08; Sat,  7 Dec 2013 18:03:22 +0100 (CET)
Received: from linux-1gf2.Speedport_W723_V_Typ_A_1_00_098.thomasrast.ch (84-73-190-173.dclient.hispeed.ch [84.73.190.173])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 99F914D64C4;
	Sat,  7 Dec 2013 18:03:22 +0100 (CET)
In-Reply-To: <xmqqk3fh1qrc.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 06 Dec 2013 15:52:39 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239008>

Junio C Hamano <gitster@pobox.com> writes:

> * jk/pack-bitmap (2013-11-18) 22 commits
>  - compat/mingw.h: Fix the MinGW and msvc builds
>  - pack-bitmap: implement optional name_hash cache
>  - t/perf: add tests for pack bitmaps
>  - t: add basic bitmap functionality tests
>  - count-objects: recognize .bitmap in garbage-checking
>  - repack: consider bitmaps when performing repacks
>  - repack: handle optional files created by pack-objects
>  - repack: turn exts array into array-of-struct
>  - repack: stop using magic number for ARRAY_SIZE(exts)
>  - pack-objects: implement bitmap writing
>  - rev-list: add bitmap mode to speed up object lists
>  - pack-objects: use bitmaps when packing objects
>  - pack-bitmap: add support for bitmap indexes
>  - documentation: add documentation for the bitmap format
>  - ewah: compressed bitmap implementation
>  - compat: add endianness helpers
>  - sha1_file: export `git_open_noatime`
>  - revision: allow setting custom limiter function
>  - pack-objects: factor out name_hash
>  - pack-objects: refactor the packing list
>  - revindex: export new APIs
>  - sha1write: make buffer const-correct
>  (this branch is tangled with jk/name-pack-after-byte-representation.)
>
>  Borrows the bitmap index into packfiles from JGit to speed up
>  enumeration of objects involved in a commit range without having to
>  fully traverse the history.

Peff can decide if he wants to reroll with my nits or not; either way
I'm all for moving it forward and aiming for one of the next releases.

-- 
Thomas Rast
tr@thomasrast.ch
