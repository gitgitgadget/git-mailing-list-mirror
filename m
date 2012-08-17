From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] rev-list docs: clarify --topo-order description
Date: Fri, 17 Aug 2012 11:11:52 -0700
Message-ID: <7vr4r5tml3.fsf@alter.siamese.dyndns.org>
References: <7vsjbqbfhm.fsf@alter.siamese.dyndns.org>
 <877gt16ewe.fsf@thomas.inf.ethz.ch> <7vzk5x8s1q.fsf@alter.siamese.dyndns.org>
 <87sjbpa5m8.fsf@thomas.inf.ethz.ch>
 <7vmx1v53fb.fsf_-_@alter.siamese.dyndns.org>
 <CAOeW2eFZNuM_8bFB2cXGVRT0FpDC86fH=XMj9kviXs-UCo1fAA@mail.gmail.com>
 <7vipcj2w9f.fsf@alter.siamese.dyndns.org>
 <7vehn72vyl.fsf@alter.siamese.dyndns.org> <87pq6rw77l.fsf@thomas.inf.ethz.ch>
 <502CC4E7.5060508@alum.mit.edu> <87k3wzujuy.fsf@thomas.inf.ethz.ch>
 <7v628i3jiu.fsf@alter.siamese.dyndns.org> <874no1hnfg.fsf@thomas.inf.ethz.ch>
 <7v1uj5wi72.fsf@alter.siamese.dyndns.org> <87obm9a07z.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 17 20:12:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2R1d-0006eG-Qj
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 20:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758720Ab2HQSL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 14:11:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45250 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752095Ab2HQSLz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 14:11:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6676816C;
	Fri, 17 Aug 2012 14:11:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4tWWG2T86uM7OIDwaMfCjfXTkrU=; b=r4/ttr
	uukr0jFhWgsV3Bpjkkajbor1Kh5rLWVylaA/0cMDQtl4g+yMN6fKiduDZaBtsGdf
	E+jTwx7cuM8+7NokjdyUun1BSoZGh+zUUwuCGAfcaj5m/xw7sdZx/m8kpBYBV8Ss
	XeOyVoTMm2R9qmOoC9cxsjAIZzw1LyLLFe5iY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K6C/WNKtsEWwtzjoKoVzsb+H5Cuv2ZGE
	xqjuhiE3nW21h/qqevRiq7tDikp154xfEAAvouBzEwWCx1xEh6FFMSSXYuTQRLs/
	CrYmsk6oKq4BIOE3Tgqfuxvc7dt9b+eqljt5UjOiWK1Eqdy86rjwkfOReJ3xEZf9
	v61Qznl5x9Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2F158164;
	Fri, 17 Aug 2012 14:11:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A5938163; Fri, 17 Aug 2012
 14:11:53 -0400 (EDT)
In-Reply-To: <87obm9a07z.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Fri, 17 Aug 2012 19:37:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0641F456-E897-11E1-A4AC-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203638>

Thomas Rast <trast@student.ethz.ch> writes:

> Umm, have you looked at the algorithm I proposed?
> ...
> So really, this is only about modifying the algorithm that generates the
> existing order to allow for streaming output as it reads through
> history.

Sorry, I thought you were optimizing sort_in_topological_order()
found in commit.c, not the callchain that forms get_revision()
in revision.c.
