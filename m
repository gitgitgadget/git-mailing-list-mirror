From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: Commit through git.el evades commit hook
Date: Sat, 27 Jan 2007 09:32:17 +0100
Message-ID: <87fy9wvpim.fsf@wine.dyndns.org>
References: <17850.36539.972386.69800@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Sat Jan 27 09:32:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAizJ-0008Gp-N4
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 09:32:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbXA0IcW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 03:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbXA0IcW
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 03:32:22 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:57062 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbXA0IcV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 03:32:21 -0500
Received: from adsl-84-227-128-239.adslplus.ch ([84.227.128.239] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HAiyx-0006Kn-OC; Sat, 27 Jan 2007 02:32:20 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 4F5E34FB65; Sat, 27 Jan 2007 09:32:17 +0100 (CET)
In-Reply-To: <17850.36539.972386.69800@lisa.zopyra.com> (Bill Lear's message of "Fri\, 26 Jan 2007 17\:28\:59 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37932>

Bill Lear <rael@zopyra.com> writes:

> Apparently git.el does not invoke the commit hook when committing a
> file.  This seems like an egregious error.  Am I perhaps overlooking
> something obvious?

No, you are right, it's not implemented, mainly because nobody had
asked for it yet... It shouldn't be hard to add.

-- 
Alexandre Julliard
julliard@winehq.org
