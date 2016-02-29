From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] run-command: do not pass child process data into callbacks
Date: Mon, 29 Feb 2016 15:53:24 -0800
Message-ID: <xmqqoaaz845n.fsf@gitster.mtv.corp.google.com>
References: <1456783026-3328-1-git-send-email-sbeller@google.com>
	<CAGZ79kb2h=4qeGbQ+42Zkq5wZ6eVu1rNQn=d1R6Rz4YA-q0xwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 00:53:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaXd6-0002IO-9U
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 00:53:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbcB2Xx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 18:53:28 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62327 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750870AbcB2Xx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 18:53:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9BEE74979B;
	Mon, 29 Feb 2016 18:53:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rb+S3rw77b4K7OPbkJx5vyrE2B0=; b=FC64Qm
	e/kn/thlOFEuAIUd5mHe3gdF3bWK/G1+egZVoNnWeLOF/Wd/ZI4R+qpg6tVLHBBM
	J+sv4Hz5V6OhjfMn7En28KEfPo4h4QBZjh1N7EubCXQYc4ct4GiMUwEOIFBOieIB
	lVqRKXACbnkgqHdC8PDeE31HHZOi9ClamtiKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VDbCVACJSbtzvRa1jblcnnSAQAwYbs9c
	WBua0WfySWiYJM1HqmoadplQCnPKDL9K1TqPOrmwvnuxLCR4MvjL+unOU+EbMGod
	X/uW56nTCbibglyxAFJp5m+931RHLiWLOzNPFZcLX+1DhKN7fm2WnEdXQmIoVcP4
	kefwntY4W6o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 943B14979A;
	Mon, 29 Feb 2016 18:53:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 15DE449798;
	Mon, 29 Feb 2016 18:53:26 -0500 (EST)
In-Reply-To: <CAGZ79kb2h=4qeGbQ+42Zkq5wZ6eVu1rNQn=d1R6Rz4YA-q0xwg@mail.gmail.com>
	(Stefan Beller's message of "Mon, 29 Feb 2016 13:58:41 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9FC45E46-DF3F-11E5-AB62-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287943>

Stefan Beller <sbeller@google.com> writes:

> It applies on 2.8.0-rc0.
>
> (I tried backporting it to 2.7, but realized it is not an issue there)

Thanks.  I tried to be nice to rebase the parallel-update stuff on
top of this myself, but stopped it as I won't have enough time to
push the result out for the day anyway.

submodule-parallel-update, submodule-init and refs-backend-lmdb
topics will be missing from tonight's 'pu'.
