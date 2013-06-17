From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] GIT-VERSION-GEN: support non-standard $GIT_DIR path
Date: Mon, 17 Jun 2013 13:06:02 -0700
Message-ID: <7v38sgcxjp.fsf@alter.siamese.dyndns.org>
References: <20130615230108.GA21005@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Mon Jun 17 22:06:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uofgp-0000dm-R7
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 22:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090Ab3FQUGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 16:06:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50535 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222Ab3FQUGF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 16:06:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D760D28D0C;
	Mon, 17 Jun 2013 20:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iYNPwwzSpk5UjWDFRSXaLAwHsww=; b=AKF7Uu
	YNO9zLnLZ2VU+Q5ATUPhwBtmgkU585MIfS8oelOrFFLlHHPjXRXpcHV53OCemeWs
	KC/K8puc9dUhkVT6wcnF0i5RaFccoih4eXacnxUmdCL1JL/WOhc3s3SmLaljPfEw
	X/QHmNda1lqJ3yNZXSzcrJk275CcxY2Dz9gOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o3YdSsfBVM8HLDHmBvERYrpLaP+QsRYv
	yEuo27ghHl++2GO15l1L/e6ldalNksAlMZRYgSNJlS6Kq3V8T6WM8lfil9nQihu6
	v3zVOQ0AfWD9WmMfgePe+DyFJoJW09Ol+BWbnlazksh6lcKrPg/VM/QVa3C8mOcR
	LwvqtXQMdFo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBF6228D0B;
	Mon, 17 Jun 2013 20:06:04 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B8A7928D03;
	Mon, 17 Jun 2013 20:06:03 +0000 (UTC)
In-Reply-To: <20130615230108.GA21005@kaarsemaker.net> (Dennis Kaarsemaker's
	message of "Sun, 16 Jun 2013 01:01:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56B93EEE-D789-11E2-8568-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228107>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

>  I'm doing daily builds of git, using many workers and a shared git.git,
>  with per-worker checkouts

OK, so GIT_DIR is explicitly specified in these "workers".

Makes sense.
