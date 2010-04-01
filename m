From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to log a host (or a repository) of a commit?
Date: Thu, 01 Apr 2010 12:06:45 -0700
Message-ID: <7vk4srouuy.fsf@alter.siamese.dyndns.org>
References: <87fx3fniiy.fsf@dasa3.iem.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?=C5=81ukasz?= Stelmach <lukasz.stelmach@iem.pw.edu.pl>
X-From: git-owner@vger.kernel.org Thu Apr 01 21:07:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxPjH-0002oU-IT
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 21:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758079Ab0DATGy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Apr 2010 15:06:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57493 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754773Ab0DATGw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Apr 2010 15:06:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DDA9EA6F70;
	Thu,  1 Apr 2010 15:06:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2LksfqMO5ENQ
	QcYpH9TUI2vWNr0=; b=R0+udiUchpFK5x3C2mJBc0ZfUXqhOSFTJeB5B4vbYuz9
	qaXrSIzF9yBsjGWzADLfcyadlEzLuc71Wv+PKc4/O5U8dp/pugD7op3V+f3h6/W2
	fixoOuPRmnTbT1Rs025i6u3EEjQqxnCaSsmXbfpHOQNvM65D/YA42USqyF8Oz58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=K+7LTy
	TXxfbkoIu2s/anmdH7YBKKsmcZMOdFIR4KrVxh165sqztgmTMVVw/YhGHP4NstrX
	dljUCSrN4c7FRYS51ldSJL7xAGE18gNRa7cFUH9yD7EXYfYIR3p+vadrYHdGFTfs
	db0NAc7nHFtCS0olzMH4+zPw/yjM3doPQj0/w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B230FA6F6C;
	Thu,  1 Apr 2010 15:06:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89EFDA6F68; Thu,  1 Apr
 2010 15:06:46 -0400 (EDT)
In-Reply-To: <87fx3fniiy.fsf@dasa3.iem.pw.edu.pl> (=?utf-8?Q?=22=C5=81ukas?=
 =?utf-8?Q?z?= Stelmach"'s message of "Thu\, 01 Apr 2010 20\:18\:29 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B990619C-3DC1-11DF-BF50-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143742>

=C5=81ukasz Stelmach <lukasz.stelmach@iem.pw.edu.pl> writes:

> Is there a way of logging (an retrieveing this information) where a
> commit has been created and keeping it when merging/pulling/pushing?

=46or example, in

  http://article.gmane.org/gmane.comp.version-control.git/142549

Linus says:

    I used to find it convenient to see what machines I had worked on, =
so
    I actually included that.

Two observations to draw from this:

 - You could use committer identity for that.
 - Wonder why it is "used to"; perhaps it wasn't useful after all.
