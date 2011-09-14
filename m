From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] refactor argv_array into generic code
Date: Wed, 14 Sep 2011 11:42:16 -0700
Message-ID: <7v4o0fufsn.fsf@alter.siamese.dyndns.org>
References: <20110913215026.GA26743@sigill.intra.peff.net>
 <20110913215757.GC24490@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 14 20:42:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3uPv-0003S7-UG
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 20:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757404Ab1INSmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 14:42:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62976 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757396Ab1INSmU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 14:42:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB03550F6;
	Wed, 14 Sep 2011 14:42:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O1LGN2zp+dE+QgH0pmNzeq3Q1KU=; b=HaCGB3
	iHO5i5ZoutKPmZprLmoishjVBbsZH/vwJrRnZS3cJ5/5as4T1MfYTm6ZbLlZHACm
	7mhPFBPv4a/xVazPO5oVw4i9CRJ1hCOSw0K7GjTWUeHQk6BtHfeRab7XyTaatOtd
	Gv23hBHK0JCeYvVBtVxxB75e/5Xq4LTmag4LE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xUZU6+0QcvdTGBONXNjmeb8S37FpmDvz
	8HzqJjZ8610UUa+K8Gohn/g85xJ4r4BYDqw9xCcZeMsu4I8OqJPvju+j7Su/x/Yk
	4lBfOlQmZZvc5GWfYvvTHLfW+YweIf0CdUSCDFUiVrLdo5c4pkiq6fa0UIwD/CtO
	tzIKeoIIRsU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2F7E50F5;
	Wed, 14 Sep 2011 14:42:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C42B50F4; Wed, 14 Sep 2011
 14:42:18 -0400 (EDT)
In-Reply-To: <20110913215757.GC24490@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 13 Sep 2011 17:57:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 45F25190-DF01-11E0-8AFA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181378>

Jeff King <peff@peff.net> writes:

> The submodule code recently grew generic code to build a
> dynamic argv array.

That has not yet happened as far as I am concerned X-<.

I do not want the clean-up to depend on the uncooked submodule code and
that was why I said this is not urgent.

Will think about what to do next. Eh, rather, will backburner thinking
about it for now ;-).
