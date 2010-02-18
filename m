From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Thu, 18 Feb 2010 10:16:04 -0800
Message-ID: <7vtytee7ff.fsf@alter.siamese.dyndns.org>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
 <201002181114.19984.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jonathan Nieder <jrnieder@gmail.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Feb 18 19:16:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiAvK-0001tb-K8
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 19:16:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785Ab0BRSQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 13:16:21 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52680 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645Ab0BRSQU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 13:16:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DADBB9BDA2;
	Thu, 18 Feb 2010 13:16:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vmQIZQsoWrdGYDCoFYNNgECGMJ4=; b=hjvCyU
	CQ82haWp6jUr60HNl/LXaK6LIzuouK+9QHwrpw7IX5Dev8Wf7VHtOgfYmuVnNdS0
	7gtGrikrhwT2C4HNl0R5hiJ+Sqlr/3fKgWF8Vq0W5tpLZaO+eTqu8HA7eL4W27w3
	x+2d1XfLLi6nFA1c9YRRZB/xStoHkU/A7+b5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t+rxQGc6YZNpnfH4FYEvpcffCbYZK/L0
	dia9dnBMnGOyt2IFmiQNfyokyf0CyMsh5rFjaqQHj8+IPOtnu/+yehm5a3RlIPcs
	DTYOJDK2p8KKIWSrcb+1NeoMPyy2J7ntj6cVM21K1+iJ3KhI8fJNILc5hazftz2p
	efIg9KzutCk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3ED169BDA1;
	Thu, 18 Feb 2010 13:16:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77BE89BD9A; Thu, 18 Feb
 2010 13:16:05 -0500 (EST)
In-Reply-To: <201002181114.19984.trast@student.ethz.ch> (Thomas Rast's
 message of "Thu\, 18 Feb 2010 11\:14\:19 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B26550AE-1CB9-11DF-B57C-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140356>

Thomas Rast <trast@student.ethz.ch> writes:

> This makes it sound as if the user is to blame, but IMHO we're just
> not checking the input well enough.

Honesty is very good.  An alternative implementation that does not hurt
performance as much as the "paranoia" would, and checks "the input well
enough" would be very welcome.
