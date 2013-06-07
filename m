From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: What's cooking in git.git (Jun 2013, #03; Thu, 6)
Date: Fri, 7 Jun 2013 02:00:06 +0200
Message-ID: <20130607000006.GA25731@goldbirke>
References: <7vzjv2x3p7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 02:00:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukk6T-00070p-9e
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 02:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882Ab3FGAAV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jun 2013 20:00:21 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:52363 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908Ab3FGAAU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 20:00:20 -0400
Received: from localhost6.localdomain6 (f052187059.adsl.alicedsl.de [78.52.187.59])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0ME88h-1Ub74C2QWd-00HMQu; Fri, 07 Jun 2013 02:00:07 +0200
Content-Disposition: inline
In-Reply-To: <7vzjv2x3p7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:QNE6rRCBSf0EuuPybJcbw1oxboeuKqneMXCDHcr9025
 nfx2hUONo9n+PvfXD+Bc7n0ygckHOxr7spqjNhu+wuVlHo4/8+
 Jf6SVX+rvl3Asl0pnGMgGPgWUZfDMxUjFioMH4AMt2stQlFaAx
 tRKc0sOHFJS0MIK+EaZVDLdkRmK3FAN29twfVJGI89x3tJyHra
 1ApCb29NFq7m9XKDHBImGJKT8AXD6MHIfoo/ZoYkSknoC3dluh
 u273vpJqSo4vhgYQKwK7spcOtrRi336yROUZF+4fUuzed5c1Vl
 MOOoIn2WRsDQp8KbWmwPms6UGIySq6DVoYI1XsnLP0Sk7dCBDr
 n5z8LG/VBIUb2cA4ERm8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226572>

On Thu, Jun 06, 2013 at 03:41:08PM -0700, Junio C Hamano wrote:
> * rr/complete-difftool (2013-06-03) 2 commits
>   (merged to 'next' on 2013-06-04 at 01c7611)
>  + completion: clarify ls-tree, archive, show completion
>  + completion: difftool takes both revs and files
>=20
>  Update command line completion (in contrib/) to use a better named
>  completion helper function for commands that take revisions and
>  paths.
>=20
>  Will merge to 'master'.

This should not be merged to master as is; the one at the top because
of the reasons given in $gmane/226272, the one at the bottom because
of the misleading commit message (__git_complete_file() always
completed refs first as part of the ref:file notation, so it worked
just fine except for the ref1...ref2 notation; the real reason for
calling __git_complete_revlist_file() for difftool is to make clear
that difftool takes ref1...ref2:file, too).


G=E1bor
