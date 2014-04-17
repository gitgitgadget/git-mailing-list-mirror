From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/4] Submodules: Add the lib-submodule-update.sh test library
Date: Thu, 17 Apr 2014 12:23:08 -0700
Message-ID: <xmqq38hbep5v.fsf@gitster.dls.corp.google.com>
References: <5331B6F6.60501@web.de> <5331B741.6000606@web.de>
	<20140417164138.GP21805@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder p <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Apr 17 21:23:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Waru3-0001TQ-Dy
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 21:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbaDQTXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 15:23:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47470 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139AbaDQTXM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 15:23:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE46D7BBC4;
	Thu, 17 Apr 2014 15:23:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ytYngLgq8etVFT7CiJN/EXiBV6Y=; b=O5946R
	t9hlhZxrnr5wa3Qn5m8FIImUFMy4bgnlmTI+GWUR2oP+njTzU8VUhyziqCi9nZ4E
	TTn+2JMk0Vtdr2eu/MdPFtzSdXvb1ir+eW+vwYNWwr/hGqC8D8USi6+6MfhhHxYY
	Zq5xsMIZIS5XoFPZTV2RlUyaPt01r9/eJjEOI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l6OB4O9m9o1cblap5pro4hxeqTqBjuPu
	Rl1vebc2iRii7gjMBDNO4mPZ1ojA9QNer1Gdj+Ihk2sCSM6nBVvT9FFmdtPKWj+K
	rnbZ8jSwpQQyPd+vpddg/8runqjPqpJXIML2Iv3x+r29w9WwKe8VB7tNSGmYMflG
	8/GgWcNZ69M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC3EF7BBC3;
	Thu, 17 Apr 2014 15:23:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2202F7BBC2;
	Thu, 17 Apr 2014 15:23:10 -0400 (EDT)
In-Reply-To: <20140417164138.GP21805@odin.tremily.us> (W. Trevor King's
	message of "Thu, 17 Apr 2014 09:41:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B63467A6-C665-11E3-B381-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246435>

"W. Trevor King" <wking@tremily.us> writes:

> There have been a number of submodule series in
> flight recently, and I'm having trouble keeping track of them all ;).

Unfortunately I share that same feeling X-<.

Could you guys collectively summarize what issues each of these
in-flight topics try to address and how, how close it is to achieve
concensus, and how it interact with other proposed topics?

Thanks.
