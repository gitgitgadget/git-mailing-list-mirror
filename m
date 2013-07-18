From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] blame-options.txt: place each -L option variation on its own line
Date: Thu, 18 Jul 2013 10:51:17 -0700
Message-ID: <7vvc473gfe.fsf@alter.siamese.dyndns.org>
References: <1374096332-7891-1-git-send-email-sunshine@sunshineco.com>
	<1374096332-7891-6-git-send-email-sunshine@sunshineco.com>
	<87hafs84jc.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>, <git@vger.kernel.org>,
	Bo Yang <struggleyb.nku@gmail.com>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Thu Jul 18 19:51:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzsMP-0007nI-00
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 19:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759284Ab3GRRvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 13:51:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59533 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759037Ab3GRRvU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 13:51:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F7D8310C1;
	Thu, 18 Jul 2013 17:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jyl7hKvxiLQj+t31paQ1OLifSyQ=; b=veNAOY
	DpK4bkeK3xA4ySHBUJ9c3hcrtq2OFMgf395uRK7DuInfnc/WG8ZBZu2N1Q6FS0Jw
	jlGIwM03+71T8DWwvJRMP5VeG1yefdda+EOzUpeFQ4XM1RDj/4J0JsZ51/8TXYYv
	dgw5Tpsqlm4Jv1EFXvRjsjPVUTpc6VpqKjg7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aUCZ4P1u4tEKlDnLYGThkHTuBc4QgMFh
	sy1mYDpi8BIKBl9TMLiun+fUVdXaVE2PwWCGyvRYJ+R8Zw4l1h4RSOQ5TCLP0l5U
	T/JAzmBIeU87jCLfb6ztpF2iodFx7I3zxIML08MHG9GL2HliD8hnZHoBbDEeFWtX
	JLQJfX8llbw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13A50310C0;
	Thu, 18 Jul 2013 17:51:20 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50F1F310B6;
	Thu, 18 Jul 2013 17:51:19 +0000 (UTC)
In-Reply-To: <87hafs84jc.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Thu, 18 Jul 2013 13:56:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A6B237DC-EFD2-11E2-80F5-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230716>

Thomas Rast <tr@thomasrast.ch> writes:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> Standard practice in Git documentation is for each variation of an
>> option (such as: -p / --porcelain) to be placed on its own line in the
>> OPTIONS table. The -L option does not follow suit. It cuddles
>> "-L <start>,<end>" and "-L :<regex>", separated by a comma. This is
>> inconsistent and potentially confusing since the comma separating them
>> is typeset the same as the comma in "<start>,<end>". Fix this by placing
>> each variation on its own line.
>
> Ok, but why not fix them all in one go?
>
> Edited to remove the false positives:
>
> $ git grep -n '^.*,.*::$' Documentation/*.txt
> Documentation/blame-options.txt:12:-L <start>,<end>, -L :<regex>::
> Documentation/config.txt:1252:gitcvs.dbuser, gitcvs.dbpass::
> Documentation/config.txt:1513:http.lowSpeedLimit, http.lowSpeedTime::
> Documentation/git-add.txt:90:-e, \--edit::
> Documentation/git-check-attr.txt:22:-a, --all::
> Documentation/git-check-ignore.txt:26:-q, --quiet::
> Documentation/git-check-ignore.txt:30:-v, --verbose::
> Documentation/git-check-ignore.txt:42:-n, --non-matching::
> Documentation/git-log.txt:65:-L <start>,<end>:<file>, -L :<regex>:<file>::
> Documentation/git-log.txt:156:git log -L '/int main/',/^}/:main.c::
> Documentation/git-p4.txt:171:--verbose, -v::
> Documentation/git-p4.txt:282:--dry-run, -n::

Thanks, but I think it is cleaner to fix the others in a separate
"treewide clean-up" patch.

Also I wonder if this one Documentation/git-log.txt:156

    git log -L '/int main/',/^}/:main.c

should be more like one of these:

    git log -L '/int main/,/^}/':main.c
    git log -L '/int main/,/^}/:main.c'

I find it somewhat hard to spot the closing sq in the middle of a
string.
