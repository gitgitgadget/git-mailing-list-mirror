From: Paul Mackerras <paulus@samba.org>
Subject: Re: [GITK PATCH v2] Add menu accelerators
Date: Tue, 21 Oct 2008 10:21:58 +1100
Message-ID: <18685.4758.877209.908423@cargo.ozlabs.ibm.com>
References: <1223532590-8706-1-git-send-email-robin.rosenberg@dewire.com>
	<18681.53866.855255.688290@cargo.ozlabs.ibm.com>
	<200810200000.33035.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 01:36:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks45x-0001X9-Q1
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 01:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753875AbYJTXWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 19:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753927AbYJTXWP
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 19:22:15 -0400
Received: from ozlabs.org ([203.10.76.45]:48472 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753643AbYJTXWN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 19:22:13 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id F0576DDE06; Tue, 21 Oct 2008 10:22:04 +1100 (EST)
In-Reply-To: <200810200000.33035.robin.rosenberg@dewire.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98742>

Robin Rosenberg writes:

> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>  gitk |   80 +++++++++++++++++++++++++++++++++---------------------------------
>  1 files changed, 40 insertions(+), 40 deletions(-)
> 
> This one is slightly better than the first one.  Works with gitk id...id too.

With that patch, I'm finding that pressing Alt-f pops up the File
menu, but also triggers the binding for 'f' in the main window (scroll
diff window to the next file), which is annoying.  I'm not sure why, I
will need to track that down.

Paul.
