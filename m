From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git push: remove incomplete options list from help text
Date: Sun, 18 Oct 2009 22:41:06 -0700
Message-ID: <7v3a5gaqkt.fsf@alter.siamese.dyndns.org>
References: <7v8wfi1fya.fsf@alter.siamese.dyndns.org>
 <4ADB4AE8.5070007@hartwork.org>
 <20091018235240.GU6115@genesis.frugalware.org>
 <20091019115412.6117@nanako3.lavabit.com>
 <20091019041033.GB7170@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Sebastian Pipping <webmaster@hartwork.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 19 07:41:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mzkzn-0008Ii-23
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 07:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbZJSFlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 01:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbZJSFlR
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 01:41:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46878 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbZJSFlR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 01:41:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 678255E1F9;
	Mon, 19 Oct 2009 01:41:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+EHsc+rs3SCJK0mzqEZeWgVn5zw=; b=ZyKe6h
	Ruz2SctLQIdYL8CZJ9eoQ2+0R46ed1P2ZFJ2fLHs39zgS2/H+oyJDB0gvWiULskw
	cYN9SwFv1gbxkXuziuMCsH9edH9Q8I5v7/DMNnLb6kKj53Jp2H0ddqsMTYfepAr5
	6SWXd7+mGGfMUx8XZHBR4WcQQoe0FEv/0lXCI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aC0GZFZp9iYJVtCMTwHXdtbwT6ovSj3W
	2Rjeo8iRbSkV7XgmZKkE/KAnhyAewI+81ZqhgqWLEOdVWKWeQeX4CIb5jCvSDXwz
	exN4AbnaaKkAlWsLqpoGfFrSo2s5jilv27g64qYuaeUVnCmg1ORLGDI7GSjJ/EiW
	K7Cm4TuMexk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 12E535E1F6;
	Mon, 19 Oct 2009 01:41:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2EBD55E1F3; Mon, 19 Oct
 2009 01:41:08 -0400 (EDT)
In-Reply-To: <20091019041033.GB7170@coredump.intra.peff.net> (Jeff King's
 message of "Mon\, 19 Oct 2009 00\:10\:34 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 04331A40-BC72-11DE-ADCE-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130652>

Jeff King <peff@peff.net> writes:

> Probably few people read it, as it was buried deep in a thread. But
> maybe we should settle on a rule like "short synopsis for usage, long
> synopsis for manpage" or whatever people think is best.
>
> Also, minor nit with your patch: should it be "[<options>]"?

Thanks, I agree with you on both counts.
