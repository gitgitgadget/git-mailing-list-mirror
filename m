From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Deleting remote branch pointed by remote HEAD
Date: Wed, 21 Jan 2009 15:33:36 +0100
Message-ID: <49773240.7090605@drmicha.warpmail.net>
References: <e29894ca0901210502n1ed1187bm46669a402ab4fe48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 15:36:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPeAZ-0003G9-4f
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 15:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635AbZAUOdj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jan 2009 09:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754377AbZAUOdi
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 09:33:38 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60473 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754031AbZAUOdi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jan 2009 09:33:38 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 4EBB3244B06;
	Wed, 21 Jan 2009 09:33:37 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 21 Jan 2009 09:33:37 -0500
X-Sasl-enc: dvL9w0mq6AqnxKtXuLjnEEDJfiqbNsaZJWl+2BXRU4W6 1232548416
Received: from [139.174.44.34] (pascal.math.tu-clausthal.de [139.174.44.34])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B669129E80;
	Wed, 21 Jan 2009 09:33:36 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <e29894ca0901210502n1ed1187bm46669a402ab4fe48@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106608>

Marc-Andr=E9 Lureau venit, vidit, dixit 21.01.2009 14:02:
> Hi
>=20
> I deleted a remote branch which was pointed by HEAD, this way: "git
> push origin :master"
>=20
> Then for almost every git command, I get this error: "error:
> refs/remotes/origin/HEAD points nowhere!".

You're talking about about the remote git repo, aren't you?

> I found this situation non-friendly. Fortunately, I could understand
> what's going on. But a new user might be confused.
>=20
> Shouldn't the remote HEAD branch be updated or "protected" in some
> ways? Or should the "error" be considered as a "warning" (silently?)
>=20
> What do you think?

I think that git said
"warning: updating the currently checked out branch; this may cause
confusion,
as the index and working tree do not reflect changes that are now in HE=
AD."
after your push and that this may have rung some bells. I also think
that pushing to a non-bare remote repo (one with a worktree checked out=
)
is strongly advised against in multiple places, unless you know what
you're doing - which you seem to do since you were able to restore your
HEAD ;)

Cheers,
Michael
