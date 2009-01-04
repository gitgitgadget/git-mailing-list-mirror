From: Karl Chen <quarl@cs.berkeley.edu>
Subject: Re: git-branch --print-current
Date: Sat, 03 Jan 2009 18:18:36 -0800
Message-ID: <quack.20090103T1818.lth7i5bg6f7@roar.cs.berkeley.edu>
References: <quack.20090101T1928.lthzliaqtdf@roar.cs.berkeley.edu>
	<402731c90901012026j470f35ffj1eaa189a837054f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git mailing list" <git@vger.kernel.org>
To: "David Aguilar" <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 04 03:20:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJIax-0006gM-9V
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 03:20:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbZADCSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 21:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbZADCSn
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 21:18:43 -0500
Received: from roar.CS.Berkeley.EDU ([128.32.36.242]:44402 "EHLO
	roar.quarl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750870AbZADCSm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 21:18:42 -0500
Received: by roar.quarl.org (Postfix, from userid 18378)
	id 987B1344E0; Sat,  3 Jan 2009 18:18:36 -0800 (PST)
X-Quack-Archive: 1
In-Reply-To: <402731c90901012026j470f35ffj1eaa189a837054f3@mail.gmail.com> (David Aguilar's message of "Thu\, 1 Jan 2009 20\:26\:29 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104491>

>>>>> On 2009-01-01 20:26 PST, David Aguilar writes:

    David> You might want to use 'git symbolic-ref' instead.

    David> $ git symbolic-ref HEAD | sed -e 's,refs/heads/,,'
    David> master

Thanks, that is better.

How about an option to git-symbolic-ref that gets rid of the
refs/heads/ ?
