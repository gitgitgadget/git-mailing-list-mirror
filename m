From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] echo usernames as they are typed
Date: Sun, 27 Nov 2011 00:56:56 -0800
Message-ID: <7v4nxqvt7r.fsf@alter.siamese.dyndns.org>
References: <20111124105801.GA6168@sigill.intra.peff.net>
 <20111127082744.GA32068@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 27 09:57:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUaXp-0001Bs-GG
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 09:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921Ab1K0I5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Nov 2011 03:57:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63809 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743Ab1K0I47 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2011 03:56:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD387396C;
	Sun, 27 Nov 2011 03:56:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tQZtvTkEyyJmK+ZLSlyQnmBe/NY=; b=lMjUhn
	9TcgIEXomSQ4xrPAybaBC6l1rm35VgOGl0ZjdWTyTMGPsxYAaAqe4HkWgLo+fYGo
	NZzxbb74p9fK2BXVZQE/dHG5ln7uFJ2Rd9ew8eEP68eVvhg2tMpXasIMx93fWgvb
	kEs816CmYC65bkh+wASK40TtGWyjndNHaOb/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n6EXdVnH34DocTlpyVtpZw/28WdWyCgP
	XBtmugiSWOEWjPQfC28Zl2ueshv8/idWWwCiACY+uTTjXy8zWK4xUHZcTh7G+CGD
	X78gCJXMPlt81+nNYkeZOIdf7g85sZq3RU+DuPY+ZuHX2fr8AHBQtMoAUGemVoRy
	YT8XicHQKxg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4E2F396B;
	Sun, 27 Nov 2011 03:56:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5AA62396A; Sun, 27 Nov 2011
 03:56:58 -0500 (EST)
In-Reply-To: <20111127082744.GA32068@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 27 Nov 2011 03:27:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C36FD418-18D5-11E1-A248-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185978>

Jeff King <peff@peff.net> writes:

> On Thu, Nov 24, 2011 at 05:58:01AM -0500, Jeff King wrote:
>
>> Here's a revised version of the http-auth / credential-helper series.
>
> And here's something I've been meaning to do on top: actually echo
> characters at the username prompt. We can't do this portably, but we can
> at least stub out a compatibility layer and let each system do something
> sensible.

Yay ;-)
