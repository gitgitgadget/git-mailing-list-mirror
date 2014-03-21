From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/10] userdiff: cpp pattern simplification and test framework
Date: Fri, 21 Mar 2014 15:25:29 -0700
Message-ID: <xmqqbnwzrxye.fsf@gitster.dls.corp.google.com>
References: <53282741.5010609@web.de> <cover.1395433874.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Brandon Casey <drafnel@gmail.com>,
	git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>, l.s.r@web.de,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 23:25:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR7si-00015V-3o
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 23:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbaCUWZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 18:25:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62827 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460AbaCUWZe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 18:25:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFF9E75659;
	Fri, 21 Mar 2014 18:25:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z9cLzWaLHmRSu4L+ip42pIOoSLU=; b=AWSDsZ
	LlTK2WgPkMSv1Un2CEk4kBeRXuq+jsnB3zA4XU5R8jNq6tXAY3/ldD/s/PonWRq3
	ZO5YDKg/xn7xM3vMaYpYHiMYirCEeWdNHAN1nrPjGOxpYYCr4pNx4oKCrMdQ51co
	bmm3pKAaC+Zc6Qg8qxv//XcWUVfygUZcYkVkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w+hcJA17EzgAAIv3vIV3LEMZBz6THO0V
	tqUgQyZD2fjnzyNT5+AloMGhPmAinQGExKJjOuo2JKUmxJINOXOtXVYbRDbfvnfo
	APoFTOqzrlAeMXM0LtOmYt1aiEYM0/apFu5pcRxQi9Vr/dQLekoXBbZ5H3ozv4At
	lIJIqJW8zLo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9558E75658;
	Fri, 21 Mar 2014 18:25:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CEBE075655;
	Fri, 21 Mar 2014 18:25:32 -0400 (EDT)
In-Reply-To: <cover.1395433874.git.j6t@kdbg.org> (Johannes Sixt's message of
	"Fri, 21 Mar 2014 22:07:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B76A1DEC-B147-11E3-936C-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244758>

Thanks; will replace jk/diff-funcname-cpp-regex with this series.
