From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-add -a: add all files
Date: Sun, 20 Jul 2008 17:06:41 -0700
Message-ID: <7vprp814oe.fsf@gitster.siamese.dyndns.org>
References: <7vtzeofjpi.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807171940160.8986@racer> <48806897.1080404@fastmail.fm>
 <76718490807181318o228171f9j836aaca2edb9b377@mail.gmail.com>
 <7vsku5grpr.fsf@gitster.siamese.dyndns.org>
 <7vk5fhgrm6.fsf_-_@gitster.siamese.dyndns.org>
 <905315640807192120k45b8c0e3k5b341e77c466dde@mail.gmail.com>
 <alpine.DEB.1.00.0807201250530.3305@eeepc-johanness>
 <76718490807200545l653bbda1l4d13f1e1e698c855@mail.gmail.com>
 <7v4p6k8l36.fsf@gitster.siamese.dyndns.org>
 <20080720235933.GA12454@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tarmigan <tarmigan+git@gmail.com>, git@vger.kernel.org,
	Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 21 02:08:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKiwq-0006ab-60
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 02:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758624AbYGUAGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 20:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758615AbYGUAGx
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 20:06:53 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63111 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758616AbYGUAGw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 20:06:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id AF5E334D59;
	Sun, 20 Jul 2008 20:06:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2360534D57; Sun, 20 Jul 2008 20:06:42 -0400 (EDT)
In-Reply-To: <20080720235933.GA12454@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 20 Jul 2008 19:59:33 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EAF8250E-56B8-11DD-A53F-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89271>

Jeff King <peff@peff.net> writes:

> But again, I haven ever felt the lack of this feature; such usage for me
> always goes in scripts, where I am more than happy to write out "add .
> && add -u && commit".

The reason we did not have such "feature" so far was not because somebody
high in the git foodchain was opposed to the idea, but simply because
nobody came up with a usable patch to do so.

I do not have anything fundamentally against "add -A" nor "commit -A".  To
me, this is in "perhaps nice to have for some people, but I would not use
it myself and I wouldn't bother" category, not in "I'm opposed -- it would
promote bad workflow" cateogry.
