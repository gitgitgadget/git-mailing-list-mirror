From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH 4/4] templates: add an example pre-auto-gc hook
Date: Mon, 31 Mar 2008 14:30:35 -0400
Message-ID: <E75A6ACE-8EF2-4B12-B591-35C9092FCD9A@silverinsanity.com>
References: <283c63fb960d36a322b45fac97804af18a9e5abe.1206929014.git.vmiklos@frugalware.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bj?rn Steinbrink <B.Steinbrink@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Mar 31 20:55:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgPAD-0002E2-AH
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 20:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753735AbYCaSym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 14:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753515AbYCaSym
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 14:54:42 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:54358 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbYCaSyl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 14:54:41 -0400
X-Greylist: delayed 1439 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Mar 2008 14:54:41 EDT
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 442791FFC01E;
	Mon, 31 Mar 2008 18:30:41 +0000 (UTC)
In-Reply-To: <283c63fb960d36a322b45fac97804af18a9e5abe.1206929014.git.vmiklos@frugalware.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78598>


On Mar 31, 2008, at 5:37 AM, Miklos Vajna wrote:

> +# An example hook script to verify if you are on battery.  Called by
> +# git-gc --auto with no arguments.  The hook should exit with non- 
> zero
> +# status after issuing an appropriate message if it wants to stop the
> +# auto repacking.
> +#
> +# To enable this hook, make this file executable.

You probably want to mention that this example hook is Linux-specific.

~~ Brian G.
