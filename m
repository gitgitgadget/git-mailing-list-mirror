From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] handle color.ui at a central place
Date: Thu, 22 Jan 2009 22:13:40 -0800
Message-ID: <7vmydi4kiz.fsf@gitster.siamese.dyndns.org>
References: <20090117153846.GB27071@coredump.intra.peff.net>
 <200901212335.24727.markus.heidelberg@web.de>
 <20090122000026.GB9668@sigill.intra.peff.net>
 <200901220113.32711.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Fri Jan 23 07:15:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQFKa-0000bx-3C
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 07:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbZAWGOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 01:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbZAWGOE
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 01:14:04 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54801 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbZAWGOD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 01:14:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5B13C9302C;
	Fri, 23 Jan 2009 01:13:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BE84793018; Fri,
 23 Jan 2009 01:13:42 -0500 (EST)
In-Reply-To: <200901220113.32711.markus.heidelberg@web.de> (Markus
 Heidelberg's message of "Thu, 22 Jan 2009 01:13:32 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FF588B80-E914-11DD-8CD8-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106837>

Markus Heidelberg <markus.heidelberg@web.de> writes:

> Jeff King, 22.01.2009:
> ...
>> > ...
>> > That would probably be better.
>> 
>> Do you want to work on it, or should it go into the "yeah, right, one
>> day" section of my todo list?
>
> Yes, feel free to enlarge your todo list :)
> There are some other things that I want to work on before, so better
> don't count on me for this. But maybe I'll come up to it, before your
> todo list pointer reaches this item, who knows.

Whatever.

I merged and pushed out these two patches but they seem to break
format-patch big time if you have ui.color set to auto.

I will be reverting them out of 'next'.  Grumble.
