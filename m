From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (GITK)] gitk: Fix transient windows on Win32 and MacOS.
Date: Thu, 13 Nov 2008 22:41:45 +1100
Message-ID: <18716.4729.74357.207955@cargo.ozlabs.ibm.com>
References: <200811112355.43352.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 12:44:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0acs-0005Jw-Ib
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 12:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbYKMLnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 06:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbYKMLnS
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 06:43:18 -0500
Received: from ozlabs.org ([203.10.76.45]:44177 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710AbYKMLnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 06:43:16 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 17819DDE01; Thu, 13 Nov 2008 22:43:15 +1100 (EST)
In-Reply-To: <200811112355.43352.angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100864>

Alexander Gavrilov writes:

> Transient windows cause problems on these platforms:
> 
> - On Win32 the windows appear in the top left corner
>   of the screen. In order to fix it, this patch causes
>   them to be explicitly centered on their parents by
>   an idle handler.
> 
> - On MacOS with Tk 8.4 they appear without a title bar.
>   Since it is clearly unacceptable, this patch disables
>   transient on that platform.
> 
> Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>

Thanks, applied.
Paul.
