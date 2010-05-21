From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [StGit PATCH] edit: Allow setting git tree SHA1 of a patch
Date: Fri, 21 May 2010 19:48:32 +0200
Message-ID: <u5tpr0p6t8v.fsf@beatles.e.vtech>
References: <20100516172738.5043.94039.stgit@localhost.localdomain>
	<AANLkTikcG3Chw1cpiKB00MrnZz-HZk9xAF_KtTTiVECi@mail.gmail.com>
	<u5tzkzt73us.fsf@beatles.e.vtech>
	<AANLkTilV3VQARdyZ-m9GCXz1Rwt0j6Q6noNyFrmmDzR5@mail.gmail.com>
	<AANLkTimYCxzT16aI96dztmcKYuVrvKikSkrkRHT-Ckcd@mail.gmail.com>
	<AANLkTimIxtmaUNxp-LNy_ui5__BEBetcjTYE17ygIXD2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kha@treskal.com
To: Gustav =?utf-8?Q?H=C3=A5llberg?= <gustav@gmail.com>,
	Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 21 19:48:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFWL2-0002jP-UL
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 19:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934049Ab0EURso convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 May 2010 13:48:44 -0400
Received: from [62.20.90.206] ([62.20.90.206]:23672 "EHLO beatles.e.vtech"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S934036Ab0EURsn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 13:48:43 -0400
Received: from beatles.e.vtech (localhost.localdomain [127.0.0.1])
	by beatles.e.vtech (8.13.1/8.13.1) with ESMTP id o4LHmaPe015924;
	Fri, 21 May 2010 19:48:36 +0200
Received: (from david@localhost)
	by beatles.e.vtech (8.13.1/8.13.1/Submit) id o4LHmWu9015923;
	Fri, 21 May 2010 19:48:32 +0200
X-Authentication-Warning: beatles.e.vtech: david set sender to davidk@lysator.liu.se using -f
In-Reply-To: <AANLkTimIxtmaUNxp-LNy_ui5__BEBetcjTYE17ygIXD2@mail.gmail.com>
	(Catalin Marinas's message of "Fri, 21 May 2010 16:58:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147488>

Catalin Marinas <catalin.marinas@gmail.com> writes:

> BTW, since you are a group of people using stgit, have you found a
> useful way to share patches/series easily?

Not really. It is complicated by the fact that we are really using
subversion, and people are using git as a frontend to that with no
common git-svn import. But it hasn't been a big problem either.

Stgit is used to work on a set of changes that will sooner or later be
committed to svn. Shared "topic branches" that several people work on
live in svn.

I often mail patches for review using stg mail, and sometimes import
patches mailed to me. I have also used stg export a few times.

--=20
David K=C3=A5gedal
