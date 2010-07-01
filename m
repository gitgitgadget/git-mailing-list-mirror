From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: [PATCH] RelNotes-1.7.2: cherry-pick and revert learned the same
 things
Date: Thu, 1 Jul 2010 10:09:31 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC7448415281B@xmail3.se.axis.com>
References: <20100701051028.2369.53975.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 01 10:10:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUErI-0004Ri-Le
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 10:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177Ab0GAIKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 04:10:46 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:41458 "EHLO
	miranda.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab0GAIKn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jul 2010 04:10:43 -0400
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by miranda.se.axis.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id o6189X41022420;
	Thu, 1 Jul 2010 10:09:33 +0200
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Thu, 1 Jul 2010 10:09:33 +0200
Thread-Topic: [PATCH] RelNotes-1.7.2: cherry-pick and revert learned the
 same things
Thread-Index: AcsY2/dWp9Ro+yA5QeWFvSjQpfZf+gAGJJ5w
In-Reply-To: <20100701051028.2369.53975.chriscool@tuxfamily.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150011>

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Christian Couder
> Sent: den 1 juli 2010 07:10
> To: Junio C Hamano
> Cc: git@vger.kernel.org
> Subject: [PATCH] RelNotes-1.7.2: cherry-pick and revert learned the
> same things
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/RelNotes-1.7.2.txt |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/RelNotes-1.7.2.txt b/Documentation/RelNotes-
> 1.7.2.txt
> index 8ed7406..53a71da 100644
> --- a/Documentation/RelNotes-1.7.2.txt
> +++ b/Documentation/RelNotes-1.7.2.txt
> @@ -44,9 +44,12 @@ Updates since v1.7.1
>     prepares to create a root commit that is not connected to any
> existing
>     commit.
> 
> - * "git cherry-pick" learned to pick a range of commits (e.g. "cherry-pick
> -   A..B"); this does not have nicer sequencing control "rebase [-i]" has,
> -   though.
> + * "git cherry-pick" and "git revert" learned to pick a range of
> +   commits (e.g. "cherry-pick A..B"); this does not have nicer

Shouldn't that be "the nicer"?

> +   sequencing control "rebase [-i]" has, though.
> +
> + * "git cherry-pick" and "git revert" learned --strategy option to
> +   specify the merge strategy.
> 
>   * "git cvsserver" can be told to use pserver; its password file can be
>     stored outside the repository.
> @@ -92,8 +95,6 @@ Updates since v1.7.1
> 
>   * "git remote" learned "set-branches" subcommand.
> 
> - * "git revert" learned --strategy option to specify the merge strategy.
> -
>   * "git rev-list A..B" learned --ancestry-path option to further limit
>     the result to the commits that are on the ancestry chain between A and
>     B (i.e. commits that are not descendants of A are excluded).
> --
> 1.7.2.rc0.223.g465131.dirty

//Peter
