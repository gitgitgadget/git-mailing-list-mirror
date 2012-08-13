From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] fetch-pack: mention server version with verbose
 output
Date: Mon, 13 Aug 2012 12:43:17 -0700
Message-ID: <7vy5lid1d6.fsf@alter.siamese.dyndns.org>
References: <20120810075342.GA30072@sigill.intra.peff.net>
 <20120810075816.GC8399@sigill.intra.peff.net>
 <7v7gt6jz3s.fsf@alter.siamese.dyndns.org>
 <20120810211509.GB888@sigill.intra.peff.net>
 <7v393uif9g.fsf@alter.siamese.dyndns.org>
 <7vboieehrf.fsf@alter.siamese.dyndns.org>
 <7v7gt2ehl4.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 13 21:44:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T10Xv-00028F-Nf
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 21:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298Ab2HMTnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 15:43:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60922 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752167Ab2HMTnU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 15:43:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F058A9339;
	Mon, 13 Aug 2012 15:43:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZG+y14RBpGkp5pPhDTdCo4EPPhY=; b=iBQghP
	JEnU2OP2BdJBFU6++wUR5fl+tvFhofG0763clTHrrCbD6D1FOwpveGWLF9FCXu8Y
	r76D7nypdNan5D3ceDpbH1AKxfOjbJ6Luufh9xfJiJPXyQLS2Tj2TsgMRWb0Au2r
	hWKPctsj9toRk7M1HntWGlVZ0ElZOcaceGW1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XC7wfLHcEEssFdXYqMNqp/AVni1Jbrav
	I8yq4e4GdgVdgjh4Hf9DgTyC06pl3yc36cVdMQXYBub5//SynpzwG0eEk4tl0kWj
	fixUWZYBpna14XDgx76zwPHkmUwY46fiFj4/hdv8E49NV3x/CHDbHoLus7CAqLxn
	5bl+1pJTAa8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA6BD9337;
	Mon, 13 Aug 2012 15:43:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A0879336; Mon, 13 Aug 2012
 15:43:19 -0400 (EDT)
In-Reply-To: <7v7gt2ehl4.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 13 Aug 2012 12:07:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 22133692-E57F-11E1-ACCA-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203355>

Junio C Hamano <gitster@pobox.com> writes:

> Fetch-pack's verbose mode is more of a debugging mode (and in fact
> takes two "-v" arguments to trigger via the porcelain layer). Let's
> mention the server version as another possible item of interest.
>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * And this is your 4 adjusted for the previous one, releaving the
>    caller from having to figure out where the capability string
>    ends.

Oops; this was a cut and paste error.  There are these four
(counting the blank after "Subject:") lines before the description.

    From: Jeff King <peff@peff.net>
    Date: Fri, 10 Aug 2012 03:59:29 -0400
    Subject: [PATCH] fetch-pack: mention server version with verbose output
