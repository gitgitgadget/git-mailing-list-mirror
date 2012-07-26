From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Test "t/t7502-commit.sh" failed
Date: Thu, 26 Jul 2012 13:04:58 -0700
Message-ID: <7v4nou70gl.fsf@alter.siamese.dyndns.org>
References: <CANYiYbHbMw1HpvoCr4yBbWF=Q9Hoc1Zsq3-WoTrx4aQg7R0e4g@mail.gmail.com>
 <20120726130348.GA965@sigill.intra.peff.net>
 <7vtxwu8orw.fsf@alter.siamese.dyndns.org>
 <20120726171256.GC13942@sigill.intra.peff.net>
 <7v8ve672ar.fsf@alter.siamese.dyndns.org>
 <20120726193359.GA28711@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 26 22:05:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuUJ7-00084T-9N
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 22:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305Ab2GZUFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 16:05:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54878 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751678Ab2GZUFD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 16:05:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C49EA9DDF;
	Thu, 26 Jul 2012 16:05:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7AXUX1/vMiNQV3+3UnrL/FeO7kk=; b=SjAda0
	WmcFHI6w0+IDPe7gCEo5nrJ6GBMalgFZ6bM8ffLrkrvDa0LMzXV+AQb5DWqxLz+z
	yypjiS/HR1LwJRqAfCaZ//cKHsjeyevzImxwtdSICpp7G4Ak/iWH3LXHEEchj3oH
	CZX+shcDDtTFZ6jw1wDmYpavlSIv+6E8WY5Zc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C1OxVGxR9nyYfVzlcnbngMoKREhLU5vP
	XYLJrtphwuiZLowO1L/6AorLOOavfpZ0cH/0Y9MftOIXjgaHCNDN8X6sX7yHYJ5L
	FClCOQA4BwLY8OLJKT+8Dm7/tq0qazC9o5/7izkjUJHRV0KsUoALrZSR3V2NkCrQ
	tvRxRzD83ME=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B261E9DDE;
	Thu, 26 Jul 2012 16:05:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3023F9DDC; Thu, 26 Jul 2012
 16:05:00 -0400 (EDT)
In-Reply-To: <20120726193359.GA28711@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 26 Jul 2012 15:33:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E0843D2-D75D-11E1-9EFC-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202299>

Jeff King <peff@peff.net> writes:

> Yes, and they are given that chance. This is not about the behavior of
> git, but about stupid assumptions by the test.

OK.

> I'm close to finished with a series that I think will at least make it
> better. Stay tuned.

;-)
