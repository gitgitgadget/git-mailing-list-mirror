From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 5/5] t3910: use the UTF8_NFD_TO_NFC test prereq
Date: Mon, 30 Jul 2012 08:29:50 -0700
Message-ID: <7vtxwps1w1.fsf@alter.siamese.dyndns.org>
References: <7vboj115as.fsf@alter.siamese.dyndns.org>
 <de831564718b0d52d6ba6e9cb13020defdbfa359.1343641675.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, tboegi@web.de
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jul 30 17:30:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svrux-0005Dx-97
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 17:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984Ab2G3P3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 11:29:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50673 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752456Ab2G3P3x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 11:29:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 802688A7D;
	Mon, 30 Jul 2012 11:29:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M8AgQoTWE40+4YYdJaYobHlLgw8=; b=QdfAdg
	ufDjcgYqUq0d/YpgocP2NjZncf3T+bZBf78aDVVYLQeZSYQuswSgNnDDW/+kdUwz
	pvJQEQVrieZxEcquVqeHjwSoW0iyv2nIhb/z5i8WG3QyMDYGThaEaeP2mWlSyMrd
	NaHg5P7Y4aVENzN87JFjRtAhyKRtRuf+HydGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qpE+uU+5HvwEYJUqUMPZJWs+WE6RMruI
	778TSV2G8+O+g4+0JFuyvwfL2frXwB6nm+O7yxLTjf81Js5VSR8ejzbiv/s0q68L
	Wv8+XSk+DE7zQC9H9tWU/SywRQLN+a475ua1xJ0tIl0x5Asik59TqWa/8xdVU9FC
	5JfGbt/fy1s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DF468A7C;
	Mon, 30 Jul 2012 11:29:52 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E4A208A7B; Mon, 30 Jul 2012
 11:29:51 -0400 (EDT)
In-Reply-To: <de831564718b0d52d6ba6e9cb13020defdbfa359.1343641675.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Mon, 30 Jul 2012 11:57:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 67FEAA80-DA5B-11E1-B22C-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202563>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Besides reusing the new test prerequisite, this fixes also the issue
> that the current output is not TAP compliant and produces the output "no
> reason given" [for skipping].
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> Same patch, new subject line which matches the actual patch. Yeah.

Thanks; queued.
