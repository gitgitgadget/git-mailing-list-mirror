From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-push: Accept -n as a synonym for --dry-run.
Date: Sat, 12 Sep 2009 22:18:12 -0700
Message-ID: <7vhbv72zjf.fsf@alter.siamese.dyndns.org>
References: <1252800302-26560-1-git-send-email-nelhage@mit.edu>
 <7vfxar5zsi.fsf@alter.siamese.dyndns.org> <20090913034031.GO4275@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nelson Elhage <nelhage@MIT.EDU>
X-From: git-owner@vger.kernel.org Sun Sep 13 07:20:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmhVY-0004U6-Ge
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 07:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbZIMFSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 01:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbZIMFSU
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 01:18:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49189 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbZIMFST (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 01:18:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5E9E14ED25;
	Sun, 13 Sep 2009 01:18:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4Ej3TlbMyfL9ez0y1mUm+P+Vgt0=; b=l1vdeS
	wuR4hqm2qyz+wIDZ5eXJOhQWKQ0qmqaX3FK/JEyaH8pD9/2n2nisU6MBlRtftMRb
	TocMjjOWTFG61yE3ViHBwplQVu/BTI48CDdsl+yaVUC371280qroEyFs9NzbwNPO
	LBzmoeRvHuM/oLkedTYZgUhrTwpZlrNpZ4ELA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SMvW+GtaI7IxWBMMAzs94HUy6FeVka8u
	AYM0jjAXjyPseHGN/WtFgLT26yaslCowuxtQvdFrCsM4fAs1hhYYsdMkfnD3j8Ho
	TsByZ9MYztUkBKsYoe6IsotxvwpoNkKA4yUXXOkeKR/3/hM7D0/+GdF5XdRAfw6t
	XdwTsfd4G5I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 382294ED24;
	Sun, 13 Sep 2009 01:18:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1DEA24ED23; Sun, 13 Sep 2009
 01:18:13 -0400 (EDT)
In-Reply-To: <20090913034031.GO4275@mit.edu> (Nelson Elhage's message of
 "Sat\, 12 Sep 2009 23\:40\:31 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D8A48D78-A024-11DE-9790-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128333>

Nelson Elhage <nelhage@MIT.EDU> writes:

>> commit, push (as you identified), reflog, and send-email have --dry-run
>> but -n is not a synonym for it.  Some of them even use -n as a shorthand
>> for a more often used option than --dry-run.
>
> Can you point to an example of a git command supporting --dry-run, and
> using -n for something else?

Doesn't commit -n stand for no-verify?  I think that is how it is
documented.

> In fact, reflog already supports '-n' to mean dry-run,

Huh?  "git reflog -n 4" is for show-four-entries-from-the-top.
