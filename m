From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] difftool: add support for an extended revision syntax
Date: Fri, 27 Mar 2009 10:21:24 -0700
Message-ID: <7vab76evaj.fsf@gitster.siamese.dyndns.org>
References: <1237803348-9329-1-git-send-email-davvid@gmail.com>
 <m33acz2byv.fsf@localhost.localdomain> <20090327162849.GA2853@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org, spearce@spearce.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 18:23:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnFlo-00069T-KO
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 18:23:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755068AbZC0RVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 13:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754663AbZC0RVh
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 13:21:37 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42911 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643AbZC0RVg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 13:21:36 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 39DA1971A;
	Fri, 27 Mar 2009 13:21:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 534FE9719; Fri,
 27 Mar 2009 13:21:28 -0400 (EDT)
In-Reply-To: <20090327162849.GA2853@gmail.com> (David Aguilar's message of
 "Fri, 27 Mar 2009 09:28:49 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B87D0D42-1AF3-11DE-A653-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114915>

David Aguilar <davvid@gmail.com> writes:

> I'm still interested in the file~<n> idea [though maybe not
> that exact syntax] and have been reading revision.c (as Junio
> suggested) to see if it can be done in a good way.

I'll send a comment in a separate message.

> I noticed that my patches for "add tests to difftool" and "add
> the -y shortcut for --no-prompt" were in git.git's pu branch
> the other day but aren't there anymore.  Was that intentional?

Yes, it makes 'pu' not pass the self test.
