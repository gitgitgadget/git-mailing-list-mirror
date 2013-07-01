From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCHv2] submodule: add ability to configure update command
Date: Mon, 01 Jul 2013 09:26:56 -0700
Message-ID: <7vehbii6un.fsf@alter.siamese.dyndns.org>
References: <51D04F06.9000400@web.de>
	<1372673494-24286-1-git-send-email-judge.packham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, iveqy@iveqy.com,
	stefan.naewe@atlas-elektronik.com, hvoigt@hvoigt.net
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 01 18:27:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtgwT-0007IV-2D
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 18:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227Ab3GAQ1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 12:27:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62208 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161Ab3GAQ07 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 12:26:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D2B62C89A;
	Mon,  1 Jul 2013 16:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JwC6QqQA26MnuAQvo1E9ll1AsnA=; b=ZL807j
	ueJ9L6Wj52J2Z3oYaFHnaCD1KA7pl/f46Og8+WL5HJ7tmULs+Qev9xdpMD00Oyta
	G+6vup7Gh61+d06u3bcd8AmI2huTQgqQPx37jth0KlQadTLK3r8oyYN3vPKEUgcA
	MMugtMbNoUuxZAQ8rvsS+Zdr4VtDCxrFnG4jg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=moK8l/yAYro3ULA7N7ZsTHdmhY5sHNjj
	UcLjIKHZdqKpvhmbgZKZsnY3Hvt2dNWV/9KO+4fENrdvjC+ZJugdTCexekFEGe8Q
	F4JKDqG+txGFfYx/RerM+Plqj/JFzJCy8k+mT50QE09d64CJYrSYVsnCXojIUNs5
	OOEYT+fcZo8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 313602C899;
	Mon,  1 Jul 2013 16:26:59 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89F062C896;
	Mon,  1 Jul 2013 16:26:58 +0000 (UTC)
In-Reply-To: <1372673494-24286-1-git-send-email-judge.packham@gmail.com>
	(Chris Packham's message of "Mon, 1 Jul 2013 22:11:34 +1200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0D45D2F8-E26B-11E2-BB9D-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229308>

Chris Packham <judge.packham@gmail.com> writes:

> Subject: Re: [RFC/PATCHv2] submodule: add ability to configure update command

"ability to configure" wants to be rephrased to make it more useful
in the shortlog output to help me update release notes ;-)

    Subject: [PATCH] submodule update: allow custom update command

perhaps?  We already allow you to configure update command between
merge, rebase and checkout-to-detach, and the value of the change is
to let an arbitrary custom command to be used there.

> And here's an implementation of this. Actually I like this a lot better
> to the v1 patch.

I agree that this looks much more sensible.

Thanks.
