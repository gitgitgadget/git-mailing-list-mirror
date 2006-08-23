From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Fix a comparison bug in diff-delta.c
Date: Tue, 22 Aug 2006 23:17:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608222311060.3683@localhost.localdomain>
References: <1156300368160-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 23 05:17:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFjFD-0003Lb-3k
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 05:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWHWDRZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 23:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWHWDRZ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 23:17:25 -0400
Received: from relais.videotron.ca ([24.201.245.36]:19523 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932309AbWHWDRZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 23:17:25 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J4F00E3YL50WZ90@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 22 Aug 2006 23:17:24 -0400 (EDT)
In-reply-to: <1156300368160-git-send-email-madcoder@debian.org>
X-X-Sender: nico@localhost.localdomain
To: Pierre Habouzit <madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25891>

On Wed, 23 Aug 2006, Pierre Habouzit wrote:

> (1 << i) < hspace is compared in the `int` space rather that in the unsigned one.
> the result will be wrong if hspace is between  0x40000000 and 0x80000000.
> 
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>

Could you use (1u << i) instead of (unsigned)(1 << i) ?  That looks 
prettier to me at least.


Nicolas
