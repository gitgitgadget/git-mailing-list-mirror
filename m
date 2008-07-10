From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] imap-send.c: Clean up coding style to better match
 the rest of the git codebase.
Date: Wed, 09 Jul 2008 19:18:11 -0700
Message-ID: <7vod56scrg.fsf@gitster.siamese.dyndns.org>
References: <1215638942-25010-3-git-send-email-robertshearman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Shearman <robertshearman@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 04:19:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGll2-0008LC-CQ
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 04:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193AbYGJCSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 22:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752879AbYGJCSd
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 22:18:33 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49394 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbYGJCSd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 22:18:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0A00B23C46;
	Wed,  9 Jul 2008 22:18:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 14D6A23C43; Wed,  9 Jul 2008 22:18:24 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7D627958-4E26-11DD-8921-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87931>

Robert Shearman <robertshearman@gmail.com> writes:

> -	else if (!strcmp( "ssl_verify", key ))
> -		server.ssl_verify = git_config_bool( key, val );
> +	else if (!strcmp("sslverify", key))
> +		server.ssl_verify = git_config_bool(key, val);

This is not a style fix.  Output from "size imap-send.o" before and after
a style fix patch should exactly match.

I'll fix up in the earlier one [2/4] so that this becomes a pure style
fix, so no need to resend.
