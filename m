From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 5/9] revert: add --ff option to allow fast forward when cherry-picking
Date: Sat, 6 Feb 2010 16:29:05 +0100
Message-ID: <201002061629.05640.chriscool@tuxfamily.org>
References: <20100205231028.3689.12228.chriscool@tuxfamily.org> <20100205231112.3689.67634.chriscool@tuxfamily.org> <4B6D38FB.9000307@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sat Feb 06 16:26:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdmXq-0004VO-7a
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 16:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793Ab0BFPZ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2010 10:25:57 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:54058 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752665Ab0BFPZ5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Feb 2010 10:25:57 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 8C1C881807F;
	Sat,  6 Feb 2010 16:25:47 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id AA379818036;
	Sat,  6 Feb 2010 16:25:45 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <4B6D38FB.9000307@gnu.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139173>

On samedi 06 f=E9vrier 2010, Paolo Bonzini wrote:
> On 02/06/2010 12:11 AM, Christian Couder wrote:
> > As "git merge" fast forwards if possible, it seems sensible to
> > have such a feature for "git cherry-pick" too, especially as it
> > could be used in git-rebase--interactive.sh.
> >
> > Maybe this option could be made the default in the long run, with
> > another --no-ff option to disable this default behavior, but that
> > could make some scripts backward incompatible and/or that would
> > require testing if some GIT_AUTHOR_* environment variables are
> > set. So we don't do that for now.
>
> I would still like to have a no-op --no-ff so that scripts that do re=
ly
> on that can be future proofed (or also, scripts that do "git cherry-p=
ick
> $blah -e COMMIT" could use --no-ff to avoid errors in case $blah
> contains --ff).

Ok, I will add a --no-ff option but I think it should be incompatible=20
with --ff rather than overide it.

Thanks,
Christian.
