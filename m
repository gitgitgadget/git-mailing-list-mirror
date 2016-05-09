From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] Support marking .git/ (or all files) as hidden on Windows
Date: Mon, 09 May 2016 10:01:59 -0700
Message-ID: <xmqqposvw4fs.fsf@gitster.mtv.corp.google.com>
References: <17d30bb680a0452efd7b3c4f42e2f94478a86273.1462372716.git.johannes.schindelin@gmx.de>
	<cover.1462603453.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 09 19:04:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azoZO-0004pS-8L
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 19:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbcEIRCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 13:02:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62408 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751047AbcEIRCE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 13:02:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BACCF1AD07;
	Mon,  9 May 2016 13:02:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bm9XNHQkEPTuGTpqIyqBY5asHlw=; b=bh7XLj
	Wf9dla3FL6qZ7PAYepBsELOWJ/raYi2vi/TBu9cYmBI+R3B7MdANFbJ9kqU4mETE
	TXNJbebn8CiWTmT9QkN02K8ZGAIBddDu4NXuhL/fQnl/xvGKpwHT2M5uJjOwaR5t
	oFwYYWoge68331gDjCVQ6QwffWCwsxeLFzcKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=scrjnBarSfxdoOppI/f9q0gvIPI4dnMZ
	iW55MM6OalPGPwi8/UKsSUsrH9z2wLdG+s9e5ThMWCWH1OW3Plyziq6+Mkbs8IxQ
	3qFTT8uRb9RDlVUQlAXKw4B65iawFiwWmwyt2Yvb8URiut97WCslB0O/t+0hl+Xk
	z+7xfMiimGk=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AEADB1AD06;
	Mon,  9 May 2016 13:02:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 153371AD01;
	Mon,  9 May 2016 13:02:02 -0400 (EDT)
In-Reply-To: <cover.1462603453.git.johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Sat, 7 May 2016 08:44:42 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BFDE9BD4-1607-11E6-A260-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294018>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This is a heavily version of patches we carried in Git for Windows for
> way too long without submitting them upstream.
>
> In this iteration, I also claim authorship for the patch because by now
> Kusma's changes were so contorted and mutilated beyond recognition by me
> that I do not want anybody to blame him for my sins.

OK, so what do you want me to do with this "heavily modified
version"?  Earlier you responded:

    > I have a huge preference for a code that has been production for
    > years over a new code that would cook at most two weeks in 'next'.

    I agree. However, it does not fill me with confidence that we did not
    catch those two bugs earlier. Even one round of reviews (including a
    partial rewrite) was better than all that time since the regressions
    were introduced.

So do we want to follow the regular "a few days in 'pu' in case
somebody finds 'oops this trivial change is needed', a week or two
in 'next' for simmering as everybody else, and finally down to
'master'" schedule?
