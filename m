From: Junio C Hamano <gitster@pobox.com>
Subject: Re: multiple-commit cherry-pick?
Date: Thu, 06 Nov 2008 21:00:46 -0800
Message-ID: <7vskq4gmf5.fsf@gitster.siamese.dyndns.org>
References: <buoiqr18tdk.fsf@dhapc248.dev.necel.com>
 <20081106213711.GA4334@blimp.localdomain>
 <alpine.LFD.2.00.0811061925300.3451@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 07 06:02:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyJUg-0007pU-7v
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 06:02:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbYKGFBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 00:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbYKGFBH
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 00:01:07 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59073 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbYKGFBG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 00:01:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1C0EB7A743;
	Fri,  7 Nov 2008 00:01:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8D1F87A742; Fri,
  7 Nov 2008 00:00:52 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0811061925300.3451@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Thu, 6 Nov 2008 19:29:04 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 14D59A16-AC89-11DD-8EED-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100286>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 6 Nov 2008, Alex Riesen wrote:
>> 
>> git format-patch --full-index --binary --stdout <range...> | git am -3
>> 
>> This will not work if you want to pick a list, not a range, of
>> commits.
>
> Doesn't "--no-walk" + list commits individually work?
>
> So it _should_ be possible to pick a list of commits too. Although I think 
> that git format-patch will reverse the order.

Or "git show --pretty=email $commit1 $commit2" ... piped to "am"?
