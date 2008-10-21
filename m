From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 7/7] gitk: Explicitly position popup windows.
Date: Tue, 21 Oct 2008 22:41:52 +1100
Message-ID: <18685.49152.25344.398737@cargo.ozlabs.ibm.com>
References: <1223449540-20457-1-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-2-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-3-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-4-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-5-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-6-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-7-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-8-git-send-email-angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 13:43:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsFdr-0003wK-Lq
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 13:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753793AbYJULmD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 07:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753796AbYJULmD
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 07:42:03 -0400
Received: from ozlabs.org ([203.10.76.45]:33929 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752180AbYJULmB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 07:42:01 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 52D3EDDDE7; Tue, 21 Oct 2008 22:41:58 +1100 (EST)
In-Reply-To: <1223449540-20457-8-git-send-email-angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98777>

Alexander Gavrilov writes:

> For some reason, on Windows all transient windows are placed
> in the upper left corner of the screen. Thus, it is necessary
> to explicitly position the windows using the tk::PlaceWindow
> function.

Hmmm, this is not part of the official Tk API as far as I can see, and
having to call tk::PlaceWindow on every window we create is a bit
gross.  What exactly does it do, and what effect will this change have
on Linux?  Are you sure there isn't some other way to fix the problem?

Paul.
