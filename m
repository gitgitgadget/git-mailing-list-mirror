From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git sideband hook output
Date: Fri, 11 Jun 2010 16:52:46 -0700
Message-ID: <7v631pgm9d.fsf@alter.siamese.dyndns.org>
References: <AANLkTinLWDFTn7bhcF3Vk-q9aw4lJC2vFj95M9bxLbBT@mail.gmail.com>
 <20100608214632.GN14847@spearce.org>
 <A612847CFE53224C91B23E3A5B48BAC744839BF3DD@xmail3.se.axis.com>
 <alpine.LFD.2.00.1006090934320.30664@xanadu.home>
 <A612847CFE53224C91B23E3A5B48BAC744839BF6AE@xmail3.se.axis.com>
 <20100610183019.GR14847@spearce.org>
 <AANLkTikQQh4sUA7h2k1jvQ7aMgYyq7WFetJvJZvqpVxt@mail.gmail.com>
 <AANLkTikYBB1DsGRRsu4pSNr1j8fFXD-99c4lRAaBqd3M@mail.gmail.com>
 <3B9F4351-4608-455E-B433-A5337A946F8A@wincent.com>
 <AANLkTimPI-A_4H-vYtHIyfbSLERDo0vu-kbB3Qu3ZT06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>, PJ Hyett <pjhyett@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	git list <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sat Jun 12 01:53:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONE2D-0006Hp-C1
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 01:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760250Ab0FKXxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 19:53:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53907 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760229Ab0FKXxG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 19:53:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A5337BB2A8;
	Fri, 11 Jun 2010 19:53:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=7FuI3EszgLXqxOfA/xLR+H3HmpM=; b=AxH+Aflm8QEYrfboo+Kp0/N
	1xFEZujKZ0WT7XY0W3bl3fTZRpqcTI9egeCwkglZCWgJEb6P8u14OEZCqGiinb/5
	JU9UemodpQ42C52UQR2QEbdoLzJg3fn714Yna3cRdDOV5puLrFhSYZu5EcZHmXK9
	CKBQ8JHJfAlergc9BXeM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=micLjIUbjD72wwNu98C5+5nc2cob8WGtWe231rDBELZNMbR2T
	7WML7RpLLOrnX4DfXX3EQTTzhihDCz1Ce0Lpz1c41/W5CZ+E+MjlvCNekyPfCNux
	dt38OL2vQyhmwuii6Y4UYvYmQg64k3DHB1GtC/M28dLdK+zZ7WQl+dtqyw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C9E0ABB29F;
	Fri, 11 Jun 2010 19:52:56 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67463BB293; Fri, 11 Jun
 2010 19:52:47 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 755C7A62-75B4-11DF-A65E-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148978>

Erik Faye-Lund <kusmabite@googlemail.com> writes:

>> Funny, as '>>' is basically meaningless. At least 'remote:' has semantic value (ie. it indicates _where_ something is coming from).
>
> How about '> ', which often means "quote" (e.g in e-mails)? Would that
> be appropriate?

Not much better, IMNSHO.  Where do people get the idea that line-noises
are more descriptive than "remote:"?
