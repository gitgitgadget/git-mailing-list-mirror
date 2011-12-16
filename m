From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use custom rename score during --follow
Date: Fri, 16 Dec 2011 12:33:19 -0800
Message-ID: <7v39cki7e8.fsf@alter.siamese.dyndns.org>
References: <20111216112749.GA16314@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 16 21:33:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbeT9-0006me-Ag
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 21:33:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827Ab1LPUdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 15:33:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53648 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932590Ab1LPUdW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 15:33:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BF38587F;
	Fri, 16 Dec 2011 15:33:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3yPV1KSAH6/jjBrHt/H9rJO91DQ=; b=Qj7nOm
	ezpBx/qPrimor3POPJ6GPLKV/4tTpK5z884zWprvNfhMI8wTznQPQqZhQiSx4/so
	0BhUs2+LRyQZx4QUGQZi7blVaaCsOkAq6+c2yNCpUS3+Pf1zKhrPnWF05re9MWj8
	MQzAsj5itrulcCFnxwB3YykLqNXnhCDkXESSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RnzSld7Lig+f4R5jMRekk8eELdwQ6vYU
	d1cpP7v+Y0doewfNy0U+ysWG34ynqcER+750FtRW9T2ED98e+OqSveHskVqm1fCm
	+LbblMbPoAuoJjZ5XAIHHfe3BVUcqhqp4YvecszwVTJH+A8XMziBsaChEK4JS++7
	Q/yEZt/g/SU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83F83587E;
	Fri, 16 Dec 2011 15:33:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FED2587C; Fri, 16 Dec 2011
 15:33:20 -0500 (EST)
In-Reply-To: <20111216112749.GA16314@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 16 Dec 2011 06:27:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 31B64822-2825-11E1-A11D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187315>

Makes sense; thanks.
