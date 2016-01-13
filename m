From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: loosen config globs limitations
Date: Wed, 13 Jan 2016 10:45:57 -0800
Message-ID: <xmqqlh7tnwre.fsf@gitster.mtv.corp.google.com>
References: <1452522358-16943-1-git-send-email-vleschuk@accesssoftek.com>
	<20160113031601.GA28224@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Victor Leschuk <vleschuk@gmail.com>, git@vger.kernel.org,
	vleschuk@accesssoftek.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jan 13 19:46:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJQQo-0003CA-2p
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 19:46:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925AbcAMSqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 13:46:01 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59885 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753869AbcAMSqA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 13:46:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 838283AD89;
	Wed, 13 Jan 2016 13:45:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EAEgrn9Zik4KnxS9nvao4TNB9Jg=; b=R/t4dZ
	Qd5w0s53F7w0tfWps51q9rpf5Lqee5gBENT9n+VTDRos/FwpJxbCJ2O/VV7O3Met
	pWhWZgiBO8fgn+pGfEvqsqFOKAAYMNFoQeWlG2sVOpI5EdW9bBBIRUOibj/jsOUy
	FznO4tNZB/9JnwSttNVf3Xs8TeVyrJMoMN3Gw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pz+Ou0NbHGyHz+0judVrbKInX3B8EcIH
	15kb72CB9MWk+Ygmom9J7mureNXqEYe7cs2ceNy1lkOWv3xB2+2fCStOYP6J46NF
	u+fpdjdSsBBUfZqmGuPi1gEFkWC+kn4QX9HmpUVQXejZzBqFghkvB/8JgIRUVAK2
	5qOomp4pbaY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7A50B3AD83;
	Wed, 13 Jan 2016 13:45:59 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EB6003AD81;
	Wed, 13 Jan 2016 13:45:58 -0500 (EST)
In-Reply-To: <20160113031601.GA28224@dcvr.yhbt.net> (Eric Wong's message of
	"Wed, 13 Jan 2016 03:16:01 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E301F892-BA25-11E5-8329-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283964>

Eric Wong <normalperson@yhbt.net> writes:

> Thanks, I made a minor cleanup and applied with --whitespace=fix
> to remove spaces from indentation.
> ...
> I also noticed the "Only one set of wildcard directories" error
> message is unnecessary long and "wildcard directories" should
> probably be shortened to "wildcards" to avoid wrapping in a terminal.
> That will probably be a separate patch for me.

Should I pull something from you now from 'master' at your
bogomips.org repository?  I do not mind (and actually I would
prefer) waiting until I hear a go ahead, which would let you work on
your own changes before I pull.

Thanks.
