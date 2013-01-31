From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitremote-helpers.txt: rename from
 git-remote-helpers.txt
Date: Thu, 31 Jan 2013 14:45:12 -0800
Message-ID: <7vpq0ldlaf.fsf@alter.siamese.dyndns.org>
References: <7vfw1ijtz2.fsf@alter.siamese.dyndns.org>
 <fc96ae61bb64ce19e856d7a1624e2130c99afd47.1359662569.git.john@keeping.me.uk>
 <1359671290-ner-7089@calvin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Max Horn <max@quendi.de>, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Tomas Carnecky <tomas.carnecky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 23:45:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U12t0-0004eV-0G
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 23:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756964Ab3AaWpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 17:45:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43553 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755326Ab3AaWpO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 17:45:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BCB5BC68;
	Thu, 31 Jan 2013 17:45:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0PDFYufBUB/vUm7my9+dHs8iU7c=; b=ObX2rv
	VuQZqr55LA3A++QatmJ4d+D6Jpv5Amgh2YwxjMYRUlk4XL939UC8XyuS+hpwE3wf
	d5J10i/K7ckSRowLm/OjxtCij8kV0WCtOxWbY1RG9UCZYK/ycojDrym3vVfqrjGC
	AXwAvruB2W/B99V77LSalQRSA7fEKDpIQcE6c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q2qYxTiiqv9MApftBkPpwzcV+Bux1ZPQ
	XzPkbYKOTvbl1QBWi5oeXi4FQul7jMCYSbICjM5p/eOuS8JCZGQ3eqANu/08RshS
	BNsI0CAykSk8UPuewbb3oOJ8t0wVZYMjoTmV6JDpIqacTdq4vMmuwrh5biojVycH
	x7aa/rQpFL0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F4106BC67;
	Thu, 31 Jan 2013 17:45:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77E08BC63; Thu, 31 Jan 2013
 17:45:13 -0500 (EST)
In-Reply-To: <1359671290-ner-7089@calvin> (Tomas Carnecky's message of "Thu,
 31 Jan 2013 22:28:10 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E0139B9C-6BF7-11E2-9CA2-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215183>

Tomas Carnecky <tomas.carnecky@gmail.com> writes:

> On Thu, 31 Jan 2013 20:08:14 +0000, John Keeping <john@keeping.me.uk> wrote:
>> This is the patch to rename it to "gitremote-helpers.txt".
>> 
>>  Documentation/{git-remote-helpers.txt => gitremote-helpers.txt} | 6 +++---
>
> It feels somewhat weird to have 'git-remote' but 'gitremote-helpers'.

But the remote helpers are not helpers to "git remote" (which is
essentially a glorified wrapper around "git config -l remote.*").
