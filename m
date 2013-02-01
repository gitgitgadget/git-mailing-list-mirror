From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] docs: clarify git-branch --list behavior
Date: Thu, 31 Jan 2013 21:42:20 -0800
Message-ID: <7v38xgd1z7.fsf@alter.siamese.dyndns.org>
References: <20130131064357.GA24660@sigill.intra.peff.net>
 <20130131064545.GA25315@sigill.intra.peff.net>
 <CAPig+cT21Fx6BaD=1jT7KSBZSZkWu-A-0U+QsM2qO8g5gki=YQ@mail.gmail.com>
 <7v4nhweuoi.fsf@alter.siamese.dyndns.org>
 <20130201050637.GC29973@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Peter Wu <lekensteyn@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 01 06:42:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U19Og-000101-R0
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 06:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072Ab3BAFmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 00:42:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54478 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752741Ab3BAFmY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 00:42:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E985D8056;
	Fri,  1 Feb 2013 00:42:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=02xX9bsroAATvKHzYReQa3N1OGc=; b=fykHs8
	MsoogX5ig6eiV5Dac51pjEz6jCjMzEICETOpy3+BMBivQ0PgRyj8mrB/qrojsRHt
	I75yvXtRgmY/M2t0njqsldUQf3n+k+w7rP6SsTJV3gTJ/HLMc3AdtV970mcetEZ7
	Pu5tbvUTKJCDQVw1Or29sOrwDxGnK4GEoXkNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XBOGOYoyVhphKDEpzEXs1/aY/bcpgXr1
	TWACJaoJnNAMYJqqR/9B7nLLt+CU1b/XaPkCW4vNQJnHZya8aRPvHiryguC6qYzd
	4+pKdH0I9/g7XQtrOf/g0klxBZgsRrWRytUcTey54124vac7wzKJI1h0LomULPGw
	cPC/PTy7Zgk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE4378055;
	Fri,  1 Feb 2013 00:42:23 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50FB88054; Fri,  1 Feb 2013
 00:42:23 -0500 (EST)
In-Reply-To: <20130201050637.GC29973@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 1 Feb 2013 00:06:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2705EAB6-6C32-11E2-B24C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215206>

Jeff King <peff@peff.net> writes:

> Thanks. No matter how many times I proofread a doc change, I always
> manage to slip an error into the final version.

I think everybody shares that trait.

> Hooray for many eyes.

Indeed.
