From: Christopher Li <git@chrisli.org>
Subject: Re: CAREFUL! No more delta object support!
Date: Mon, 27 Jun 2005 19:58:57 -0400
Message-ID: <20050627235857.GA21533@64m.dyndns.org>
References: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 28 05:05:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dn6P5-0005uX-40
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 05:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbVF1DLq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Jun 2005 23:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbVF1DLp
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jun 2005 23:11:45 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:49044 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262490AbVF1DLl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2005 23:11:41 -0400
Received: from localhost.localdomain (c-24-6-236-77.hsd1.ca.comcast.net[24.6.236.77])
          by comcast.net (sccrmhc12) with ESMTP
          id <2005062803114101200her7ue>; Tue, 28 Jun 2005 03:11:41 +0000
Received: by localhost.localdomain (Postfix, from userid 1027)
	id C98423F17F; Mon, 27 Jun 2005 19:58:57 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 27, 2005 at 06:14:40PM -0700, Linus Torvalds wrote:
> 
> The reason? The new git understands packed files natively, which ends up 
> being a much bigger win in many many ways.

Interesting. I take a look at your change, it still support delta object
inside the pack file right? For a second I am wondering you drop the delta
feature completely.

Chris
