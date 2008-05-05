From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cherry: add color to the output
Date: Sun, 04 May 2008 22:14:32 -0700
Message-ID: <7vlk2pnxhj.fsf@gitster.siamese.dyndns.org>
References: <1209751304-25304-1-git-send-email-richard.quirk@gmail.com>
 <20080505032718.GA15498@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Quirk <richard.quirk@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 05 07:15:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jst35-0000QU-Kp
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 07:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbYEEFOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 01:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752264AbYEEFOv
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 01:14:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38881 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbYEEFOv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 01:14:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B284C3785;
	Mon,  5 May 2008 01:14:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1C7553784; Mon,  5 May 2008 01:14:40 -0400 (EDT)
In-Reply-To: <20080505032718.GA15498@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 4 May 2008 23:27:18 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2F82A188-1A62-11DD-AEF0-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81231>

Jeff King <peff@peff.net> writes:

> On Fri, May 02, 2008 at 08:01:44PM +0200, Richard Quirk wrote:
>
>> If color.diff is set then patches not yet cherry-picked are marked green
>> and already picked ones are marked red. This makes it easier to tell at a
>> glance which changes have not been cherry-picked.
>
> I don't actually use git-cherry, so I can't say whether this is useful
> or not. But I wonder if it should follow the trend of other color
> options and get its own color.cherry variable, but also be controlled by
> the master color.ui.

I do not use git-cherry as Porcelain nor did I design it to be used as
such.  "color.cherry = always" would worry me but the user is asking for
trouble if he did so, so perhaps it is Ok.
