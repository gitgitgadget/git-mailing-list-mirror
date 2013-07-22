From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jul 2013, #07; Sun, 21)
Date: Mon, 22 Jul 2013 15:12:11 -0700
Message-ID: <7vsiz6b5xg.fsf@alter.siamese.dyndns.org>
References: <7vy58zozdk.fsf@alter.siamese.dyndns.org>
	<CAPM==HK_M5dd4gtUtc7tW4+dqQNQmr+qVU3aXJ1T6TDZTPYgwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>
To: Yamada Saburo <devil.tamachan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 23 00:12:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1OL7-0007Lu-Ib
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 00:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244Ab3GVWMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 18:12:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33748 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750989Ab3GVWMO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 18:12:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D709933934;
	Mon, 22 Jul 2013 22:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x2dHHHH7dgV4XXmkpPmGJMfXwkI=; b=KsQ72t
	uvXbOOOGZhs+4CQhFcBOTGtZO4fQCb8Qg7syVyJGjzGkRgcH49tnn+3VPwl8cL1J
	JnTo8JQVkFY1S4kJsZZS16brd5gHztmg219kKvY8FaLbhg0CrnErUlrMjW5FJaog
	l4BZubl+775PqR5WzCce3efrG+D5Qw9z8lrLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YGfX9L1EQOIYQwth6CkeMbdrzcXqvGGX
	cyM1nP09aoX9IL3voo+yIaPkg3XTSn75WfjSMEQ9dOf8HLvUQLi6gMoanfW8LmUM
	fCXOgboLSsp4JQjen9S2igwSHQ/KldanojuP66Akrl61o+pguoPIdRLk4O/tnwFh
	PVzzRpcUxM0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDA6733933;
	Mon, 22 Jul 2013 22:12:13 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3FAF533930;
	Mon, 22 Jul 2013 22:12:13 +0000 (UTC)
In-Reply-To: <CAPM==HK_M5dd4gtUtc7tW4+dqQNQmr+qVU3aXJ1T6TDZTPYgwA@mail.gmail.com>
	(Yamada Saburo's message of "Tue, 23 Jul 2013 06:39:25 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C2D1724C-F31B-11E2-A833-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230998>

Yamada Saburo <devil.tamachan@gmail.com> writes:

> My patch is not listed. When is it merged?

I do not take patches to git-gui (or gitk) directly to my tree.

Because nobody acked nor nacked the latest round yet, I do not think
the area maintainer has picked them up yet.
