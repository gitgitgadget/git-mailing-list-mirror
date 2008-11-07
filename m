From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (GITK) v3 4/6] gitk: Make cherry-pick call git-citool on conflicts.
Date: Fri, 7 Nov 2008 22:51:43 +1100
Message-ID: <18708.11215.667112.83201@cargo.ozlabs.ibm.com>
References: <1225652389-22082-1-git-send-email-angavrilov@gmail.com>
	<1225652389-22082-2-git-send-email-angavrilov@gmail.com>
	<1225652389-22082-3-git-send-email-angavrilov@gmail.com>
	<1225652389-22082-4-git-send-email-angavrilov@gmail.com>
	<1225652389-22082-5-git-send-email-angavrilov@gmail.com>
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
	id 1KyPuK-0003HL-Ei
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 12:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbYKGLwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 06:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752237AbYKGLwI
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 06:52:08 -0500
Received: from ozlabs.org ([203.10.76.45]:52044 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751844AbYKGLwF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 06:52:05 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id C68D5DDE19; Fri,  7 Nov 2008 22:52:03 +1100 (EST)
In-Reply-To: <1225652389-22082-5-git-send-email-angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100306>

Alexander Gavrilov writes:

> Now that git-gui has facilities to help users resolve
> conflicts, it makes sense to launch it from other GUI
> tools when they happen.

The resolution capabilities of git citool seem to be that it detects
the conflict markers and lets you run meld on the 3 versions.  Have I
missed anything there?  Do people find that fixing things manually in
meld is sufficient, or do we really want something more powerful?

Paul.
