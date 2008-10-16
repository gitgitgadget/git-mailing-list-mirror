From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/7] gitk: Enhance UI popup and accelerator handling.
Date: Fri, 17 Oct 2008 08:55:38 +1100
Message-ID: <18679.47194.852924.385301@cargo.ozlabs.ibm.com>
References: <1223449540-20457-1-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-2-git-send-email-angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 23:57:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqaqD-0006h4-MP
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 23:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755490AbYJPVz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 17:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755461AbYJPVz5
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 17:55:57 -0400
Received: from ozlabs.org ([203.10.76.45]:39684 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754852AbYJPVz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 17:55:56 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 4BA73DDF0A; Fri, 17 Oct 2008 08:55:45 +1100 (EST)
In-Reply-To: <1223449540-20457-2-git-send-email-angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98427>

Alexander Gavrilov writes:

> - Popups are supposed to be marked transient, otherwise
>   the WM creates them in strange places. Besides, at
>   least under kwin, transients are automatically kept
>   above their parent.

I agree with most of the places where you add wm transient commands,
but in the case of the list of references (showrefs), I think of that
as a long-lived window that one would normally place beside the main
window.  (In fact, it should be a pane in the main window, but I
couldn't think of a place for it.  Maybe I should split the
bottom-right pane in two.)

So I don't think the wm transient in showrefs is what we want.
Comments?

Paul.
