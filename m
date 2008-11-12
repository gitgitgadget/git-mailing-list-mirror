From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-diff: Add --staged as a synonym for --cached.
Date: Wed, 12 Nov 2008 11:57:53 -0800
Message-ID: <7vbpwkogxq.fsf@gitster.siamese.dyndns.org>
References: <20081102123519.GA21251@atjola.homenet>
 <7vljw2yo93.fsf@gitster.siamese.dyndns.org>
 <20081103071420.GD10772@coredump.intra.peff.net>
 <32541b130811102004n54a47331v48ba8d299039897f@mail.gmail.com>
 <20081112083353.GB3817@coredump.intra.peff.net>
 <alpine.DEB.1.00.0811121205100.30769@pacific.mpi-cbg.de>
 <20081112110629.GA20473@coredump.intra.peff.net>
 <32541b130811120739t95455d8n9b8056a8033491c3@mail.gmail.com>
 <20081112191512.GA21401@coredump.intra.peff.net>
 <7vljvooi8w.fsf@gitster.siamese.dyndns.org>
 <20081112193747.GA21567@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 12 21:00:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0Lso-0001P8-Lk
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 21:00:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763AbYKLT6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 14:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752636AbYKLT6y
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 14:58:54 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37924 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604AbYKLT6y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 14:58:54 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BDF9816889;
	Wed, 12 Nov 2008 14:58:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id ADC5B16887; Wed, 12 Nov 2008 14:57:56 -0500 (EST)
In-Reply-To: <20081112193747.GA21567@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 12 Nov 2008 14:37:47 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 53563F1A-B0F4-11DD-81B2-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100812>

Jeff King <peff@peff.net> writes:

> I'm not sure I agree. They _are_ different things, but in the case of
> diff, you are really treating each of them like a tree (which makes
> range operators a little silly, but then that is a silliness already
> present in "git diff tree1..tree2").

It is not _little_ silly, but quite silly.  It is a historical accident
and I personally suggest against using it when I teach git to others.

And we are _not_ treating each of them like a tree.  We might be treating
them as collection of paths (and the range operator is about commits).

> But again, I would not be convinced this is a good direction until I
> saw:
> ...
> And I'm still not volunteering to work on it, so somebody else will have
> to come up with those things. ;)

Even if they would, I do not think it is a good direction to go.  It makes
the UI less intuitive and harder to learn.
