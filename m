From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (GITK) v3 2/6] gitk: Make gitk dialog windows transient.
Date: Fri, 7 Nov 2008 22:41:42 +1100
Message-ID: <18708.10614.736592.271950@cargo.ozlabs.ibm.com>
References: <1225652389-22082-1-git-send-email-angavrilov@gmail.com>
	<1225652389-22082-2-git-send-email-angavrilov@gmail.com>
	<1225652389-22082-3-git-send-email-angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 12:53:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyPuJ-0003HL-PR
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 12:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbYKGLwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 06:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752265AbYKGLwJ
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 06:52:09 -0500
Received: from ozlabs.org ([203.10.76.45]:52043 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751474AbYKGLwF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 06:52:05 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id CF5BDDDE21; Fri,  7 Nov 2008 22:52:03 +1100 (EST)
In-Reply-To: <1225652389-22082-3-git-send-email-angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100307>

Alexander Gavrilov writes:

> Transient windows are always kept above their parent,
> and don't occupy any space in the taskbar, which is useful
> for dialogs. Also, when transient is used, it is important
> to bind windows to the correct parent.
> 
> This commit adds transient annotations to all dialogs,
> ensures usage of the correct parent for error and
> confirmation popups, and, as a side job, makes gitk
> preserve the create tag dialog window in case of errors.
> 
> Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>

Thanks, applied.

Paul.
