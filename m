From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Pushing symbolic references to remote repositories?
Date: Sat, 22 Dec 2012 10:27:35 -0800
Message-ID: <7vy5gqq6w8.fsf@alter.siamese.dyndns.org>
References: <CAD03jn5ACZyxJM9LEOSJov3BsT3W1N0sV3WYwcerJciMSpmSPA@mail.gmail.com>
 <CAJo=hJvqptfKqM+6J8Ddfb5qcqjAU8bB_JO9VB-XVsCCf64NUQ@mail.gmail.com>
 <7vip7vrof6.fsf@alter.siamese.dyndns.org> <m2ehiiv3nb.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dun Peal <dunpealer@gmail.com>, Shawn Pearce <spearce@spearce.org>,
	Git ML <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Dec 22 19:28:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmTng-0002qk-Rv
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 19:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071Ab2LVS1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 13:27:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40745 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752037Ab2LVS1i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 13:27:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96516AE7E;
	Sat, 22 Dec 2012 13:27:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cIciowULF22fZByD4FmisGvUkd8=; b=ZVUqkI
	OlS/rTpDNvaz6skE8yUtOdNNgeJZ5nlC/6kaYvU4+X33EeGm0SBgDqV8J4c6ATyU
	1P3CD+H4ODYD7PNYc4MNGWvbG1o9Uny5nYJiwTn3ywNfbco/m6d9zS3gGPDBuAfz
	hmFyHrf2cPBatySjrCC4Yf17+M6yGowsXX3Es=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=noGO3AqBrWO0TACKZyBXYVCi2A1HjV3A
	bVTqKeTZfJ/T0oqxPk+hDcCpfeQrERBynUmXyHbXIwlM37pD4dhoDGGlK3zsxZW6
	Gmt2eaL+DMM42C9qAjiBlzSKq7PdtmcqlJDLRqCPgGstOgISu/ql1GjoMpcv3rOI
	l9ve7hOGGpc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83E75AE7D;
	Sat, 22 Dec 2012 13:27:37 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 053FEAE7C; Sat, 22 Dec 2012
 13:27:36 -0500 (EST)
In-Reply-To: <m2ehiiv3nb.fsf@linux-m68k.org> (Andreas Schwab's message of
 "Sat, 22 Dec 2012 10:26:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 42C73850-4C65-11E2-BFAE-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212063>

Andreas Schwab <schwab@linux-m68k.org> writes:

> This is not limited to HEAD, any ref may want to be set up as a symref
> at a remote repo.  For example, I want to set up a symref master ->
> trunk at a repository I have no shell access to.

That is exactly the "hosting side does not give you an easy way so
pushing seems to be one plausible but not necessarily has to be the
only way" case, so it is already covered in the discussion.
