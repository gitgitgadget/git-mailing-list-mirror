From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 04/10] Migrate git-clone to use git-rev-parse --parseopt
Date: Tue, 06 Nov 2007 14:04:07 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0711061355330.21255@xanadu.home>
References: <1194172262-1563-1-git-send-email-madcoder@debian.org>
 <1194172262-1563-2-git-send-email-madcoder@debian.org>
 <1194172262-1563-3-git-send-email-madcoder@debian.org>
 <1194172262-1563-4-git-send-email-madcoder@debian.org>
 <1194172262-1563-5-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Nov 06 20:04:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpTir-00029Q-At
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 20:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756160AbXKFTEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 14:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754045AbXKFTEJ
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 14:04:09 -0500
Received: from relais.videotron.ca ([24.201.245.36]:28969 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbXKFTEI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 14:04:08 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JR3003NWMAVV0X0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 06 Nov 2007 14:04:07 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <1194172262-1563-5-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63702>

On Sun, 4 Nov 2007, Pierre Habouzit wrote:

> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>  git-clone.sh |  102 +++++++++++++++++++++++++++++++++-------------------------
>  1 files changed, 58 insertions(+), 44 deletions(-)

Well, this patch was merged in "next" and broke git-clone rather badly.

Just try something as fundamental as this:

	$ git clone git://git.kernel.org/pub/scm/git/git.git
	fatal: Not a git repository

Don't we have test cases covering this really basic operation?


Nicolas
