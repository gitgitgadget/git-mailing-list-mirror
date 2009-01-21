From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Deleting remote branch pointed by remote HEAD
Date: Wed, 21 Jan 2009 16:24:56 +0100
Message-ID: <49773E48.90302@drmicha.warpmail.net>
References: <e29894ca0901210502n1ed1187bm46669a402ab4fe48@mail.gmail.com>	 <49773240.7090605@drmicha.warpmail.net> <e29894ca0901210638t636de791sf27d28893a7a0b65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 16:26:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPeyF-0002dT-CH
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 16:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755948AbZAUPY6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jan 2009 10:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753533AbZAUPY5
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 10:24:57 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57861 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752572AbZAUPY5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jan 2009 10:24:57 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 70C8F2494EA;
	Wed, 21 Jan 2009 10:24:56 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 21 Jan 2009 10:24:56 -0500
X-Sasl-enc: hw/RidUM7mMuEUhu0CK6h+2NiOivy5JTn2mFhfHFIi22 1232551496
Received: from [139.174.44.34] (pascal.math.tu-clausthal.de [139.174.44.34])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B167A2D404;
	Wed, 21 Jan 2009 10:24:55 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <e29894ca0901210638t636de791sf27d28893a7a0b65@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106615>

Marc-Andr=E9 Lureau venit, vidit, dixit 21.01.2009 15:38:
> On Wed, Jan 21, 2009 at 4:33 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Marc-Andr=E9 Lureau venit, vidit, dixit 21.01.2009 14:02:
>>> Hi
>>>
>>> I deleted a remote branch which was pointed by HEAD, this way: "git
>>> push origin :master"
>>>
>>> Then for almost every git command, I get this error: "error:
>>> refs/remotes/origin/HEAD points nowhere!".
>> You're talking about about the remote git repo, aren't you?
>>
>=20
> Sure. But the error is on the local repo.

So, you get these errors on the local repo when dealing with the remote
repo, right? I guess this means two things:

1) You are deleting a remote branch

2) Your original report could have been a bit more detailed ;)

In fact, I'm still unsure about your setup and can't reproduce, unless
"almost every git command" was vastly exaggerated, and Adeodato's
description matches your setup. Does it?

If yes then git has basically no choice, unless you want git to leave
HEAD in place as a detached head. This is related to how the symref is
resolved, which in turn is related to the issue of removing remote
branches, which in turn is related to an issue I've been meaning to loo=
k
into quite a while ago... So, reproducibility would be nice.

Cheers,
Michael
