From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] patch-id: document new behaviour
Date: Thu, 03 Apr 2014 08:42:46 -0700
Message-ID: <xmqqa9c2s9l5.fsf@gitster.dls.corp.google.com>
References: <1396202583-2572-1-git-send-email-mst@redhat.com>
	<1396202583-2572-2-git-send-email-mst@redhat.com>
	<xmqqmwg65gp7.fsf@gitster.dls.corp.google.com>
	<20140331192604.GF12208@redhat.com>
	<xmqq7g7a5ek9.fsf@gitster.dls.corp.google.com>
	<20140331204205.GB12403@redhat.com>
	<xmqqy4zntx1p.fsf@gitster.dls.corp.google.com>
	<20140402190243.GA13425@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com, jrnieder@gmail.com,
	peff@peff.net
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 17:42:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVjn5-0001Jw-0k
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 17:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbaDCPmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2014 11:42:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50887 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752456AbaDCPmu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2014 11:42:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D74A76DFF;
	Thu,  3 Apr 2014 11:42:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Oy576jyTasejwzzBlBVAQ7lje2E=; b=vZVHcC
	pqO0K6o8thZfbX6agDxX2efK4cG5pxpviUj7rSyshi+dGBgv9flYyM1FPSLhEOSC
	fttvqS3AcXKqb/Wv02wScW8I6wedFABSvD9Khy+o3EDIhEGi1vfQWughCI+zhJNB
	NXWYYN0vwDEJkdAN2AQTk3aj8RG9+Uzh0gfzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xEnpkT+wTCKYgDsLoUF2X0imelA8o2xS
	lCIb8zRINIQ6/LEDsWcrefmlyNcipoeSunOyiorD3kArP/GS/O4QaR2o6iNLjZem
	kQz3epNY8bfvdJxaFpUqi8pApiefWe6eY21yH/OLTjJFE3p5RFQUMurH6FT57nrE
	1531IpuitM8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D2FA76DFD;
	Thu,  3 Apr 2014 11:42:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 92FFE76DFC;
	Thu,  3 Apr 2014 11:42:48 -0400 (EDT)
In-Reply-To: <20140402190243.GA13425@redhat.com> (Michael S. Tsirkin's message
	of "Wed, 2 Apr 2014 22:02:43 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9BBBE3C4-BB46-11E3-B273-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245740>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> So I think I prefer using an option and not a heuristic if you
> are fine with that.

Sure. Changing behaviour only by explicit user request (command line
or configuration) is much safer than heuristics that does not work
reliably.
