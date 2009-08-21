From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add support for the Mongoose web server.
Date: Fri, 21 Aug 2009 00:49:13 -0700
Message-ID: <7vvdkhip3a.fsf@alter.siamese.dyndns.org>
References: <bc9549a50908202339h61525d3fo23199313cabe25e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wilhansen Li <wil@nohakostudios.net>
X-From: git-owner@vger.kernel.org Fri Aug 21 09:49:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeOsL-0005E9-R5
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 09:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754883AbZHUHtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 03:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754880AbZHUHtV
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 03:49:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52884 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366AbZHUHtU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 03:49:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9928D31608;
	Fri, 21 Aug 2009 03:49:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A2ifJ5UqEOJpSZEfM9eG/RKDedU=; b=ZgqRDe
	y0SlkqJYsHHOKtXj1PeLi0QZj0Fd1XEonURWFR2W1MQPqtXNMgK14QuPGn1kerp6
	htXaPMmXCdtTlQlXoNNO+8HwgvdDK1su171O6pztcanG+oKJ51icHcu3oKb9UtE0
	tvV7SMattCWGVM14ONFsMPDp7K+EBqJs3XWfU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TxAjfNeWJqVC+uuzIrlAG/uJ+gXl4/4M
	r2JbpuQHDa9VQc2EvU9Iw51KTWMuzAFMpI952hXhJgxsy/GQW6LwT2cLqy9y17K3
	pwZ/ZlrwecIwJHcofj2W3ItcnGqeRrbWcb3Sp3LDRu3Lxq4VFTFX8vFtBbN8wJz3
	Ipgv7UzWOZ8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7D21631606;
	Fri, 21 Aug 2009 03:49:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7E85931605; Fri, 21 Aug 2009
 03:49:15 -0400 (EDT)
In-Reply-To: <bc9549a50908202339h61525d3fo23199313cabe25e5@mail.gmail.com>
 (Wilhansen Li's message of "Fri\, 21 Aug 2009 14\:39\:05 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2180EF56-8E27-11DE-8724-3142836986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126691>

Thanks.

You would need to also update Documentation/git-instaweb.txt.  Grep for
"lighttpd" or "webrick" to find where you would want to add mention of
their new friend.
