From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (GITK) v3 6/6] gitk: Explicitly position popup windows.
Date: Mon, 10 Nov 2008 22:47:37 +1100
Message-ID: <18712.8025.148318.526469@cargo.ozlabs.ibm.com>
References: <1225652389-22082-1-git-send-email-angavrilov@gmail.com>
	<1225652389-22082-7-git-send-email-angavrilov@gmail.com>
	<18708.11537.229423.296701@cargo.ozlabs.ibm.com>
	<200811091753.31198.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 12:49:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzVGf-0002Cm-M8
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 12:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574AbYKJLrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 06:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754568AbYKJLrv
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 06:47:51 -0500
Received: from ozlabs.org ([203.10.76.45]:47879 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754396AbYKJLrt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 06:47:49 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 8AE73DDDFF; Mon, 10 Nov 2008 22:47:48 +1100 (EST)
In-Reply-To: <200811091753.31198.angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100518>

Alexander Gavrilov writes:

> I don't know about MacOS, but in Linux it does seem unnecessary, so:

OK.  Do you mostly develop on windows or on linux?

> +    if {$::tcl_platform(platform) ne {windows}} return

Any particular reason why you used $tcl_platform(platform) rather than
if {[tk windowingsystem] != "win32"} like we do elsewhere in gitk?

Paul.
