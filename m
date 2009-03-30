From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 3/4] Documentation: branch.*.merge can also afect 'git-push'
Date: Mon, 30 Mar 2009 12:35:10 +0200
Message-ID: <49D0A05E.7060708@drmicha.warpmail.net>
References: <1238407903-28020-1-git-send-email-santi@agolina.net> <1238407903-28020-4-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Mon Mar 30 13:37:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoFnb-0008A5-W6
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 13:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306AbZC3Lfc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 07:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752306AbZC3Lfc
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 07:35:32 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:43602 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752083AbZC3Lfc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 07:35:32 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 031F630854C;
	Mon, 30 Mar 2009 07:35:29 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 30 Mar 2009 07:35:30 -0400
X-Sasl-enc: vxXWHo/paLmIDlvd9/rMJj3Cft1X4Hn4VVwROtTl1L2R 1238412929
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 61C0828DED;
	Mon, 30 Mar 2009 07:35:29 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090328 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <1238407903-28020-4-git-send-email-santi@agolina.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115138>

Santi B=C3=A9jar venit, vidit, dixit 30.03.2009 12:11:
>=20
> Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
> ---
>  Documentation/config.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 7ae584f..38ab785 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -480,7 +480,7 @@ branch.<name>.remote::
>  branch.<name>.merge::
>  	It defines, together with branch.<name>.remote, the upstream branch
>  	for the given branch. It tells 'git-fetch'/'git-pull' which
> -	branch to merge.
> +	branch to merge and can also afect 'git-push' (see push.default).

s/afect/affect/

>  	When in branch <name>, it tells 'git-fetch' the default
>  	refspec to be marked for merging in FETCH_HEAD. The value is
>  	handled like the remote part of a refspec, and must match a
