From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Display commit messages with word wrap
Date: Mon, 15 May 2006 09:34:05 +1000
Message-ID: <17511.48749.631725.358279@cargo.ozlabs.ibm.com>
References: <20060514151456.GA18012@procyon.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 01:34:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfQ6s-00074l-Fq
	for gcvg-git@gmane.org; Mon, 15 May 2006 01:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWENXes (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 19:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWENXes
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 19:34:48 -0400
Received: from ozlabs.org ([203.10.76.45]:953 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751377AbWENXer (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 May 2006 19:34:47 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 7A891679EF; Mon, 15 May 2006 09:34:46 +1000 (EST)
To: Sergey Vlasov <vsu@altlinux.ru>
In-Reply-To: <20060514151456.GA18012@procyon.home>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19993>

Sergey Vlasov writes:

> Some people put very long strings into commit messages, which then
> become invisible in gitk (word wrapping in the commit details window is
> turned off, and there is no horizontal scroll bar).  Enabling word wrap
> for just the commit message looks much better.

Well... you can scroll in any direction with mouse button 2, but ok...

> +    $ctext insert end "\n" {}

Why are you adding the superfluous {} ?

> -    set comment {}
> +    set headers {}

Why are you changing the name here?  Your commit description doesn't
address either of these points.

Paul.
