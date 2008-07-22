From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Enable threaded delta search on *BSD and Linux.
Date: Mon, 21 Jul 2008 21:54:14 -0700
Message-ID: <7vwsjeplhl.fsf@gitster.siamese.dyndns.org>
References: <1216632223-14655-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Jul 22 06:55:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL9uF-0006hR-KN
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 06:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbYGVEyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 00:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbYGVEyY
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 00:54:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64689 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbYGVEyX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 00:54:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 866EF334B3;
	Tue, 22 Jul 2008 00:54:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 92934334B2; Tue, 22 Jul 2008 00:54:18 -0400 (EDT)
In-Reply-To: <1216632223-14655-1-git-send-email-madcoder@debian.org> (Pierre
 Habouzit's message of "Mon, 21 Jul 2008 11:23:43 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3FAD7530-57AA-11DD-8D6F-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pierre Habouzit <madcoder@debian.org> writes:

> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>
>   Following the discussion we had 10 days ago, here is a proposal to enable
>   threaded delta search on systems that are likely to behave properly wrt
>   memory and CPU usage.

Hmmm.

I do not want to do this kind of thing very close to the release (like
now), but rather immediately after 1.6.0.  Will queue for 'next'.

Distro people can decide for themselves and their users, but I am of
conservative kind.
