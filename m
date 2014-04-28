From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] PAGER_ENV: remove 'S' from $LESS by default
Date: Mon, 28 Apr 2014 11:48:12 -0700
Message-ID: <xmqqk3a9qoib.fsf@gitster.dls.corp.google.com>
References: <20140425154722.GC11479@google.com>
	<1398674062-24288-1-git-send-email-Matthieu.Moy@imag.fr>
	<87vbtt6dyq.fsf@fencepost.gnu.org> <vpqsioxn82l.fsf@anie.imag.fr>
	<87k3a96cj9.fsf@fencepost.gnu.org> <vpq38gxlk3m.fsf@anie.imag.fr>
	<20140428162439.GA9844@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	David Kastrup <dak@gnu.org>, git@vger.kernel.org,
	jrnieder@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:26:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WerBh-0008Ap-Ga
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932648AbaD1TZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:25:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54929 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932472AbaD1TZM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:25:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C258281E96;
	Mon, 28 Apr 2014 14:48:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5bKlY/rcQeyD30Bpd38xaY7lRYU=; b=qanyx5
	3uw+NPE2nFy8q4fIiJausBZn/MJ71XGwy8C0+VXMkcOLODoQcLJ3pxaXjEO7XA36
	86Tm8eGcZ+58zGNHNzoS+eCllub1oAi4KhQEek17bDKCxAruUxVa65gnZBMCvKED
	nJd2VIqAPeeeA7MTDXQrm2uM97txeKvTKzU5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X9fzCgWWq/01AldtfaOQqRtwrJKAegp1
	rtfiejSKWVjPXqKcnyzxtrTeN6T9w8hCME+likW7aGpCEbs3LiGdqJSOF5Gue5Pr
	Fzx2+e5XqjsuhRqZAu5mmH7XBc0iVQDxcDUu/OXwSVIT9y7v/D6e1ZyDOKQu+fBr
	QnAbCH1CSeU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A424C81E95;
	Mon, 28 Apr 2014 14:48:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C48581E8F;
	Mon, 28 Apr 2014 14:48:14 -0400 (EDT)
In-Reply-To: <20140428162439.GA9844@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 28 Apr 2014 12:24:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A78E99C6-CF05-11E3-8009-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247403>

Jeff King <peff@peff.net> writes:

> On Mon, Apr 28, 2014 at 02:22:21PM +0200, Matthieu Moy wrote:
>
> I'd be OK with doing the moral equivalent for now (perhaps just taking
> Junio's proposal[1]), and I can deal with the refactoring later when
> re-rolling the Makefile series.
>
> -Peff
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/240637

I doubt we would want to use the patch verbatim in that message; it
served its purpose well to illustrate that there may be other ways
to address the issue, but I agreed with the flaw in it you pointed
out in the thread [*1*]

I also agree that droppage of S does not have to wait for that
topic.


[Reference]
*1* http://thread.gmane.org/gmane.comp.version-control.git/240548/focus=240746
