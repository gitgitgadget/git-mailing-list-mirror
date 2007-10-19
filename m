From: Pete/Piet Delaney <pete@bluelane.com>
Subject: Re: Qgit performance and maintain CVS environment with GIT repository
Date: Fri, 19 Oct 2007 01:58:37 -0700
Organization: Bluelane
Message-ID: <471871BD.7030608@bluelane.com>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com> <Pine.LNX.4.64.0710190054570.25221@racer.site> <4717F8CF.9060103@bluelane.com> <200710190943.45201.wielemak@science.uva.nl>
Reply-To: pete@bluelane.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	piet.delaney@gmail.piet.net,
	Linus Torvalds <torvalds@linux-foundation.org>,
	VMiklos <vmiklos@frugalware.org>,
	free cycle <freecycler23@yahoo.com>, git@vger.kernel.org,
	piet.delaney@gmail.com, Piet Delaney <pdelaney@bluelane.com>
To: Jan Wielemaker <wielemak@science.uva.nl>
X-From: git-owner@vger.kernel.org Fri Oct 19 11:02:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iinki-0006CC-Gh
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 11:02:44 +0200
Received: from mail-mx8.uio.no ([129.240.10.38])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Iinkb-0002qZ-Gs
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 11:02:37 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx8.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IinkN-0002lP-0b
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 11:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756484AbXJSI6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 04:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756785AbXJSI6p
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 04:58:45 -0400
Received: from outbound.mse2.exchange.ms ([69.25.50.247]:56835 "EHLO
	mse2fe1.mse2.exchange.ms" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756334AbXJSI6o (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Oct 2007 04:58:44 -0400
Received: from piet2.bluelane.com ([64.95.123.130]) by mse2fe1.mse2.exchange.ms with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 19 Oct 2007 04:58:42 -0400
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <200710190943.45201.wielemak@science.uva.nl>
X-Enigmail-Version: 0.95.3
X-OriginalArrivalTime: 19 Oct 2007 08:58:42.0727 (UTC) FILETIME=[3FBDFB70:01C8122E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=disabled, AWL=2.000,RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: E1BBA18A07313A049B3B49299FC18688E8789D68
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -49 maxlevel 200 minaction 2 bait 0 mail/h: 20 total 622346 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61678>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jan Wielemaker wrote:
> On Friday 19 October 2007 02:22, Pete/Piet Delaney wrote:
>> We are definitely not fine with CVS, the branch merging isn't
>> comfortable. I'm just wondering about maintaining the existing
>> CVS browsers and the build scripts if it's not a big deal. I'll
>> try the git-cvsserver path. If anyone has any war stories to share
>> on the path this would be an ideal time to share them.
> 
> As for web browsing the history, our project was quickly convinced
> gitweb is a lot better than cvsweb.  We are starting to get use to
> basic git.  One developer works on CVS.  This is a bit handicapped,
> but workable after a few patches to git-shell and git-cvsserver.

Could you tell me a bit more about those patches and the need for using
git-shell (haven't even messed with that yet).

Think I can set things up so the CVS updates, checkouts, and the
like that are being used on our build machines can remain untouched
and have the git-cvsserver exactly acting like the current CVS server.
It would be nice if branches and tags work without touching all of the
build machines and their scripts.

I don't think we need to have any developers continuing to use CVS;
but I may be wrong. I think I read that there's a limitation to being
on the main branch and unfortunately most of out tags are on a release
branch.

- -piet

> 
> In another project I use git-cvsserver to do the Windows builds.
> All development except for minor typos and compatibility things is
> done on linux and cvs <-> git works just fine for that model.
> 
> 	--- Jan
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHGHG9JICwm/rv3hoRApQIAJ0Ys6QwxnBAu9tNWrGLU9svwtYXZwCeIFlq
Yr8snPT8TW/nBxFygFr95Ik=
=MtJS
-----END PGP SIGNATURE-----
