From: Junio C Hamano <gitster@pobox.com>
Subject: Re: $PATH pollution and t9902-completion.sh
Date: Thu, 20 Dec 2012 10:36:08 -0800
Message-ID: <7vk3sc606f.fsf@alter.siamese.dyndns.org>
References: <20121217010538.GC3673@gmail.com>
 <20121220145519.GB27211@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Spiers <git@adamspiers.org>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 20 19:36:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tlkys-0007xw-5b
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 19:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027Ab2LTSgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 13:36:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36812 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751595Ab2LTSgL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 13:36:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D2E3A071;
	Thu, 20 Dec 2012 13:36:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wFqyqI+mdug6iFgCpuD7xgrBLoc=; b=U5lWvW
	YLRYXzujzofzHb+oD0hoVnY7KtoluhjHbJb7z+islu32vU0UorQ6iGgW7H/A883M
	D3vTVkPlQZCWViDCC/U4foH8A1ObiAknonlzYeDO/r7fqzR6ALaC2hnT/cYxwpGx
	Z/t8xynB2i/wHwzihUSUdfbYioAjIqmzbsGE8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rODzDlUlkaofWt7zWbXBR9cHjrV0ZCjo
	NgSPBxWBpi79RshOohkLRoBdjdQT2vMx1auT4BIbSTW2sFTqcJhsiOQmryzwyITr
	SQ/pqJVJx+SElJnTP22aGcLCE4xzxKvu47+7LxhSvPNOyuLsJGDf1ZzxPRJZr5dk
	4NxAl+bP/BQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EED6BA070;
	Thu, 20 Dec 2012 13:36:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F58AA06B; Thu, 20 Dec 2012
 13:36:10 -0500 (EST)
In-Reply-To: <20121220145519.GB27211@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 20 Dec 2012 09:55:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1FFBA9A6-4AD4-11E2-97FD-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211915>

Jeff King <peff@peff.net> writes:

>   2. Loosen the test to look for the presence of "checkout", but not
>      fail when other items are present. Bonus points if it makes sure
>      that everything returned starts with "check".
>
> I think (2) is the ideal solution in terms of behavior, but writing it
> may be more of a pain.

Yeah, I think (2) is the way to go.
