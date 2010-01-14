From: Rudolf Polzer <divVerent@alientrap.org>
Subject: Re: [PATCH] git push --track
Date: Thu, 14 Jan 2010 08:03:16 +0100
Message-ID: <20100114070316.GC1528@rm.endoftheinternet.org>
References: <op.u6g8jnixg402ra@nb-04> <be6fef0d1001131727r128c7727td2b948018d308719@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 08:22:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVK1q-0004uD-7A
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 08:22:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756346Ab0ANHVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 02:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756278Ab0ANHVs
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 02:21:48 -0500
Received: from rm.endoftheinternet.org ([94.23.21.40]:56177 "EHLO
	r23604.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755021Ab0ANHVq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 02:21:46 -0500
Received: from rpolzer by r23604.ovh.net with local (Exim 4.69)
	(envelope-from <divVerent@alientrap.org>)
	id 1NVJjg-0006ut-Sp; Thu, 14 Jan 2010 08:03:17 +0100
Content-Disposition: inline
In-Reply-To: <be6fef0d1001131727r128c7727td2b948018d308719@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136959>

On Thu, Jan 14, 2010 at 09:27:26AM +0800, Tay Ray Chuan wrote:
> before I put up my comments on the patch, I wonder if git-push is the
> best place to add this feature, as git-push usually deals with
> "pushing" data to another repo.
> 
> I think git-branch would be a better place to do this.

I think git-branch can already do this: after pushing, you can do git branch -f
--track origin/mybranch.

But the goal of this is to postponing the decision to track to the push time,
and adding as little as possible extra commands/options to do this.
