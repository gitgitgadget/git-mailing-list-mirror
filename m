From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: git pull versus fetch/merge
Date: Mon, 21 Jul 2008 12:58:10 +0200
Message-ID: <48846BC2.4090407@keyaccess.nl>
References: <488452D6.1060508@keyaccess.nl> <20080721102320.GA19776@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 21 12:57:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKt4d-0000N9-Hq
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 12:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758276AbYGUKz7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jul 2008 06:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757814AbYGUKz7
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 06:55:59 -0400
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:43264 "EHLO
	smtpq2.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757553AbYGUKz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 06:55:58 -0400
Received: from [213.51.146.190] (port=53809 helo=smtp1.tilbu1.nb.home.nl)
	by smtpq2.tilbu1.nb.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1KKt3c-00019j-Tg; Mon, 21 Jul 2008 12:55:56 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:47943 helo=[192.168.0.3])
	by smtp1.tilbu1.nb.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1KKt3c-0000sf-5F; Mon, 21 Jul 2008 12:55:56 +0200
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <20080721102320.GA19776@atjola.homenet>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89340>

On 21-07-08 12:23, Bj=F6rn Steinbrink wrote:

> Your fetch/merge approach was different from what your pull approach=20
> did. tiwai/devel did not get updated by the fetch, which means that
> you tried to merge the old state of that branch and that caused some=20
> conflicts. OTOH the pull did fetch the latest state from the remote
> repo and merged that cleanly.
>=20
> Your fetch/merge approach was more like "git pull" without any=20
> arguments, but with the current branch setup to track tiwai/devel. In
> that case, pull really does a "git fetch tiwai", and it should fail
> in the same way.

Thank you. Also due to a reply on the ALSA list by Mark brown I now get=
=20
this. Yes, the remote was rebased while I had it setup as a remote here=
=20
it seems; only recently have it under this name, so I didn't think that=
=20
was the case. After a "git remote rm tiwai, git remote add tiwai <url>"=
=20
things work fine again as it fetched a completely new branch.

Hurray for rebasing public trees. This specific branch should be rebase=
d=20
only at every kernel release so I guess it's okay. I guess I can just d=
o
the git pull always, or the fetch every time and let the reject warn me=
=20
that it was rebased after which I'll do the remote rm/add thing again.

Many thanks for the concrete description of what goes on. Made it obvio=
us.

Rene.
