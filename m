From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] commit: allow partial commits with relative paths
Date: Mon, 25 Jul 2011 12:02:19 -0700
Message-ID: <7v8vrmrxok.fsf@alter.siamese.dyndns.org>
References: <CAOnWdohKfwEOMx=wr_PKiW+ucYBK2ZWykm_7dqr7hy4xGRM02A@mail.gmail.com>
 <19b908142567fcfafe4da3d0fd60b134d30c613a.1311579663.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Reuben Thomas <rrt@sc3d.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jul 25 21:02:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlQQ7-0005xP-CU
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 21:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169Ab1GYTCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 15:02:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35419 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751666Ab1GYTCW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 15:02:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C53A74C3E;
	Mon, 25 Jul 2011 15:02:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vKq01BRJDK+/wV6jTq4yAF8OjTU=; b=RGfW43
	P4sEXqozB/ZWvoUMC3MHG8V8rEvWvbGsDL39q4ydrimUeuJHCr6JFIZvDIDujIU1
	tnAviU5HGOoLlb2yu2Va9Wk8tuX5NV/bCqktvv5pvKBiEsAv4S1vlxyId5zrIIFw
	nrNE/K4LmjB8e7oVRFvicW7M4MKkgyErjGPbc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oB1bfhY+kXAtPNzJU8ydGTwlbnRaqLU8
	CtGLclank29yEtOyL/AuZevrbR0QOrzk0QH3h/JcwZoHdMPQUDUT15ks3eV1MkYN
	5A50cG+j+Q1+aOU9VWPkLj0QyVAKh5yRwLkQw7Ziolw8M6WviWNS939l1LtjhJP+
	UPtZ7io3iqU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD4AC4C3D;
	Mon, 25 Jul 2011 15:02:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 51E5A4C3C; Mon, 25 Jul 2011
 15:02:21 -0400 (EDT)
In-Reply-To: <19b908142567fcfafe4da3d0fd60b134d30c613a.1311579663.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Mon, 25 Jul 2011 09:42:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9FF9AD16-B6F0-11E0-87E1-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177808>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> RFC because lack of test, and also because I'm not sure we want this, and
> what to do about git add which has the same problem, but would need a
> different fix.

The reason you doubt we would want *this* is...?  Also what is the "same
problem"?

Perhaps it would become clearer if you supported *this* with a sample
workflow?
