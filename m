From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-send-email is omitting author and date lines
Date: Mon, 24 Sep 2007 11:43:29 -0700
Message-ID: <7vodfraoq6.fsf@gitster.siamese.dyndns.org>
References: <1190585633.29937.44.camel@localhost>
	<7v4phlc668.fsf@gitster.siamese.dyndns.org>
	<20070924110817.GA15797@lapse.madduck.net>
	<Pine.LNX.4.64.0709241209470.28395@racer.site>
	<20070924173014.GB27816@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Hanspeter Kunz <hp@edelkunz.ch>, git@vger.kernel.org
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Mon Sep 24 20:43:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZsuF-0006hP-G9
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 20:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755913AbXIXSnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 14:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755926AbXIXSnh
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 14:43:37 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:54815 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755598AbXIXSng (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 14:43:36 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 51C22139456;
	Mon, 24 Sep 2007 14:43:53 -0400 (EDT)
In-Reply-To: <20070924173014.GB27816@lapse.madduck.net> (martin f. krafft's
	message of "Mon, 24 Sep 2007 18:30:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59071>

martin f krafft <madduck@madduck.net> writes:

> also sprach Johannes Schindelin <Johannes.Schindelin@gmx.de> [2007.09.24.1210 +0100]:
>> And that is perfectly okay, since as far as the public is
>> concerned, this is the date of the patch.
>
> If you say so. I don't find this at all convincing.

I think that is the reasoning for the current behaviour of
send-email, but it is not unreasonable to have an option to
always add in-body From: and Date: headers to send-email, with a
blessing from a recent post from Linus to the kernel mailing
list:

	http://article.gmane.org/gmane.linux.kernel/582450

Notice the part he says he appreciates Andrew's practice and
talks about message being further forwarded by somebody else.
