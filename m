From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git tag usability issue: Lightweight vs Annotated confusion for the end user (ex. git describe default)
Date: Wed, 24 Jul 2013 13:34:00 -0700
Message-ID: <7vtxjj66kn.fsf@alter.siamese.dyndns.org>
References: <51EFA9A9.4010103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.segato@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 22:34:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V25lT-0000Ri-Q8
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 22:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953Ab3GXUeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 16:34:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49026 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752641Ab3GXUeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 16:34:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B690A33D93;
	Wed, 24 Jul 2013 20:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2Ca1Pwhb5tm70yRudcXXgyV9RrI=; b=JXQ6Lb
	EqbzvqQBYxzjJRHB/XudE+CQXPpcMKsfRHZJRHEK9hFFnHpRmHsFddDw1QvC4rr4
	V+I9T4DWpzUtjyHoQZC4LDDTpqh60oc99e6iSyKYf+Vq/ocmEwCV+aPXBoa6piRI
	plr+5J4ZVoZzczq4jo0eLoZ34kC25dD55UJs8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o3mY0OWWKzAN8/fU2XuEo0I9XdwwNy9g
	d0TIo7gSsQ/X2LJj973OX+WWf8YF1iwbmr5bjcWvUWmCGcee4WFfteVllrLc6gsM
	dHJKnjQH/IiDQqs2d018muoMz42LugAEbSHeETWct2dTcLyfsu3XXR2Emfv6TRSK
	nw6ziYXuW2s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD16F33D92;
	Wed, 24 Jul 2013 20:34:07 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2331933D91;
	Wed, 24 Jul 2013 20:34:07 +0000 (UTC)
In-Reply-To: <51EFA9A9.4010103@gmail.com> (Daniele Segato's message of "Wed,
	24 Jul 2013 12:17:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 633EADF0-F4A0-11E2-8B52-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231117>

Daniele Segato <daniele.segato@gmail.com> writes:

> Annotated and Lightweight tags are not the same thing
> for git and you shouldn't mix them up. Annotated tags are meant for
> release while lightweight tags are meant to tag random commits.

Nicely explained.

This is one of those "we who worked on Git (not worked "with" Git)
for a long time _know_ it and do not need it to be explained, and we
didn't spot that it is not explained in the documentation for new
people."

Care to roll a documentation patch (and get a commit count for
yourself ;-)?

Thanks.
