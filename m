From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Add git format-patch produced patches to .gitignore
Date: Sun, 16 May 2010 16:05:41 +0200
Message-ID: <4BEFFBB5.7010808@drmicha.warpmail.net>
References: <1273958566-7328-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 16 16:11:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODeYo-0006GB-GH
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 16:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753543Ab0EPOFm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 May 2010 10:05:42 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52559 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753056Ab0EPOFm (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 May 2010 10:05:42 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E2CC7F75A0;
	Sun, 16 May 2010 10:05:35 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Sun, 16 May 2010 10:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=inBCo9foQ6w2P+IjLQd8+KFCvGg=; b=PYACc2YcV/Zi/3C60oEHnr2qij71VIl8T8VBhNfxsWPEsB4SHCgSju7/G+51bOrgcvk8CHWWO0PjyRMu/UPPOMecu0a17N62zXBCBUe+g0kMrS2Yi0YKK7PlpriverzXkdw0jlI9kNKr/oGOQdY2C3SnPssdcq9x8+XP3ePsMdo=
X-Sasl-enc: GkY8zod5nLU5amEMZHmwta175tgrBp7as7WouPlISSRx 1274018735
Received: from localhost.localdomain (p548589F2.dip0.t-ipconnect.de [84.133.137.242])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A7C8A4C4638;
	Sun, 16 May 2010 10:05:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <1273958566-7328-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147192>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 15.05.2010 2=
3:22:
> Change Git's own .gitignore so that patches produced with git
> format-patch don't show up as untracked.
>=20

Does the git build process call format-patch? No! The .gitignore we
distribute is meant for things the build process creates, not for
imposing a specific workflow on developers.

If you want to ignore format patch output, simply use .git/info/exclude=
s
or a global excludes file, but please don't force everyone else to live
with that or work around it.

Cheers,
Michael

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> ---
>  .gitignore |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/.gitignore b/.gitignore
> index dbf1b90..039d99c 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -203,3 +203,4 @@
>  *.pdb
>  /Debug/
>  /Release/
> +[0-9][0-9][0-9][0-9]-*.patch
