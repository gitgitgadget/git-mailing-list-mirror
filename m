From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git.c: add --index-file command-line option.
Date: Sat, 15 Dec 2012 10:02:38 -0800
Message-ID: <7vpq2btcqp.fsf@alter.siamese.dyndns.org>
References: <1355484219-7517-1-git-send-email-manlio.perillo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 19:03:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tjw4i-0006Wy-HG
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 19:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514Ab2LOSCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 13:02:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53479 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795Ab2LOSCl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 13:02:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34B85A0E0;
	Sat, 15 Dec 2012 13:02:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=TvSSz2XSnHXsTV/cxRLpKnVdDzg=; b=h8F9bs1yA9KdBBCFsr2/
	ki2pZoAlAFuKnVoFYFbAtqZawHcPIEG6usdig0YBZFJ+STpDoExUpTvutuhAcqwS
	UwnaUjILPBJdq89cP0EoNuZRzDdG/gwQuDXRSnn6DTJwfikj+8nYKb8NIR2qXgKq
	Hh8dY3JUsRbodkamKpl3MD8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=inwdBu2IrITDACbOGYe6+Js1IJS/+FR8rxg8eXIyx8FEPP
	tcRKkezqOln9N2U2ybmWSjk6Pfu+mndM769aQGoijp6kmhsaAeaZWGXMayT26B7J
	tnq+8F7uipl/BBTdoouksHTgSGI8aLsmlH+UU3/b9WU8KXMQ0RIERNYIdhKbE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 221F0A0DF;
	Sat, 15 Dec 2012 13:02:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 634B6A0DE; Sat, 15 Dec 2012
 13:02:40 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9DD59B12-46E1-11E2-AE2C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211541>

Manlio Perillo <manlio.perillo@gmail.com> writes:

> Unlike other environment variables (e.g. GIT_WORK_TREE,
> GIT_NAMESPACE), it was not possible to set the GIT_INDEX_FILE
> environment variable using the command line.

Is this necessary?  I'd prefer to see a better reason than "just
because others have it".
