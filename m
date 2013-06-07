From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/10] Increase test coverage on Windows by removing SYMLINKS from many tests
Date: Fri, 07 Jun 2013 15:04:56 -0700
Message-ID: <7v8v2lshkn.fsf@alter.siamese.dyndns.org>
References: <cover.1370076477.git.j6t@kdbg.org>
	<cover.1370636706.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jun 08 00:05:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul4mO-00017e-2h
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 00:05:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756046Ab3FGWFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 18:05:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53113 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752999Ab3FGWE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 18:04:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2ACF526238;
	Fri,  7 Jun 2013 22:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D0epKQqLPsaeGqYcdYLfqy7kXKk=; b=bEVSfy
	miEV8ZRl4Nc4fld37ZfwOsORkF2lvhgvdShp9U2odpRUQ1uOFpp3VJM9IdPmzLlU
	geQlBpG3TNeQBLdZeXhT9p+zyiNQF509dMM19c/+NdYF7JGLboCPbZdFi4v95IOE
	6IB7WE5mlUsapZMtcn3Uf7bf+blEtkBidDtvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YjRqK1kvDJPACrYrrrqSF/N6j0/Mx7nq
	GM9TZZUTz/ZtCxpYVintVqVfQjnd48Ae0kdQHUs7zwWHRTEPynuReOdkeXcJl0S0
	IkDqOS94VqjQNeLNu4D5Y/5kQcIkzlGtFZzhTMFQDM5jlXU7V5pDWekjPYMx0OYq
	tLmDZzv1lDs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 206BE26237;
	Fri,  7 Jun 2013 22:04:58 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99E9C26234;
	Fri,  7 Jun 2013 22:04:57 +0000 (UTC)
In-Reply-To: <cover.1370636706.git.j6t@kdbg.org> (Johannes Sixt's message of
	"Fri, 7 Jun 2013 22:53:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4A92F556-CFBE-11E2-8168-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226746>

Thanks; the interdiff looks sane.
