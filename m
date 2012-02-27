From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: don't assume the merge filter ref exists
Date: Mon, 27 Feb 2012 10:05:59 -0800
Message-ID: <7vr4xg9mns.fsf@alter.siamese.dyndns.org>
References: <20120227122609.GA26981@mx.loc>
 <1330355513-22351-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>,
	git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Mon Feb 27 19:06:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S24y9-0005hx-IP
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 19:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754441Ab2B0SGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 13:06:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39757 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754379Ab2B0SGC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 13:06:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA5677484;
	Mon, 27 Feb 2012 13:06:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=SlEW7B
	PDk6tp2CZekiKJWu+qkKmcoXdUifR3LMj6M6x+mQyCNs4Nh+VKz0pfnac6NmsaVG
	1u6TKuCFZ9G8GuF13lrYLqb4UYUAl+/zhhMOyTOiZY6jSjmb+N2aghqCgRN7EqDx
	q1iNK8UqHeCef/N9VhBnRIGlBUE2+pho931qs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PdJ7s91B8euy8ZyW+iRpxuk5RdiOIjZr
	K7BRBWVauS+tsE5wqu6/7zFolJNKYFX2YDSNfwQKObUCsnQDoP0McmwZntNWTn8k
	KsJefIeKgzd94o85Qslxt5qHGWxg3xanKO/SJ0lK0k8G3mQxAYDLo6DvapRO4iHw
	sWIQqmK/n24=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A25447483;
	Mon, 27 Feb 2012 13:06:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10AA47482; Mon, 27 Feb 2012
 13:06:00 -0500 (EST)
In-Reply-To: <1330355513-22351-1-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Mon, 27 Feb 2012 16:11:53
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B4D1BFB2-616D-11E1-89AD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191640>

Thanks.
