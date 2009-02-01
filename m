From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Sun, 01 Feb 2009 16:37:55 +1300
Message-ID: <1233459475.17688.128.camel@maia.lan>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de>
	 <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
	 <76718490901300817x3f31460k59b6fe75d136372d@mail.gmail.com>
	 <alpine.DEB.1.00.0901301756560.3586@pacific.mpi-cbg.de>
	 <76718490901301050h1f0f5b2bq902de384d954d99b@mail.gmail.com>
	 <alpine.DEB.1.00.0901301959300.3586@pacific.mpi-cbg.de>
	 <20090131095622.6117@nanako3.lavabit.com>
	 <7v63juzz9m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 01 04:44:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTTFc-0000R1-EP
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 04:44:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbZBADiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 22:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbZBADiS
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 22:38:18 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:33190 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517AbZBADiR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 22:38:17 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 65E1621D98A; Sun,  1 Feb 2009 16:38:00 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 906EE21C51D;
	Sun,  1 Feb 2009 16:37:55 +1300 (NZDT)
In-Reply-To: <7v63juzz9m.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.24.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107977>

On Sat, 2009-01-31 at 18:06 -0800, Junio C Hamano wrote:
> Nanako Shiraishi <nanako3@lavabit.com> writes:
> 
> > I assume that everybody, including the maintainer who is too heavyweight
> > and has too much inertia to accept too sudden a change of the course,
> > wants to eventually make the default to deny pushing to the current
> > branch. But I think such a change should come at 1.7.0 release at the
> > earliest, and a constructive thing to do is to put in a patch to 1.6.2
> > that helps the users with the eventual transition.
> 
> I am not opposed to eventually change the default to refuse at some point,
> but I have to say that now would not be the best time to do so.  Jeff's
> 986e823 (receive-pack: detect push to current branch of non-bare repo,
> 2008-11-08) that is v1.6.1-rc1~59^2 was the one we started warning about
> this, and we only had one major release since then, and I'd love to see a
> solid rc or even the final release by mid February.

Personally I think it's worth fast tracking, because I think very few
people are actually using push to a checked out branch whereas many
people are confused by the behaviour.  I just can't understand the
resistance to this safety feature.  People who encounter the bug can
just change the setting and move on... it seems like an argument based
on "principles", usually a sign that one has run out of actual
arguments..

> By the way, I do not appreciate other people who I have never met
> speculate about my body mass very much.  I am on the skinner end of the
> spectrum, if you need to know.

lol.  It was a metaphorical use of the term from my reading ;-)

Sam.
