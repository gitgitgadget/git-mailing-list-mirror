From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: restore pane sizes when using ttk widgets
Date: Fri, 1 May 2009 09:47:52 +1000
Message-ID: <18938.14504.726502.235277@cargo.ozlabs.ibm.com>
References: <873ac8m8jg.fsf@users.sourceforge.net>
	<18920.32172.162401.593355@cargo.ozlabs.ibm.com>
	<87vdp39d92.fsf_-_@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri May 01 01:48:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lzfzh-0006UF-4z
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 01:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773AbZD3XsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 19:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761432AbZD3XsF
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 19:48:05 -0400
Received: from bilbo.ozlabs.org ([203.10.76.25]:38409 "EHLO bilbo.ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761209AbZD3XsE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 19:48:04 -0400
Received: by bilbo.ozlabs.org (Postfix, from userid 1003)
	id 0C5CBB7080; Fri,  1 May 2009 09:48:03 +1000 (EST)
In-Reply-To: <87vdp39d92.fsf_-_@users.sourceforge.net>
X-Mailer: VM 8.0.12 under 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118051>

Pat Thoyts wrote:

>   This patch applies the saved pane sizes for the ttk widgets. The
>   ttk paned window does not have a paneconfigure subcommand but we
>   can set the sash position once the widget gets mapped.

Thanks.  I folded that into your "Use themed tk widgets" patch and
applied it on the dev branch.  There's still one little thing that
doesn't look quite right: the .tf.lbar.gdttype drop-down list
initially comes up empty (it should start out saying "containing") and
it is also a little too short.  How do we fix that?

Paul.
