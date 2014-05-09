From: David Kastrup <dak@gnu.org>
Subject: Re: Output from "git blame A..B -- path" for the bottom commit is misleading
Date: Fri, 09 May 2014 07:04:05 +0200
Message-ID: <87zjiro856.fsf@fencepost.gnu.org>
References: <xmqq8uqc2dt5.fsf@gitster.dls.corp.google.com>
	<20140508212647.GA6992@sigill.intra.peff.net>
	<874n10ot2m.fsf@fencepost.gnu.org>
	<20140509001145.GA8734@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 09 09:22:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wif8e-0004Em-Th
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 09:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526AbaEIHWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 03:22:33 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:49764 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbaEIHWc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 03:22:32 -0400
Received: from localhost ([127.0.0.1]:48803 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1Wif8Z-0002Xw-BX; Fri, 09 May 2014 03:22:31 -0400
Received: by lola (Postfix, from userid 1000)
	id C928BE0A47; Fri,  9 May 2014 07:04:05 +0200 (CEST)
In-Reply-To: <20140509001145.GA8734@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 8 May 2014 20:11:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248522>

Jeff King <peff@peff.net> writes:

> I'd actually be inclined to say the opposite of what Junio is saying
> there: that "-b" should blank the author field as well as the commit
> sha1. I'd even go so far as to say that "-b" should probably be the
> default when boundary commits are in use. I cannot think of a time when
> I have found the boundary information useful, and the IMHO the output
> above is less confusing than what we produce now. But I admit I haven't
> thought very hard on it.

Arguably if the user explicitly limited the range, he knows what he's
looking at.  Admittedly, I don't know offhand which options _will_
produce boundary commit indications: there may be some without explicit
range limitation, and we might also be talking about limiting through
shallow repos (git blame on a shallow repo is probably a bad idea in the
first place, but anyway).

-- 
David Kastrup
