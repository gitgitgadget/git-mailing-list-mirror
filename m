From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-diff: Add --staged as a synonym for --cached.
Date: Tue, 11 Nov 2008 16:57:21 -0800
Message-ID: <7v63mtu5fy.fsf@gitster.siamese.dyndns.org>
References: <1225296936-1357-1-git-send-email-dsymonds@gmail.com>
 <20081029164253.GA3172@sigill.intra.peff.net>
 <ee77f5c20810290950k6d7acfcbt90b6280c290bd532@mail.gmail.com>
 <alpine.DEB.1.00.0810291804400.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <20081029171122.GA12167@sigill.intra.peff.net>
 <20081102123519.GA21251@atjola.homenet>
 <7vljw2yo93.fsf@gitster.siamese.dyndns.org>
 <20081103071420.GD10772@coredump.intra.peff.net>
 <ee77f5c20811101537u6061e5b4w420e9692e0cefad3@mail.gmail.com>
 <7vljvr2hjn.fsf@gitster.siamese.dyndns.org>
 <20081111012210.GA26920@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Symonds <dsymonds@gmail.com>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 12 01:59:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L045C-0004tr-MB
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 01:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbYKLA6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 19:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbYKLA6S
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 19:58:18 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56643 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbYKLA6R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 19:58:17 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DEFB47C619;
	Tue, 11 Nov 2008 19:58:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 710957C60F; Tue,
 11 Nov 2008 19:57:28 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FB30F144-B054-11DD-877A-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100709>

Jeff King <peff@peff.net> writes:

> To me, what is really being asked with "git diff --staged" (or "git
> diff --cached" for that matter), is "what is staged?"

Ok, "what is staged (in index)?", relative to the named commit which
defaults to HEAD, is a good argument.  Let's apply it.
