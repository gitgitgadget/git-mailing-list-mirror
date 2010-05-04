From: Junio C Hamano <gitster@pobox.com>
Subject: Re: new platform & S_IFGITLINK problem
Date: Tue, 04 May 2010 08:29:50 -0700
Message-ID: <7vwrvjofbl.fsf@alter.siamese.dyndns.org>
References: <1272756555.13488.1314.camel@jetpack.demon.co.uk>
 <7vfx2b2ft5.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1005032035310.5478@i5.linux-foundation.org>
 <alpine.LFD.2.00.1005032042470.5478@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alan Hourihane <alanh@fairlite.co.uk>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue May 04 17:30:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9K4a-0000zR-Io
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 17:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933466Ab0EDPaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 11:30:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52149 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933428Ab0EDPaA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 11:30:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 68811B0FBE;
	Tue,  4 May 2010 11:29:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LqTGQXPEftFwPEpTXn1HFNlTXJc=; b=kNenqG
	0mVjfJ70ddWtnopran4krk4bcAV9Qpbri7pxqAwElcLw6doCgF+ahKTlEDeX6KBD
	tLqDBqSrGi8VNJBobN7srxdxuoM1H3TvIXCz8eTzw4qchEH16YBjY2bSN/0Myu8f
	4EbYMQ67WQ9tBhhxG2jto/cnAxe3eY6XZPil4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qHae7XbjNTiqWSALqh/tP5ylYrDO1YPZ
	QXqznxt0eP4Zym7BnXs1+fqMxehjWF8Vfpjq2UN3xv7yFRrRFEodZgb00dX/m4QI
	86yF0OU5PIhtmQ6IDo2JN6mXmitYCBqbwDbrA95+otkVbTZqh6LKKUjMB4qMUG1t
	ADZaQ2PHbzM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 332C0B0FBA;
	Tue,  4 May 2010 11:29:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 71948B0FB4; Tue,  4 May
 2010 11:29:52 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.1005032042470.5478@i5.linux-foundation.org>
 (Linus Torvalds's message of "Mon\, 3 May 2010 20\:52\:31 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E49AED64-5791-11DF-994F-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146317>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I've actually wanted to have a 'git_lstat()' wrapper for other reasons: it 
> would have made it _so_ much easier to do breakpoints etc when doing the 
> whole name lookup optimizations. 

Yes, I would imagine that canonicalized utf-8, windows codepages and other
screw-ups can be dealt with easier with such a wrapper as well.
