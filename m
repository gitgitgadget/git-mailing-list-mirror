From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] git-submodule: use get_remote in
 resolve_relative_url
Date: Sun, 24 Aug 2008 11:55:54 -0700
Message-ID: <7v4p5ansxx.fsf@gitster.siamese.dyndns.org>
References: <1219598500-8334-1-git-send-email-davvid@gmail.com>
 <e21617f50ffaae98ab73fa364e40440397bcbe33.1219598198.git.davvid@gmail.com>
 <341166c1e31ba26c4e8e48cd7cf9ce12a9f745b9.1219598198.git.davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mlevedahl@gmail.com, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 20:57:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXKlx-0002wI-5f
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 20:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882AbYHXS4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 14:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752409AbYHXS4D
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 14:56:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44535 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599AbYHXS4D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 14:56:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9AB2D6DAC0;
	Sun, 24 Aug 2008 14:56:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 12A266DA80; Sun, 24 Aug 2008 14:55:56 -0400 (EDT)
In-Reply-To: <341166c1e31ba26c4e8e48cd7cf9ce12a9f745b9.1219598198.git.davvid@gmail.com>
 (David Aguilar's message of "Sun, 24 Aug 2008 10:21:39 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4B1B8FBE-720E-11DD-9339-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93547>

David Aguilar <davvid@gmail.com> writes:

> This change removes replaces the remote finding logic in
> resolve_relative_url with the new get_remote function.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>

I think these first two patches should be squashed into one, with a title
"git-submodule: refactor logic to find the remote from the current branch".

If you agree, I'll do that myself -- no need to resend; please just say
the word.
