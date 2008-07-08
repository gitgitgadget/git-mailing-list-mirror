From: Junio C Hamano <gitster@pobox.com>
Subject: Re: error: unlink(.git/refs/remotes/origin/testbranch) failed: was
 remote does not support deleting refs
Date: Tue, 08 Jul 2008 13:04:20 -0700
Message-ID: <7v7ibwta63.fsf@gitster.siamese.dyndns.org>
References: <486FE602.3060301@gmx.de> <48700FC2.8080307@gmx.de>
 <37fcd2780807061134l341ac676ueb674a976ce15e6f@mail.gmail.com>
 <20080708040801.GA7186@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>, Martin <html-kurs@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 08 22:06:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGJRk-0000n8-6P
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 22:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748AbYGHUEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 16:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755181AbYGHUEg
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 16:04:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57028 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475AbYGHUEf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 16:04:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 587AE14A15;
	Tue,  8 Jul 2008 16:04:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 875A114A0C; Tue,  8 Jul 2008 16:04:25 -0400 (EDT)
In-Reply-To: <20080708040801.GA7186@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 8 Jul 2008 00:08:02 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1479A46E-4D29-11DD-AA8D-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87796>

Jeff King <peff@peff.net> writes:

> It is harmless, but it still feels a little wrong to scare the user with
> that message, especially since "Failed to delete" is ambiguous; it looks
> like the main operation, deleting the remote ref, failed. But it didn't;
> the operation that failed was something not even explicitly asked for.
>
> How about this cleanup:

Ack.
