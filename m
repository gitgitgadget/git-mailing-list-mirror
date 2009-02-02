From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Mon, 02 Feb 2009 20:00:35 +1300
Message-ID: <1233558035.20131.72.camel@maia.lan>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de>
	 <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
	 <76718490901300817x3f31460k59b6fe75d136372d@mail.gmail.com>
	 <alpine.DEB.1.00.0901301756560.3586@pacific.mpi-cbg.de>
	 <76718490901301050h1f0f5b2bq902de384d954d99b@mail.gmail.com>
	 <alpine.DEB.1.00.0901301959300.3586@pacific.mpi-cbg.de>
	 <20090131095622.6117@nanako3.lavabit.com>
	 <7v63juzz9m.fsf@gitster.siamese.dyndns.org>
	 <1233459475.17688.128.camel@maia.lan>
	 <7vbptlsuyv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 08:02:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTspB-00030p-Mw
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 08:02:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888AbZBBHBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 02:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbZBBHBE
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 02:01:04 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:39046 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627AbZBBHBD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 02:01:03 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 179FA21D97F; Mon,  2 Feb 2009 20:00:46 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 3118721D969;
	Mon,  2 Feb 2009 20:00:35 +1300 (NZDT)
In-Reply-To: <7vbptlsuyv.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.24.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108056>

On Sun, 2009-02-01 at 13:33 -0800, Junio C Hamano wrote:
> > I just can't understand the
> > resistance to this safety feature.  People who encounter the bug can
> > just change the setting and move on... it seems like an argument based
> > on "principles", usually a sign that one has run out of actual
> > arguments..
> 
> There is no resitance to any safety feature.  The resistance is to
> something entirely different.
  [...]
> Perhaps you already forgot the fiasco after 1.6.0, which moved tons of
> git-foo scripts out of the users' way.  It resulted in a better layout in
> the end, but we knew it would break people's working setup from the
> beginning.
  [...]

Yeah sure but the changes are a bit different aren't they.  One affected
all users who used the previously documented way to access subcommands
(and the names that the man pages all still retain).  The other affects
a small number of users who are doing something which is labeled in many
places as a bad thing to want to do.

That being said, I think I like the copy and design of the patch you
just posted.  If the path of caution is to be followed for this, then
the way you propose seems a good way to do it.

Sam
