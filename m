From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH MISC 1/1] Make gcc warning about empty if body go away.
Date: Wed, 07 Nov 2007 17:52:27 -0800
Message-ID: <7v1wb18pwk.fsf@gitster.siamese.dyndns.org>
References: <1194430832-6224-1-git-send-email-madcoder@debian.org>
	<1194430832-6224-2-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Nov 08 02:52:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpwZj-0001Xb-1n
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 02:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbXKHBwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 20:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbXKHBwg
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 20:52:36 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:53156 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbXKHBwf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 20:52:35 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id E72502F0;
	Wed,  7 Nov 2007 20:52:55 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 704E7935EC;
	Wed,  7 Nov 2007 20:52:51 -0500 (EST)
In-Reply-To: <1194430832-6224-2-git-send-email-madcoder@debian.org> (Pierre
	Habouzit's message of "Wed, 7 Nov 2007 11:20:26 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63921>

Pierre Habouzit <madcoder@debian.org> writes:

> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> @@ -204,7 +204,7 @@ static void refresh_index_quietly(void)
>  		if (write_cache(fd, active_cache, active_nr) ||
>  		    close(fd) ||
>  		    commit_locked_index(lock_file))
> -			; /*
> +			(void)0; /*
>  			   * silently ignore it -- we haven't mucked
>  			   * with the real index.
>  			   */

Ok, will apply after reindenting a bit, and adding a quote to
the description that I could not parse on the first reading:

	Make gcc warning about "empty if body" go away.

Thanks.
