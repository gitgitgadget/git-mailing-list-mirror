From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Change configure to check if pthreads are usable without
 any extra flags
Date: Mon, 09 Jul 2012 15:38:47 -0700
Message-ID: <7vd344k1ag.fsf@alter.siamese.dyndns.org>
References: <1341529386-11589-1-git-send-email-max@quendi.de>
 <7vk3ydkmzq.fsf@alter.siamese.dyndns.org>
 <C56B4151-8912-4B3A-8A97-E769A878AE68@quendi.de>
 <7vy5mskewg.fsf@alter.siamese.dyndns.org>
 <35825CE5-4411-4C75-830A-6D704ACA1410@quendi.de>
 <7vtxxgkac0.fsf@alter.siamese.dyndns.org>
 <84D9664E-3249-4D80-980A-C01B02DF5E43@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Tue Jul 10 00:38:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoMbX-00076W-KO
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 00:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042Ab2GIWiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 18:38:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46215 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980Ab2GIWit (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 18:38:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C88C99883;
	Mon,  9 Jul 2012 18:38:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8H5OvH6ShiifMaTmoFf+Gh/Tkcw=; b=oAN+Jj
	GulzNh6MaqtAHaWVOfXyyY4Jgy/BCcoptA51X6oYXhUl0Y4pv+ZmT1XaI1H3Dcg6
	sixtrLaXYTVnSDuPhoCV49jIN4NiDkzKWuCw0YVsj07LHkE04sJ4b9GONzFLjdW+
	Y/4Acnm2VQfY3gw2vw+oEfI880Ew6ISmThe5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GFmCYvNKXCZINtdeoYzmYiowt07fR/Qm
	0e6lUr45TNdcDuJMWJJ2kUiOPWCYM0IZAoz63uney2EevoUP8eamb8ubIXMXsI0X
	k7ooVK6bdWgekxrXSybSqbsq+5kUV4RIG/fXn1zSoYC3r5BMDsjTGGpxm5iJRXTN
	ESz1m/zHmTk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA2699882;
	Mon,  9 Jul 2012 18:38:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 513E89881; Mon,  9 Jul 2012
 18:38:48 -0400 (EDT)
In-Reply-To: <84D9664E-3249-4D80-980A-C01B02DF5E43@quendi.de> (Max Horn's
 message of "Mon, 9 Jul 2012 23:44:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D968B530-CA16-11E1-A17F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201229>

Max Horn <max@quendi.de> writes:

> But all in all, I don't understand why this order independence
> seems to be so important?

Not so important as long as it is made clear for later people to
patch that part of the code.  I just wanted to make sure that
somebody thought hard enough to judge that it is not worth the
effort to make it independent of the orders with a justification
better than that simply we are too lazy to do so ;-).
