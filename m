From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/7] gitk: Enhance UI popup and accelerator handling.
Date: Tue, 21 Oct 2008 22:35:55 +1100
Message-ID: <18685.48795.892869.474750@cargo.ozlabs.ibm.com>
References: <1223449540-20457-1-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-2-git-send-email-angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 13:44:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsFej-0004Fu-2v
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 13:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753807AbYJULmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 07:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752776AbYJULmJ
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 07:42:09 -0400
Received: from ozlabs.org ([203.10.76.45]:33935 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753807AbYJULmB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 07:42:01 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 6662FDDDEC; Tue, 21 Oct 2008 22:41:59 +1100 (EST)
In-Reply-To: <1223449540-20457-2-git-send-email-angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98780>

Alexander Gavrilov writes:

> - Popups are supposed to be marked transient, otherwise
>   the WM creates them in strange places. Besides, at
>   least under kwin, transients are automatically kept
>   above their parent.
> - Accelerators for menu items should be listed directly
>   on the items, to make them more discoverable.
> - Some more accelerators are added, e.g. F4 for Edit View.
> - Finally, dialogs can now be accepted or dismissed using
>   the Return and Escape keys.

Could you rebase this and split it into 3 patches, one each for the
transient popups, accelerators, and return/escape key bindings?

Thanks,
Paul.
