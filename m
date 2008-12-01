From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (GITK FIX)] gitk: Fix the "notflag: no such variable" error in --not processing.
Date: Tue, 2 Dec 2008 09:45:57 +1100
Message-ID: <18740.26917.872035.57458@cargo.ozlabs.ibm.com>
References: <4933F819.1010701@viscovery.net>
	<49341101.8050400@viscovery.net>
	<200812012025.25286.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 00:19:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7I2m-0005OS-0L
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 00:19:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251AbYLAXRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 18:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbYLAXRq
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 18:17:46 -0500
Received: from ozlabs.org ([203.10.76.45]:38378 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751111AbYLAXRp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 18:17:45 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id DDFE1DDDFB; Tue,  2 Dec 2008 10:17:44 +1100 (EST)
In-Reply-To: <200812012025.25286.angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102082>

Alexander Gavrilov writes:

> This patch initializes it. Note that actually it is also possible to
> remove it completely, because currently nobody uses the value.

Thanks.  I actually committed a change to remove it completely.

Paul.
