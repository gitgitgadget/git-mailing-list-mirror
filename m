From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/3] git-remote-fd
Date: Wed, 06 Oct 2010 22:55:35 -0700
Message-ID: <7v7hhuy2aw.fsf@alter.siamese.dyndns.org>
References: <1286190258-12724-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1286190258-12724-3-git-send-email-ilari.liusvaara@elisanet.fi>
 <20101004112556.GD4738@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 07:55:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3jSM-0000Rn-Mw
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 07:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369Ab0JGFzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 01:55:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47860 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754396Ab0JGFzp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 01:55:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AAC7DCF77;
	Thu,  7 Oct 2010 01:55:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=0Un+CpL+tI9a7qZagt8969Vodco=; b=qrx32UjSnA8BGwTQHsJGHWk
	8HxHEIXJRDHl0Z7aTkibOmMNIOtZR204cF855KFcztv4lo9U6pVrhjNZJAPmBdzG
	x5bNvp8KLa3BeJug4nEgQj0XWWGBzwHXEOACcR/3t2Rr+lug4iWf2PYlfPVkqnYe
	cbY8fQy7V7L2aYadNfo0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=ZhQJ3Fxh1KCjisH68bbtvtOeEIQwG+OgwSZUGNxlpLpG1A+oe
	4IEaL4yj1dlxXxK1tuRED1pa6PvZkrpWnbWUdmXviK52doW6fkjuNcdi4x1AnVsB
	2DevHU1B7hWu89xW1YmUlVYxh1FEN66BP89mZCg3q/0TNOZltN7WEeJw9k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DB85BDCF73;
	Thu,  7 Oct 2010 01:55:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E104DCF6E; Thu,  7 Oct
 2010 01:55:36 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 84AFF708-D1D7-11DF-B537-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158374>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Looks good.  Probably input_fd and output_fd should be static ---
> Junio, can you fix that up?  And now that the documentation makes it
> clear this is only for fetch, push, and archive, I guess I am not so
> worried about the interface any more.

Done, unfortunately along with quite a lot of style violation fixes...
