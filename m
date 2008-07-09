From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: Fix authenticating on some servers when
 using TLS.
Date: Wed, 09 Jul 2008 15:51:09 -0700
Message-ID: <7v1w227jtu.fsf@gitster.siamese.dyndns.org>
References: <1215639580-25040-1-git-send-email-robertshearman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Shearman <robertshearman@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 00:52:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGiWG-0003PA-Bc
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 00:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbYGIWvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 18:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbYGIWvR
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 18:51:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57324 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbYGIWvR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 18:51:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9F6F41C10D;
	Wed,  9 Jul 2008 18:51:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1C73A1C10A; Wed,  9 Jul 2008 18:51:11 -0400 (EDT)
In-Reply-To: <1215639580-25040-1-git-send-email-robertshearman@gmail.com>
 (Robert Shearman's message of "Wed, 9 Jul 2008 22:39:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 88B7D0B8-4E09-11DD-AF10-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87923>

Robert Shearman <robertshearman@gmail.com> writes:

> Send hello after a successful STARTTLS command to refresh the list of extensions. These may be different to what is returned over a clear connection (for example the AUTH command may be accepted over a secure connection, but not over a clear connection).
>
> Furthermore, this behaviour is recommended by RFC 2487 (http://www.ietf.org/rfc/rfc2487.txt).

Very true.  Thanks.
