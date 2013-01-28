From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 09/11] t4014: more tests about appending s-o-b lines
Date: Sun, 27 Jan 2013 21:51:23 -0800
Message-ID: <7v38xlzwh0.fsf@alter.siamese.dyndns.org>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
 <1359335515-13818-10-git-send-email-drafnel@gmail.com>
 <20130128033146.GM8206@elie.Belkin> <7vboc9zwv1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org,
	pclouds@gmail.com, Brandon Casey <bcasey@nvidia.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 06:51:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzhdE-0006qo-1Z
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 06:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741Ab3A1Fv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 00:51:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53239 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751130Ab3A1FvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 00:51:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68C4E73AC;
	Mon, 28 Jan 2013 00:51:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JsIB+ugpoyFFaBWQf2503LKm9dA=; b=hzpGq1
	xvc/Db3uLdfI5TK8G6l+S5I/Qg7uYWhgkCOP2xgpYmDz0Q5bxIvZ1lZi4GpVTbNR
	50Y4U4KivhgBtRypzz2BHbWi1YHOnA0H0T3F0p//i4oSG+4TaBIXKm7LYkXfpzi/
	bhpydmnv1TxKaHgiEIZmVGoYBrkhk1GyPHMLc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jreHZiD+VrrNMPlN5kh/hUbr/4UmbssC
	33/6vGGYb7MapX90vmVorCyxfThv1tCQDIWDvVVlRJMiLUXdMUVq0SY1t52fCG02
	m2S2pPbpHJ57slJ/+Q5Z/3ZPTswPpyK8N0rAMcNyTe/bBNR5DnllWOlOHE45Mn9Y
	cuMdD7QmChI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A3B873AA;
	Mon, 28 Jan 2013 00:51:25 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E12E673A8; Mon, 28 Jan 2013
 00:51:24 -0500 (EST)
In-Reply-To: <7vboc9zwv1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 27 Jan 2013 21:42:58 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C02F0D3E-690E-11E2-A51C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214807>

Junio C Hamano <gitster@pobox.com> writes:

>> Is "grep -n" portable?  I didn't find any uses of it elsewhere in the
>> testsuite.
>
> Yes, "-n" is in POSIX.  Even though we use it ourselves, "git grep"
> supports it, too.

Ehh even though we *DONT* use it ourselves, ... that is.

I do not think we mind, if its use helps our test.
