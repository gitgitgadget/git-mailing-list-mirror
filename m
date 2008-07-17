From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/gitignore.txt: Clarify gitignore vs
 tracked files
Date: Thu, 17 Jul 2008 11:16:59 -0700
Message-ID: <7vabgggyuc.fsf@gitster.siamese.dyndns.org>
References: <20080717163622.12592.29919.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jul 17 20:18:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJY3M-0004OS-RF
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 20:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758038AbYGQSRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 14:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758036AbYGQSRI
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 14:17:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46756 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757939AbYGQSRG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 14:17:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A24172995C;
	Thu, 17 Jul 2008 14:17:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 02D1D2995A; Thu, 17 Jul 2008 14:17:01 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8F10B6CC-542C-11DD-8861-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88895>

Petr Baudis <pasky@suse.cz> writes:

> -git should ignore.  Each line in a `gitignore` file specifies a
> -pattern.
> +git should ignore.
> +Note that all the `gitignore` files really concern only files
> +that are not already tracked by git; there is no direct mechanism
> +to make git ignore your local modifications in already tracked files.

Thanks.

I'd suggest dropping everything after ';'.

 - If you want to keep local changes without ever checking in, you can do
   so by making partial commits.

 - You could mark these paths "assume unchanged".
