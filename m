From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] reflog: remove i18n legos in pruning message
Date: Thu, 31 May 2012 10:56:10 -0700
Message-ID: <7vlik86xqd.fsf@alter.siamese.dyndns.org>
References: <1338463242-10618-1-git-send-email-worldhello.net@gmail.com>
 <1338469482-30936-1-git-send-email-pclouds@gmail.com>
 <1338469482-30936-3-git-send-email-pclouds@gmail.com>
 <20120531134538.GA10523@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 31 19:56:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa9c7-0001f1-S1
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 19:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757684Ab2EaR4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 13:56:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48688 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757608Ab2EaR4N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 13:56:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B6FD81A6;
	Thu, 31 May 2012 13:56:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d0oIj7vzDY4dMKHg9jqAn6pBXaY=; b=sc7Qpt
	nUEOCa/5w1AGYhikrLfafu8v2RsuTbNwz36cgXr4fgxP+IA8QVc7vweCGBZ+qgZC
	fhLyV+uxGTYl3yTzn4V48OodPzfACzMO8WAcdKGzTRmVI2CTsM4YeMCdUEiA+gxZ
	/45d6TAlKdIE7feXeRiVBR2aEYI4YptvhFkH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vxqDy+dt0LtZzvLZciX+XFJ8blp2WrVS
	H+vWnxv/cEeWr5OfSL20vces6NA8ZWtBVz7rbUcdT22VUms83EGyIYcEPP3YtRB0
	a30EJ0cubpCqQIOuhEVgghKFpJ/fc9EIOJ+w3HeMaOWkluw2bdg/EkNEaseIV7N5
	BP8ARXrKmVM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 826E281A5;
	Thu, 31 May 2012 13:56:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 15B4481A3; Thu, 31 May 2012
 13:56:11 -0400 (EDT)
In-Reply-To: <20120531134538.GA10523@burratino> (Jonathan Nieder's message of
 "Thu, 31 May 2012 08:45:38 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8970570-AB49-11E1-83E6-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198931>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Thanks.  Style: how about
>
> 	if (!cb->newlog)
> 		printf("would prune %s", message);
> 	else if (cb->cmd->verbose)
> 		printf("prune %s", message);
>
> ?  I think that would be more readable than the lego original.

That is very much more preferred.

> BTW I'm not sure if this message would be a good candidate for
> translation.

These are for human consumption; they used to go to standard error
stream back when it was written at 4264dc1 (git reflog expire,
2006-12-19).
