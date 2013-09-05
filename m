From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-merge.txt: fix formatting of example block
Date: Thu, 05 Sep 2013 10:51:26 -0700
Message-ID: <xmqqa9jrjgwx.fsf@gitster.dls.corp.google.com>
References: <87sixjb8uq.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Sep 05 19:51:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHdiS-0008HC-Mn
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 19:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777Ab3IERva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 13:51:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65309 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752124Ab3IERv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 13:51:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4462B3E3C7;
	Thu,  5 Sep 2013 17:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/DQZ4e1/SWDH5SP5LZylnyubsKE=; b=u4+iqy
	MKK2k9efjs8qIZoXmw6uLh09RMX/EiArnZPTlG9JRMgCQHs9EO0V6RQ6fMuxbZSO
	h9wvF6yyZX1isFnbP315ALyZ4U7BCkGT60mBjlakggUQJ7EhC9aTK7Nc8i2VVF1A
	hlFUL+yd9Zl9B+Jxbp3Ig0gW9U95lUOsy/wnM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MvMwTO2cR78MMbypxIFJBe1f+x9c6NtU
	DlU42JBQobqFSlfivkjLe8wOI5OtcdI9QudhyBQ0Oj9fdQ8UZ4gbSZpPBJFwEaEI
	e0aFeF22TfWPQlX7+dJsnWJfJFoiEJPVXju/HXkm7x7iYPWpDiHufwIM1M1i8BLL
	8zgY54UJBTE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20DDC3E3C6;
	Thu,  5 Sep 2013 17:51:29 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F7AC3E3C3;
	Thu,  5 Sep 2013 17:51:28 +0000 (UTC)
In-Reply-To: <87sixjb8uq.fsf@igel.home> (Andreas Schwab's message of "Thu, 05
	Sep 2013 17:12:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CA60CDEA-1653-11E3-A038-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233975>

Thanks.  It seems that this was broken from the beginning at
77c72780 (Documentation: merging a tag is a special case,
2013-03-21).

Will apply.
