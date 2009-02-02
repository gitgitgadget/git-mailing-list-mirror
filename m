From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] add -p: prompt for single characters
Date: Mon, 02 Feb 2009 00:50:16 -0800
Message-ID: <7vljspjk8n.fsf@gitster.siamese.dyndns.org>
References: <1233520511-13061-1-git-send-email-trast@student.ethz.ch>
 <cfbcd2f00902011931h48ef51a4n9badbed9051879ca@mail.gmail.com>
 <200902020934.06128.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Suraj Kurapati <sunaku@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 02 09:52:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTuX3-0004oh-44
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 09:51:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbZBBIu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 03:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbZBBIu0
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 03:50:26 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50572 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbZBBIu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 03:50:26 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 24ADD95680;
	Mon,  2 Feb 2009 03:50:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 350219567D; Mon,
  2 Feb 2009 03:50:17 -0500 (EST)
In-Reply-To: <200902020934.06128.trast@student.ethz.ch> (Thomas Rast's
 message of "Mon, 2 Feb 2009 09:34:02 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 87CC1006-F106-11DD-B6EF-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108074>

Thomas Rast <trast@student.ethz.ch> writes:

> Suraj Kurapati wrote:
>> On Sun, Feb 1, 2009 at 12:35 PM, Thomas Rast <trast@student.ethz.ch> wrote:
>> >  http://thread.gmane.org/gmane.comp.version-control.git/100146
>> >
>> > I can't find the v4 promised there, so I assume Suraj dropped it.
>> 
>> Yes, I lost the motivation to develop the patch any further.  Sorry.
>
> Ok.
>
> I see Junio has already merged wp/add-patch-find, so I'll rebuild on
> top of that and see what needs to be changed.

This is not a very high priority request, but I personally find the prompt
sitting there until I type Enter somewhat assuring, because I often think,
type "y", think again, and then finally type "Enter".

I'd appreciate if you can allow this "single stroke" mode to be optionally
turned off by the end user.
