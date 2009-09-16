From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: restore wm state to normal before saving geometry information
Date: Wed, 16 Sep 2009 20:21:37 +1000
Message-ID: <19120.48177.116508.251237@cargo.ozlabs.ibm.com>
References: <1252437756-81986-1-git-send-email-snaury@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexey Borzenkov <snaury@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 12:37:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnrsj-0006MF-L6
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 12:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbZIPKgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 06:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbZIPKgv
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 06:36:51 -0400
Received: from ozlabs.org ([203.10.76.45]:56922 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751068AbZIPKgv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 06:36:51 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id AF74AB7B7B; Wed, 16 Sep 2009 20:36:53 +1000 (EST)
In-Reply-To: <1252437756-81986-1-git-send-email-snaury@gmail.com>
X-Mailer: VM 8.0.12 under 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128639>

Alexey Borzenkov writes:

> gitk now includes patches for saving and restoring wm state, however
> because it saves wm geometry when window can still be maximized the
> maximize/restore button becomes useless after restarting gitk (you
> will get a huge displaced window if you try to restore it). This
> patch fixes this issue by storing window geometry in normal state.

Hmmm, shouldn't we be also saving the window state (zoomed/normal) and
restoring that as well?

Paul.
