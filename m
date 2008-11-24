From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/4] Teach git fetch to verify signed tags
 automatically
Date: Sun, 23 Nov 2008 20:53:23 -0800
Message-ID: <7v4p1xohbw.fsf@gitster.siamese.dyndns.org>
References: <1227497000-8684-1-git-send-email-deskinm@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Mon Nov 24 05:55:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4TTT-0004BV-Rj
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 05:55:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbYKXExm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2008 23:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbYKXExm
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Nov 2008 23:53:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57218 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbYKXExl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2008 23:53:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 700CE16BA2;
	Sun, 23 Nov 2008 23:53:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3E18216BA0; Sun,
 23 Nov 2008 23:53:25 -0500 (EST)
In-Reply-To: <1227497000-8684-1-git-send-email-deskinm@umich.edu> (Deskin
 Miller's message of "Sun, 23 Nov 2008 22:23:16 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DC39B198-B9E3-11DD-884D-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101589>

Deskin Miller <deskinm@umich.edu> writes:

> It struck me a while back when I fetched a new tagged release from git.git that
> if I wanted to verify the tag's signature, I'd have to issue another command to
> do so.  Shouldn't git be able to do that for me automatically, when it fetches
> signed tags?  Now it does.  Also, 'git remote update' gets this for free.

I think this should be done inside your own hook.  Not interested at all
in a solution to touch builtin-fetch.c, unless if the patch is about
adding a new hook so that people with other needs can use it as well.
