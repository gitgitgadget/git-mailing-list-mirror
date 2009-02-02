From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Mon, 02 Feb 2009 00:32:30 -0800
Message-ID: <7v1vuhkzmp.fsf@gitster.siamese.dyndns.org>
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
 <1233558035.20131.72.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Mon Feb 02 09:34:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTuFv-0007vj-5p
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 09:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbZBBIcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 03:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbZBBIco
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 03:32:44 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47919 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbZBBIco (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 03:32:44 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A845E9557D;
	Mon,  2 Feb 2009 03:32:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C93679557C; Mon,
  2 Feb 2009 03:32:32 -0500 (EST)
In-Reply-To: <1233558035.20131.72.camel@maia.lan> (Sam Vilain's message of
 "Mon, 02 Feb 2009 20:00:35 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0D534288-F104-11DD-89ED-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108069>

Sam Vilain <sam@vilain.net> writes:

> The other affects
> a small number of users who are doing something which is labeled in many
> places as a bad thing to want to do.

Sorry, but I do not agree with this.

What is bad is to push into a repository that is used for editing.  That
is labelled as a bad thing to want to do.

It is often the easiest to push and then run "reset --hard" (perhaps from
the post-update script) to propagate your change to a repository that is
not usually used for editing.  E.g. that has always been the way I update
my private repository at k.org that I use for final testing before pushing
out the results that I built and tested on my personal machine.  People
who have live web pages served from a checkout do that, too.  It is not a
bad thing to do at all, and you can find many instructions with google
without spending a lot of time to do exactly that.

    http://kerneltrap.org/mailarchive/git/2008/7/1/2315924
    http://utsl.gen.nz/git/post-update
    http://groups.google.com/group/sl-ugr/browse_thread/thread/04e4c4bd6ce174af
