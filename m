From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse --show-prefix: add in trailing newline
Date: Tue, 10 Apr 2012 09:14:11 -0700
Message-ID: <7v8vi3sgx8.fsf@alter.siamese.dyndns.org>
References: <1333978076-29968-1-git-send-email-rosslagerwall@gmail.com>
 <7v1unwwwov.fsf@alter.siamese.dyndns.org> <m2vcl7ir86.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ross Lagerwall <rosslagerwall@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 18:14:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHdi0-0003K9-Ol
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 18:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482Ab2DJQOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 12:14:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38927 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753036Ab2DJQOO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 12:14:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 625A173A4;
	Tue, 10 Apr 2012 12:14:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uzmlANw5qAQqEcOBFCdSMIAZAnE=; b=NhINNS
	k5Eu8yWMVB8/pD57DQsOpbw1wn/7RacdNS/+wjWNz8OJERwSgtd9WkEa4E+UdHSa
	g/9seBCmZTUzxQ2oI9XPm26MQx7uktzvaLSH1MDfQNjMkPDatyd9fNHE1Q5JNKnp
	a96AuVaS0PZzHj5217B/FmyJDqRTjQWIu0L/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wxp6kDnbt2rbLuUBYAVe/fTX6O4LbvU8
	QkpmXRHCB9hImwmgIITqlZWkLVYo5WKL9NMcU0fzA1fsFZZalvXRhIWE56en4dtg
	bKc9lwk4sUxWY+axCMa0ixhiJgODrx9CGlWyDI9XjwNA+jOixiIav3WFQil4cgpT
	lG5qXwQYBZo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5875D73A3;
	Tue, 10 Apr 2012 12:14:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CAAEE73A2; Tue, 10 Apr 2012
 12:14:12 -0400 (EDT)
In-Reply-To: <m2vcl7ir86.fsf@igel.home> (Andreas Schwab's message of "Tue, 10
 Apr 2012 16:41:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 36291E26-8328-11E1-B8E2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195100>

Andreas Schwab <schwab@linux-m68k.org> writes:

> This is already broken because of the extra slash.

Yeah, you are right.
