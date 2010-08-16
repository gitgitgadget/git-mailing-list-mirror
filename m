From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problem in pushing git
Date: Mon, 16 Aug 2010 09:30:15 -0700
Message-ID: <7vlj86cyg8.fsf@alter.siamese.dyndns.org>
References: <49AB8B4F.90006@providencesl.com>
 <1281974115868-5428361.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bruno Furtado <brunofurtado@brunofurtado.net>
X-From: git-owner@vger.kernel.org Mon Aug 16 18:31:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ol2aj-0005Rq-EQ
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 18:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754926Ab0HPQaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Aug 2010 12:30:23 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38237 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754690Ab0HPQaW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 12:30:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D89C8CDBB0;
	Mon, 16 Aug 2010 12:30:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=37S1Bc1eYXPX9tlS4I7ExM9biq8=; b=lubTX7
	fRoEKv3ssnKaTBY8Aon1AUhxUmJvPFxtG8XW0jILxnn3mbIpFjHD1k2gAnN0FLvf
	LT+ZpdLcuPrI7Hm7yUkUVmMkst/4BlNNEO/bG+7bPe3A7wCgo+XjtF+0tW+3HqNH
	ib8BFlNgTWJQbtiXBVKVCADPbaHDg0j9nvnH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o310wHtzp7Nir/oHQ4pO1rf7bcdTo+BJ
	ufVUEtnv73gC6nxWvy1vhqirdOp+farLdcb+jlxeiA0r8zyafDu5Al9pzSR59wO0
	ogNS0LAGnqkq+jjXJ4x1i914/ubPNREXOOBxBBHnpvgZXoHeHC0GFIaeyIC6HH4I
	V+s6+gZCADA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B5989CDBAF;
	Mon, 16 Aug 2010 12:30:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21826CDBAB; Mon, 16 Aug
 2010 12:30:16 -0400 (EDT)
In-Reply-To: <1281974115868-5428361.post@n2.nabble.com> (Bruno Furtado's
 message of "Mon\, 16 Aug 2010 08\:55\:15 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8F5EEA08-A953-11DF-B112-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153661>

Bruno Furtado <brunofurtado@brunofurtado.net> writes:

> I'm have the same problem. I didn't found this solution in 
> https://git.wiki.kernel.org/index.php/GitFaq Git FAQ 

I wonder if this is what you two are talking about...

https://git.wiki.kernel.org/index.php/GitFaq#Why_won.27t_I_see_changes_in_the_remote_repo_after_.22git_push.22.3F
