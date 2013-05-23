From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] Add new git-related helper to contrib
Date: Thu, 23 May 2013 11:34:26 -0700
Message-ID: <7vzjvleea5.fsf@alter.siamese.dyndns.org>
References: <1368978823-18247-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4gyizti.fsf@alter.siamese.dyndns.org>
	<CAMP44s0pXLmjVUwsVWiN2G5QReh80spXjvy_6GuUGRz1RmUbLQ@mail.gmail.com>
	<7vd2siiqsr.fsf@alter.siamese.dyndns.org>
	<CAMP44s2ETSxebGxXJV_BYEqTC5gJMVdQLbnTUomrie2rHhdmDg@mail.gmail.com>
	<7v8v36iq3e.fsf@alter.siamese.dyndns.org>
	<7v4nduipvb.fsf@alter.siamese.dyndns.org>
	<7vzjvmh98r.fsf@alter.siamese.dyndns.org>
	<CAMP44s1_=HSgZA=abHJ3sgDbUyfkF78qO+sR1+Aact3o7bAgLA@mail.gmail.com>
	<7vvc6ah81g.fsf@alter.siamese.dyndns.org>
	<CAMP44s37a0_wVVef+QVnLNvc8Uos_XpCZAtpX0RmQyMcuJHUHw@mail.gmail.com>
	<CAMP44s18ps9JtY7+mvXVbuZu3cm7bHnK1vCzMWqBdvawLr+zzA@mail.gmail.com>
	<7v8v35hc11.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 23 20:34:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfaLS-00062R-O9
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 20:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758580Ab3EWSea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 14:34:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52015 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758180Ab3EWSe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 14:34:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A18C421D7E;
	Thu, 23 May 2013 18:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i/Ae2JBPPk9dSOcHSm95wbymedU=; b=kQKNSA
	VLWE+WPELHgQhIYMmY7bIjyaZT0BLKCPgjSCj/CB2KFcauC8aX7tF3dn+VALExs1
	3QQRToMe73k4yg/ncM3uLHpfpqnXIzMz9FiKrDhl040d1bm+Zk2a5OdhOebMgb/b
	P+fWxZLoVnoPkFS1/KifyUjTytf+7npkw+3o4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BiGGFMhi/7Gw7ynYgiSQDcZhuIDcuo9h
	JTble0jS4/sMPEtrX/59XSLjgM8dpyUZUkSBst1vS5dQP0uj6C6raZKJ+/Q8SWL4
	I652YPD9YjV23vyiPVAZdiMJoOA54Zzyp4QRCpDo1AmfBYL1VMDYvU8yG8PIu2/W
	zQDmzNJiNUE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 980BA21D7D;
	Thu, 23 May 2013 18:34:28 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C58F321D7B;
	Thu, 23 May 2013 18:34:27 +0000 (UTC)
In-Reply-To: <7v8v35hc11.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 23 May 2013 09:54:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 666B041E-C3D7-11E2-A52A-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225280>

Junio C Hamano <gitster@pobox.com> writes:

> Users of full-output may want to be able to see the same thing.

... but I agree we may be able to cheat if we only want to support
interactive, and we do want to find a way to cheat when we are
running interactive without having to store much more information in
each blame_entry.

> Imagine that your scoreboard originally has three blocks of text
> ...
> in that situation?

(I snipped everything I said in the previous reply only for
brevity but they are still relevant).

I _think_ one way to "cheat" without storing too much information in
each blame_entry is to first make a copy of all the original blame
entries that share the "suspect", see if any line in the line range
represented by each of the blame entries ended up being blamed to an
origin with a path different from that of the "suspect".  And print
those original blame entries that fits the criterion as additional
"these are not the final blame as you are digging with the option to
detect copy across files, but at this commit this line appeared anew
as far as the origin->path is concerned" output.

So I think you were going in the right direction (in other words,
the patch inserted new code to the right places), even though you
may have got the details in what the new code should do wrong.
