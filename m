From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/4] glossary: improve definitions of refspec and
 pathspec
Date: Mon, 15 Apr 2013 11:14:26 -0700
Message-ID: <7v8v4ju0e5.fsf@alter.siamese.dyndns.org>
References: <46832203.996447.1366047902197.JavaMail.ngmail@webmail19.arcor-online.net>
 <1496585271.996545.1366048207561.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Mon Apr 15 20:14:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URnvG-0003tF-4K
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 20:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756692Ab3DOSOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 14:14:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33306 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756687Ab3DOSO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 14:14:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD97916EED;
	Mon, 15 Apr 2013 18:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l5X0kfheKvb4IfQXirvE9GJO6lQ=; b=xKYpR/
	crlW+yUe/krnMquQ9QfuMSz+dbAXX9JvRua9Mxkgxy+OPDYGHDuWt0b5RvaDawEt
	h8wYO+LqGl3tfBQxk9UhZ5U4nlzf2auCWhjaejunAZLXjQox4L/QdJNvpPIaj5+c
	YWoTA8IhyLFWyqsotPQ8qPgDlPLuZeMFSIugc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MwM+2xzubro1LzZv9fz8J0m8d+SOFnfD
	m6jfRkpNz6qA62OwzkweanT5n4zvnejVs7Hm+GGlkkbfinl1fPMXYFktDsmdN8qp
	fwSmHvYb/7u88ESJaHE4cDPd824yOxMvGlKyfKh3lzby4RESOgI69/JG/t/klsrT
	nX4rkoCEw6w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A544216EEC;
	Mon, 15 Apr 2013 18:14:28 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1277D16EE8; Mon, 15 Apr
 2013 18:14:27 +0000 (UTC)
In-Reply-To: <1496585271.996545.1366048207561.JavaMail.ngmail@webmail19.arcor-online.net>
 (Thomas Ackermann's message of "Mon, 15 Apr 2013 19:50:07 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4F9EE856-A5F8-11E2-8484-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221279>

Thomas Ackermann <th.acker@arcor.de> writes:

> fix the idendation of
> the first paragraph after the bullet list

That's indentation, I think, and is a good fix.

> and remove the one-item
> list of magic signatures with its - for the user - unnecessary
> introduction of "magic word 'top'".

But I do not know if the description of the longhand ":(top)" is
unnecessary for the user.  Is the equivalence between it and :/
described anywhere else in our documentation set?
