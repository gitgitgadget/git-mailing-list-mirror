From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] INSTALL: Describe dependency knobs from Makefile
Date: Tue, 08 Sep 2009 23:16:08 -0700
Message-ID: <7vpra0hcd3.fsf@alter.siamese.dyndns.org>
References: <1252461061-75840-1-git-send-email-brian@gernhardtsoftware.com>
 <1252461061-75840-4-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Wed Sep 09 08:16:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlGTf-000184-3v
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 08:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbZIIGQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 02:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbZIIGQM
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 02:16:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63060 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbZIIGQM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 02:16:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C54332B43E;
	Wed,  9 Sep 2009 02:16:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tjDQ4HMyzQVOfb3q4vadYccfzwE=; b=hSK8ec
	CGhBy1AhT2rlxdF3rPf4ptzu6LZijnIbHusE8c9pe0cB3Am3RsK0Qhv1r+rg6BBe
	+MATo//JgkK6Qvv+CZLc1gmSX9GkiHR+iaQgZ7T6rqKNqbQoyy/0j/oZBYwr/KQz
	ZZOC9BRYPl+f+mRKG7cxNrWdi0Dh+w+2ozahk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rakg9Y4nAoV0VE+FQp+kr2JdejKzXdQ9
	C0nGbq6nQxueavTIC6MxmFJPgNXrzevxwZUpEogiMA8b5+MziVc89Nq8j3A0ppfd
	zlcQMT9tSyF8OAPicrbtz+s/fjro09cOAVkjfJWgnV6cobxRtyUZ5QvXxgbVhxY+
	VTT7c/AhzCg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A86282B43C;
	Wed,  9 Sep 2009 02:16:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE2FD2B43B; Wed,  9 Sep
 2009 02:16:09 -0400 (EDT)
In-Reply-To: <1252461061-75840-4-git-send-email-brian@gernhardtsoftware.com>
 (Brian Gernhardt's message of "Tue\,  8 Sep 2009 21\:51\:01 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 45F467CE-9D08-11DE-A6F3-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128057>

Brian Gernhardt <brian@gernhardtsoftware.com> writes:

> +There are many options that can be configured in the makefile using either
> +command line defines or a config.mak file.  These options are documented at
> +the beginning of the Makefile.
> +

I did not like calling "make variables" "options", and also it was unclear
what good these "options" are for.  How about...

    The beginning of the Makefile documents many variables that affect the way
    git is built.  You can override them either from the command line, or in a
    config.mak file.
