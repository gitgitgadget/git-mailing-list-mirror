From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk: bug report: invalid command name "contmergediff"
Date: Mon, 20 Mar 2006 22:31:08 +1100
Message-ID: <17438.37500.547753.490054@cargo.ozlabs.ibm.com>
References: <20060308183718.GA9855@nospam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 20 12:31:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLIbY-00039h-Tz
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 12:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWCTLbS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Mar 2006 06:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWCTLbS
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 06:31:18 -0500
Received: from ozlabs.org ([203.10.76.45]:9925 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932186AbWCTLbR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Mar 2006 06:31:17 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 78548679E9; Mon, 20 Mar 2006 22:31:16 +1100 (EST)
To: git@wingding.demon.nl
In-Reply-To: <20060308183718.GA9855@nospam.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17748>

Rutger Nijlunsing writes:

> Bug report on gitk, maybe already reported.
> 
> do:
>    gitk HEAD~1000..
> 
> ...select first commit (why is this not done automatically?), and keep
> pressing down-arrow.
> 
> This gives me:
>    Error: invalid command name "contmergediff"

Ooooh, it does too!  Thanks, I'll fix that.

Paul.
