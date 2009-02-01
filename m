From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Sat, 31 Jan 2009 18:06:45 -0800
Message-ID: <7v63juzz9m.fsf@gitster.siamese.dyndns.org>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de>
 <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
 <76718490901300817x3f31460k59b6fe75d136372d@mail.gmail.com>
 <alpine.DEB.1.00.0901301756560.3586@pacific.mpi-cbg.de>
 <76718490901301050h1f0f5b2bq902de384d954d99b@mail.gmail.com>
 <alpine.DEB.1.00.0901301959300.3586@pacific.mpi-cbg.de>
 <20090131095622.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Feb 01 03:11:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTRoH-0002MX-Gz
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 03:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbZBACGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 21:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752042AbZBACGy
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 21:06:54 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49239 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbZBACGy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 21:06:54 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 37C0195A2E;
	Sat, 31 Jan 2009 21:06:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 70BAC95A28; Sat,
 31 Jan 2009 21:06:47 -0500 (EST)
In-Reply-To: <20090131095622.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Sat, 31 Jan 2009 09:56:22 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FE64C1DE-F004-11DD-91B1-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107970>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> I assume that everybody, including the maintainer who is too heavyweight
> and has too much inertia to accept too sudden a change of the course,
> wants to eventually make the default to deny pushing to the current
> branch. But I think such a change should come at 1.7.0 release at the
> earliest, and a constructive thing to do is to put in a patch to 1.6.2
> that helps the users with the eventual transition.

I am not opposed to eventually change the default to refuse at some point,
but I have to say that now would not be the best time to do so.  Jeff's
986e823 (receive-pack: detect push to current branch of non-bare repo,
2008-11-08) that is v1.6.1-rc1~59^2 was the one we started warning about
this, and we only had one major release since then, and I'd love to see a
solid rc or even the final release by mid February.

By the way, I do not appreciate other people who I have never met
speculate about my body mass very much.  I am on the skinner end of the
spectrum, if you need to know.
