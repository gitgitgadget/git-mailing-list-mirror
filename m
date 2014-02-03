From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] userdiff: update Ada patterns
Date: Mon, 03 Feb 2014 12:05:49 -0800
Message-ID: <xmqqlhxsdkrm.fsf@gitster.dls.corp.google.com>
References: <20140203183301.3642.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ajohnson@redneon.com, git@vger.kernel.org
To: "George Spelvin" <linux@horizon.com>
X-From: git-owner@vger.kernel.org Mon Feb 03 21:05:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAPmH-000862-G8
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 21:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbaBCUFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 15:05:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63731 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912AbaBCUFw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 15:05:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35CB36990E;
	Mon,  3 Feb 2014 15:05:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hq/niDLfQC2Lc0RUGJawkzMlC/8=; b=eiMD1V
	EPe2VVb4K0pidUoobctqWKcoEE9SPF4OBQ6eyDHL1++3/REIVtws+7WLPM2/VHKK
	SkHqhIS/JyJLMiPW40LqNOjUquUShMZ6ChElY6VrHz97P0oyYYy9a3ifbhX/plhK
	1WUvZ2nU+PZhoPD0nQAyOS3zGHshSphN6vNfo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GhUg+5FLGWY/6spTt1YkD8P77FH/+H3j
	GOjggC5dIwy8VvhzAtD++QVNrv0uCk3+cKw9liCs3+tiB24UbOdxIpyiA8HZTdrn
	pLZ4G5tF4SFJleJUpgkf0f62JeTwM4kPIYe7S9WQhp/OutvhJcfUT2mFVPKrYYaQ
	zA5I4GikBP0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9ACF56990C;
	Mon,  3 Feb 2014 15:05:51 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B0E9D6990A;
	Mon,  3 Feb 2014 15:05:50 -0500 (EST)
In-Reply-To: <20140203183301.3642.qmail@science.horizon.com> (George Spelvin's
	message of "3 Feb 2014 13:33:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 943D2E48-8D0E-11E3-ABD9-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241469>

"George Spelvin" <linux@horizon.com> writes:

> Another point is that Ada doesn't actually include leading + or -
> signs in the syntax for "number", but rather makes them unary operators.
> This means that spaces are allowed, and whether you want to include them
> in the "number" pattern is a judgement call.

I tend to agree.  What do the patterns for other languages do?
